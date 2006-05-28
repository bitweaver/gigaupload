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
	
	$gBitSmarty->assign( 'signalExists', file_exists( $signalFile ) );
	
	function hms($sec) {
		$thetime = str_pad(intval(intval($sec) / 3600),2,"0",STR_PAD_LEFT).":". str_pad(intval(($sec / 60) % 60),2,"0",STR_PAD_LEFT).":". str_pad(intval($sec % 60),2,"0",STR_PAD_LEFT) ;
		return $thetime;
	}

	$percentDone = 0;
	$totalSize = file_exists( $infoFile ) ? file_get_contents( $infoFile ) : 0;
	$startTime = !empty( $_GET['start_time'] ) ? $_GET['start_time'] : 0;
	$timeNow = time();

	if( $totalSize > 0 ) {
		if ($startTime == 0) {
			$startTime = $timeNow;
		}
		$timeElapsed = $timeNow - $startTime;
		if ($timeElapsed == 0) {
			$timeElapsed = 1;
		}
		$currentSize = file_get_contents( $progressFile );
		
		$percentDone = round( $currentSize / $totalSize * 100 );
		$speed = ($currentSize / $timeElapsed);
		if ($speed == 0) {
			$speed = 1024;
		}

		$gBitSmarty->assign( 'kbitSpeed', sprintf("%.2f",$speed) );		
		$gBitSmarty->assign( 'speed', $speed );		
		$gBitSmarty->assign( 'startTime', $startTime );
		$gBitSmarty->assign( 'percentDone', $percentDone );
		$gBitSmarty->assign( 'timeRemainStr', hms(($totalSize-$currentSize) / $speed) );
		$gBitSmarty->assign( 'timeElapsedStr', hms($timeElapsed) );
		$gBitSmarty->assign( 'currentSize', $currentSize );
		$gBitSmarty->assign( 'totalSize', $totalSize );
	}
	
	if( $gBitSystem->isAjaxRequest() ) {
		print $gBitSmarty->fetch( 'bitpackage:gigaupload/gigaupload_progress.tpl' );
	} else {

		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
		header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
		header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
		header("Pragma: no-cache"); // HTTP/1.0
		
		print $gBitSmarty->fetch( 'bitpackage:gigaupload/gigaupload_progress.tpl' );
	}

?>
