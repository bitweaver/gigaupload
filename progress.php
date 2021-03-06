<?php
/**
 * @version $Header$
 *
 * Copyright (c) 2007 bitweaver.org
 * All Rights Reserved. See below for details and a complete list of authors.
 * Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See http://www.gnu.org/copyleft/lesser.html for details
 * @author Mike Hodgson
 * 
 * @package gigupload
 * @subpackage functions
 */

/**
 * required setup
 */
require_once( '../kernel/setup_inc.php' );

	$gigaConfig = get_gigaupload_config();

	$infoFile = $gigaConfig['giga_tmp_dir']."/".$_REQUEST['giga_session']."_flength";
	$progressFile = $gigaConfig['giga_tmp_dir']."/".$_REQUEST['giga_session']."_fread";
	$signalFile = $gigaConfig['giga_tmp_dir']."/".$_REQUEST['giga_session']."_signal";
	if( !empty( $_REQUEST['post_url'] ) ) {
		$gBitSmarty->assign( 'postUrl', $_REQUEST['post_url'] );
	}
	
	$gBitSmarty->assign( 'signalExists', file_exists( $signalFile ) );
	
	function hms($sec) {
		$thetime = str_pad(intval(intval($sec) / 3600),2,"0",STR_PAD_LEFT).":". str_pad(intval(($sec / 60) % 60),2,"0",STR_PAD_LEFT).":". str_pad(intval($sec % 60),2,"0",STR_PAD_LEFT) ;
		return $thetime;
	}

	$percentDone = 0;
	$totalSize = file_exists( $infoFile ) ? file_get_contents( $infoFile ) : 0;
	$startTime = file_exists( $infoFile ) ? filemtime( $infoFile ) : 0;
	$timeNow = time();

	if( $totalSize > 0 && file_exists( $progressFile ) ) {
		// flag lets popup progress know uploading has begun to prevent "waiting to begin" after upload is finished
		$_REQUEST['started'] = TRUE;
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
		$gBitSmarty->assign( 'kbitSpeed', round($speed / 1000) );		
		$gBitSmarty->assign( 'speed', $speed );		
		$gBitSmarty->assign( 'startTime', $startTime );
		$gBitSmarty->assign( 'percentDone', $percentDone );
		$gBitSmarty->assign( 'timeRemainStr', hms(($totalSize-$currentSize) / $speed) );
		$gBitSmarty->assign( 'timeElapsedStr', hms($timeElapsed) );
		$gBitSmarty->assign( 'currentSize', $currentSize );
		$gBitSmarty->assign( 'totalSize', $totalSize );
	}
	
	if( $gBitThemes->isAjaxRequest() ) {
		print $gBitSmarty->fetch( 'bitpackage:gigaupload/progress_inc.tpl' );
	} else {

		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
		header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
		header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
		header("Pragma: no-cache"); // HTTP/1.0
		
		print $gBitSmarty->fetch( 'bitpackage:gigaupload/progress.tpl' );
	}

?>
