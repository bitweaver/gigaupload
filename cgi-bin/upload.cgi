#!/usr/local/bin/perl -w

# bitweaver gigauploader
# A sliced and diced version of PHP File Uploader with progress bar Version 1.43
# Copyright (C) Raditha Dissanyake 2003 http://www.raditha.com

# Licence:
# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
#
# Software distributed under this License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Initial Developer of the Original Code is Raditha Dissanayake.
# Portions created by Raditha are Copyright (C) 2003
# Raditha Dissanayake. All Rights Reserved.
#

# CHANGES:
# As of version 1.00 cookies were abolished!
# as of version 1.02 stdin is no longer set to non blocking.
# 1.40 - POST is no longer required and processing is more efficient.
#	Please refer online docs  for details.
# 1.42 - The temporary locations were changed, to make it easier to
#	clean up afterwards.
# 1.45.
#   Changed the way in which the file list is passed to the php handler

use CGI;
use Fcntl qw(:DEFAULT :flock);
use File::Temp qw/ tempfile tempdir /;
use Carp;

@qstring=split(/&/,$ENV{'QUERY_STRING'});
@p1 = split(/=/,$qstring[0]);
$giga_session = $p1[1];
$giga_session =~ s/[^-a-zA-Z0-9_]//g;  # sanitized as suggested by Terrence Johnson.

$path = $ENV{SCRIPT_FILENAME};
$path =~ s/upload\.cgi//g;

my $CONFIG = {};
open( CONFIGFILE, $path."config.cgi" ) or die "could not open config file : $! : ".$path."config.cgi";
<CONFIGFILE>; # skip first /usr/bin/perl line
while( <CONFIGFILE> ) {
	$_ =~ s/^#//;
	my( $var, $value ) = split(/=/);
	chomp( $var );
	if( $value ) {
		chomp( $value );
		$CONFIG{$var} = $value;
	}
}
close( CONFIGFILE );

# don't change the next few lines unless you have a very good reason to.
$monitor_file = $CONFIG{'giga_tmp_dir'}."/$giga_session"."_flength";
$progress_file = $CONFIG{'giga_tmp_dir'}."/$giga_session"."_fread";
$signal_file = $CONFIG{'giga_tmp_dir'}."/$giga_session"."_signal";
$qstring_file = $CONFIG{'giga_tmp_dir'}."/$giga_session"."_qstring";

$content_type = $ENV{'CONTENT_TYPE'};
my $len = $ENV{'CONTENT_LENGTH'};
$bRead=0;
$|=1;

sub bye_bye {
	$mes = shift;
	print "Content-type: text/html\n\n";
	print "<br>$mes<br>\n";

	exit;
}

# see if we are within the allowed limit.
# carp "$len > $max_upload\n";
if( $CONFIG{'giga_max_upload'} && $len > $CONFIG{'giga_max_upload'})
{
	close (STDIN);
	bye_bye("The maximum upload size has been exceeded");
}

#
# The thing to watch out for is file locking. Only
# one thread may open a file for writing at any given time.
#
if (-e "$signal_file") {
	unlink("$signal_file");
}
if (-e "$monitor_file") {
	unlink("$monitor_file");
}


sysopen(FH, $monitor_file, O_RDWR | O_CREAT)
	or die "can't open numfile $monitor_file: $! :".$monitor_file;

# autoflush FH
$ofh = select(FH); $| = 1; select ($ofh);
flock(FH, LOCK_EX)
	or die "can't write-lock numfile: $!";
seek(FH, 0, 0)
	or die "can't rewind numfile : $!";
print FH $len;
close(FH);

#
# read and store the raw post data on a temporary file so that we can
# pass it though to a CGI instance later on.
#
$total_read = 0;
$last_read = 0;
$last_file = 'empty';
$cgi = CGI->new(\&hook,$data);
sub hook
{
	my ($filename, $buffer, $bRead, $data) = @_;
	if( $filename ne $last_file ) {
		# handle multiple file uploads
		$total_read += $last_read;
		$last_file = $filename;
	}
	$last_read = $bRead;
	$aggregate_read = $bRead + $total_read;
#	carp  "Read $bRead bytes of $filename\n";         
	open(TMP,">","$progress_file") or &bye_bye ("can't open progress file: $! : $progress_file");
	flock(TMP, LOCK_EX);
	print TMP $aggregate_read;
	close TMP;
	if( $CONFIG{'throttle_delay'} ) {
		select(undef, undef, undef, $CONFIG{'throttle_delay'});	# sleep for fraction of a second. will throttle connection
	}
}

#
# We don't want to decode the post data ourselves. That's like
# reinventing the wheel. If we handle the post data with the perl
# CGI module that means the PHP script does not get access to the
# files, but there is a way around this.
#
# We can ask the CGI module to save the files, then we can pass
# these filenames to the PHP script. In other words instead of
# giving the raw post data (which contains the 'bodies' of the
# files), we just send a list of file names.
#
my $postActionUrl = 0;
my $qstring="";
my %vars = $cgi->Vars;
my $j=0;

while(($key,$value) = each %vars)
{
	# carp "$key => $value";
	$file_upload = $cgi->param($key);
	if(defined $value && $value ne '') {
		my $fh = $cgi->upload($key);
		if(defined $fh) {
			#carp $fh;
			($tmp_fh, $tmp_filename) = tempfile();

			while(<$fh>) {
				print $tmp_fh $_;
			}

			close($tmp_fh);

			$fsize =(-s $fh);

			$type = $cgi->uploadInfo($fh)->{'Content-Type'};

			$fh =~ s/([^a-zA-Z0-9_\-.])/uc sprintf("%%%02x",ord($1))/eg;
			$tmp_filename =~ s/([^a-zA-Z0-9_\-.])/uc sprintf("%%%02x",ord($1))/eg;
			$qstring .= "gigafile[$j][name]=$fh&gigafile[$j][size]=$fsize&";
			$qstring .= "gigafile[$j][tmp_name]=$tmp_filename&gigafile[$j][type]=$type&";
			$j++;
		} else {
			$value =~ s/([^a-zA-Z0-9_\-.])/uc sprintf("%%%02x",ord($1))/eg;
			$qstring .= "$key=$value&" ;
		}
	}
}

open (QSTR,">", "$qstring_file") or die "can't open output file";
print QSTR $qstring;
close (QSTR);

open (SIGNAL,">", $signal_file);
print SIGNAL "\n";
close (SIGNAL);
carp $postActionUrl;
#my $postUrl = $cgi->param('giga_post_url') || $CONFIG{'giga_post_url'};
if( $cgi->param( 'giga_post_action' ) ) {
#	$postUrl = $ENV{REQUEST_URI};
#	$postUrl =~ s/cgi-bin\/upload\.cgi//g;
	print "Location: ".$cgi->param( 'giga_post_action' )."?giga_post=1&giga_session=".$giga_session."\n\n";
}

exit;
