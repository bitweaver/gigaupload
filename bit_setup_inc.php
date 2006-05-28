<?php
	global $gBitSystem;
	$registerHash = array(
		'package_name' => 'gigaupload',
		'package_path' => dirname( __FILE__ ).'/',
	);
	$gBitSystem->registerPackage( $registerHash );
	
	if( $gBitSystem->isPackageActive( GIGAUPLOAD_PKG_NAME ) ) {
	
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
		
		function get_gigaupload_id() {
			global $gBitUser;
			static $sessionId; // keep same sessionId so it can be used in multiple .tpl's easily
			if( empty( $sessionId ) ) {
				$sessionId = $gBitUser->mUserId.'_'.md5( uniqid( rand() ) );
			}
			return( $sessionId );
		}
		$gBitSmarty->register_function( 'gigaupload_id', 'get_gigaupload_id', FALSE );
	}
?>
