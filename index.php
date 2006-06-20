<?

# PHP File Uploader with progress bar Version 1.12
# Copyright (C) Raditha Dissanyake 2003
# http://www.raditha.com

# Licence:
# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Initial Developer of the Original Code is Raditha Dissanayake.
# Portions created by Raditha are Copyright (C) 2003
# Raditha Dissanayake. All Rights Reserved.
#

# CHANGES:
# 1.00 cookies were abolished!
# 1.20 changed the form submit mechanism to filter for certain types
#      of files

require_once( '../bit_setup_inc.php' );

$gBitSmarty->assign( 'sid', $gBitUser->mUserId.'_'.md5(uniqid(rand())) );
	/*
	 * if your php installation cannot produce md5 hashes delete the above line and
	 * uncomment the line below.
	 *
	 * $sid = urlencode(uniqid(rand()));
	 */

/*
 * improved user interface contributed by Rad Inks
 * http://www.radinks.com/
 */

gigaupload_smarty_setup( GIGAUPLOAD_PKG_URL );
if( !empty( $_FILES ) ) {
	$gBitSmarty->assign( 'gigafiles', $_FILES );
}

$gBitSystem->display( 'bitpackage:gigaupload/generic.tpl', 'Upload Files' );

	//include("../inc/head.php");

?>
