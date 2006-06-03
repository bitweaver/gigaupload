<html>
<head>
	<title>File Upload Progress</title>
	{include file="bitpackage:themes/header_inc.tpl"}
	<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE" />
	{if !$signalExists}
		<meta http-equiv="refresh" content="3;{$smarty.server.PHP_SELF}?total_size={$totalSize}&amp;start_time={$startTime}&amp;giga_session={$smarty.request.giga_session}&amp;post_url={$smarty.request.post_url}" />
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

	{if $signalExists}
		<script type="text/javascript">/*<![CDATA[*/
			var postUrl = "{$postUrl|default:$smarty.server.PHP_SELF}"+"?giga_post=1&giga_session={$smarty.request.giga_session}";
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
</body>
</html>
