<html>
<head>
	<title>File Upload Progress</title>
	{include file="bitpackage:themes/header_inc.tpl"}
	<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE" />
	{if !$signalExists}
		<meta http-equiv="refresh" content="3;{$smarty.server.SCRIPT_NAME}?total_size={$totalSize}&amp;start_time={$startTime}&amp;giga_session={$smarty.request.giga_session}&amp;started={$smarty.request.started}&amp;post_url={$smarty.request.post_url|escape:url}" />
	{else}
<script type="text/javascript">/*<![CDATA[*/
	var postUrl = "{$postUrl|default:$smarty.server.SCRIPT_NAME}"+"?giga_post=1&giga_session={$smarty.request.giga_session}";
	{literal}
	function stopProgress() {
		if( opener && !opener.closed ) {
			//window.parent.window.location = postUrl;
			close();
		} else {
			window.open( postUrl );
		}
	}
	{/literal}
/*]]>*/</script>
	{/if}
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	{literal}
	<style type="css/text">/*<![CDATA[*/
		.row		{clear:both;}
		.formlabel	{float:left; width:14em; text-align:right;}
		.forminput	{margin-left:14.5em;}
	/*]]>*/</style>
	{/literal}
</head>
<body >
	{include file="bitpackage:gigaupload/progress_inc.tpl"}
</body>
</html>
