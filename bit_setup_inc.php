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
			$cfh = fopen( $gBitSystem->getConfig( 'gigaupload_cgi_dir', GIGAUPLOAD_PKG_PATH.'cgi-bin/config.cgi' ), 'r' );
			while( ($line = fgets( $cfh ) ) !== FALSE ) {
				@list( $key, $value ) = split( '=', trim( preg_replace( '/^#/', '', $line ) ) );
				if( $value ) {
					$ret[$key] = $value;
				}
			}
			return $ret;
		}
		
	}
?>
