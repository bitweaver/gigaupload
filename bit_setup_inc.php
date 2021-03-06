<?php
$registerHash = array(
	'package_name' => 'gigaupload',
	'package_path' => dirname( __FILE__ ).'/',
);
$gBitSystem->registerPackage( $registerHash );

if( $gBitSystem->isPackageActive( GIGAUPLOAD_PKG_NAME ) ) {

	function gigaupload_smarty_setup( $pPostUrl ) {
		global $gBitSmarty, $gBitSystem, $gSniffer;
		$gigaAction = $gBitSystem->getConfig( 'gigaupload_cgi_url', GIGAUPLOAD_PKG_URL.'cgi-bin/' ).'upload.cgi?giga_session='.get_giga_session_id();
		// To ajax or not...
		switch( $gSniffer->_browser_info['browser'] ) {
			case 'mz':
			case 'ff':
			case 'op':
			case 'ca':
				global $gBitThemes;
				$gBitThemes->loadAjax( 'prototype' );
				$gBitSmarty->assign( 'onSubmit', "return startGigaUpload(this);" );
				$gBitSmarty->assign( 'target', "gigaiframe" );
				break;
			default:
				$gBitSmarty->assign( 'submitClick', "return startGigaUpload(this.form);" );
				$gBitSmarty->assign( 'gigaPopup', '<input type="hidden" name="giga_progress_popup" id="gigaprogresspopup" value="1" />' );
				$gBitSmarty->assign( 'gigaPostAction', '<input type="hidden" name="giga_post_action" id="gigapostaction" value="'.$pPostUrl.'" />' );
				break;
		}
		$gBitSmarty->assign( 'id', 'gigauploadform' );
		$gBitSmarty->assign( 'action', $gigaAction );
	}

	function get_gigaupload_config() {
		global $gBitSystem;
		$ret = array();
		$cfh = fopen( $gBitSystem->getConfig( 'gigaupload_cgi_dir', GIGAUPLOAD_PKG_PATH.'cgi-bin/' ).'config.cgi', 'r' );
		while( ($line = fgets( $cfh ) ) !== FALSE ) {
			@list( $key, $value ) = split( '=', trim( preg_replace( '/^#/', '', $line ) ) );
			if( $value ) {
				$ret[$key] = $value;
			}
		}
		return $ret;
	}
	
	// inline catch of gigaupload post, and manual stuffing of $_FILES
	if( !empty( $_REQUEST['giga_post'] ) && !empty( $_REQUEST['giga_session'] ) ) {
		$gigaConfig = get_gigaupload_config();
		$qStringFile = $gigaConfig['giga_tmp_dir'].'/'.$_REQUEST['giga_session']."_qstring";
		if( file_exists( $qStringFile ) ) {
			$qstr = join( "", file( $qStringFile ) );
			$_GIGAPOST = array();
			parse_str($qstr, $_GIGAPOST);
			if( !empty( $_GIGAPOST['gigafile'] ) ) {
				$_FILES = $_GIGAPOST['gigafile'];
				unset( $_GIGAPOST['gigafile'] );
			}
			$_REQUEST = array_merge( $_REQUEST, $_GIGAPOST );
			unlink( $qStringFile );
			foreach( array( 'fread', 'flength', 'signal' ) as $fileSuffix ) {
				$file = $gigaConfig['giga_tmp_dir'].'/'.$_REQUEST['giga_session'].'_'.$fileSuffix;
				if( file_exists( $file ) ) {
					unlink( $file );
				}
			}
		}
	}

	$gLibertySystem->registerService( LIBERTY_SERVICE_UPLOAD, GIGAUPLOAD_PKG_NAME, array(
			'content_edit_mini_tpl'		=> 'bitpackage:gigaupload/progress_container_inc.tpl',
			'content_upload_form_tpl'	=> 'bitpackage:gigaupload/service_upload_form.tpl',
			'content_upload_js_tpl'		=> 'bitpackage:gigaupload/js_inc.tpl',
	) );
}

	// These need to be declared even if the package is disabled so templates that might use these will still compile. 
	// They also have no code specific to gigaupload, so their declaration is harmless
	function get_giga_session_id() {
		global $gBitUser;
		static $sessionId; // keep same sessionId so it can be used in multiple .tpl's easily
		if( empty( $sessionId ) ) {
			$sessionId = $gBitUser->mUserId.'_'.md5( uniqid( rand() ) );
		}
		return( $sessionId );
	}

	$gBitSmarty->register_function( 'giga_session', 'get_giga_session_id', FALSE );
?>
