<?
/*
 * The progress bar in PHP was contributed by
 * Mike Hodgson
 */
	// Edit these to wherever your temporary files are stored.

	require_once( '../bit_setup_inc.php' );

	$gigaConfig = get_gigaupload_config();

	$infoFile = $gigaConfig['giga_tmp_dir']."/".$_REQUEST['giga_session']."_flength";
	$progressFile = $gigaConfig['giga_tmp_dir']."/".$_REQUEST['giga_session']."_fread";
	$signalFile = $gigaConfig['giga_tmp_dir']."/".$_REQUEST['giga_session']."_signal";
	function hms($sec) {
		$thetime = str_pad(intval(intval($sec) / 3600),2,"0",STR_PAD_LEFT).":". str_pad(intval(($sec / 60) % 60),2,"0",STR_PAD_LEFT).":". str_pad(intval($sec % 60),2,"0",STR_PAD_LEFT) ;
		return $thetime;
	}

	$started = TRUE;
	$percent_done = 0;
	$total_size = file_exists( $infoFile ) ? file_get_contents( $infoFile ) : 0;
	$start_time = !empty( $_GET['start_time'] ) ? $_GET['start_time'] : 0;
	$time_now = time();

	if ($total_size == 0) {
		$started = FALSE;
	}
	if ($started == TRUE) {
		if ($start_time == 0) {
			$start_time = $time_now;
		}
		$time_elapsed = $time_now - $start_time;
		if ($time_elapsed == 0) {
			$time_elapsed = 1;
		}
		$current_size = file_get_contents( $progressFile );
		
		$percent_done = sprintf("%.0f",($current_size / $total_size) * 100);
		$speed = ($current_size / $time_elapsed);
		if ($speed == 0) {
			$speed = 1024;
		}
		$time_remain_str = hms(($total_size-$current_size) / $speed);
		$time_elapsed_str = hms($time_elapsed);
	}
	header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
	header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Pragma: no-cache"); // HTTP/1.0

?>
<html><head>
<title>File Upload Progress</title>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<?
	if( $percent_done < 100 ) {
?>
<meta http-equiv="refresh" content="1;<? echo $_SERVER['PHP_SELF']; ?>?total_size=<? echo $total_size; ?>&start_time=<? echo $start_time; ?>&giga_session=<? echo $_REQUEST['giga_session']; ?>">
<?
	}
?>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#eeeeee">
  <table border=0 width="100%">
    <tr><TD align="center"  bgcolor="#ecf8ff">File Upload In Progress</td></tr>
	  <tr><td>
		<? if( file_exists( $signalFile ) ) { ?>
			Upload Complete!
		<? } elseif ($started) { ?>
      	 <table border=0 width='100%'>
		  <tr>
		   <td>
			 <table width="<? echo $percent_done; ?>%"  height="100%"  bgcolor='red'>
 			   <tr><td width='100%' style="height: 20px"> </td></tr>
		     </table>
		   </td>
          </tr>
        </table>
      <? echo $current_size; ?>/<? echo $total_size; ?> (<? echo $percent_done; ?>%) <? echo printf("%.2f",$speed); ?> kbit/s<br>
      Time Elapsed: <? echo $time_elapsed_str; ?><br>
	  Time Remaining: <? echo $time_remain_str; ?></td>
	  <? } else { ?>
	  Waiting for file upload to begin...
	  <? } ?>
  </tr>
</table>
</body>
</html>
