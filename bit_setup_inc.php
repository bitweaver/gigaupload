<?php
global $gBitSystem;
$registerHash = array(
	'package_name' => 'gigaupload',
	'package_path' => dirname( __FILE__ ).'/',
);
$gBitSystem->registerPackage( $registerHash );

if( $gBitSystem->isPackageActive( GIGAUPLOAD_PKG_NAME ) ) {

	function gigapload_smarty_setup( $pPostUrl ) {
		global $gBitSmarty, $gBitSystem, $gSniffer;
		$gigaAction = $gBitSystem->getConfig( 'gigaupload_cgi_url', GIGAUPLOAD_PKG_URL.'cgi-bin/' ).'upload.cgi?giga_session='.get_giga_session_id();
		$gBitSmarty->assign( 'loadAjax', TRUE );
		$gBitSmarty->assign( 'target', "upload" );
		$gBitSmarty->assign( 'onSubmit', "return startGigaUpload(this);" );
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

	function get_giga_session_id() {
		global $gBitUser;
		static $sessionId; // keep same sessionId so it can be used in multiple .tpl's easily
		if( empty( $sessionId ) ) {
			$sessionId = $gBitUser->mUserId.'_'.md5( uniqid( rand() ) );
		}
		return( $sessionId );
	}
	$gBitSmarty->register_function( 'giga_session', 'get_giga_session_id', FALSE );

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
		}
	}
	
}
?>
