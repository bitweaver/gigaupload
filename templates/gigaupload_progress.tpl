<html>
<head>
<title>File Upload Progress</title>
{include file="bitpackage:themes/header_inc.tpl"}
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE" />
{if !$signalExists}
<meta http-equiv="refresh" content="3;{$smarty.server.PHP_SELF}?total_size={$totalSize}&amp;start_time={$startTime}&amp;giga_session={$smarty.request.giga_session}&amp;post_url={$smarty.request.post_url}" />
{/if}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body >

{if $signalExists}
<script type="text/javascript">
var postUrl = "{$postUrl|default:$smarty.server.PHP_SELF}"+"?giga_post=1&giga_session={$smarty.request.giga_session}";
{literal}
function stopProgress() {
	if( opener && !opener.closed ) {
//		window.parent.window.location = postUrl;
		close();
	} else {
		window.open( postUrl );
	}
}
{/literal}
</script>
{tr}Upload Complete.{/tr} 
<a href="{$postUrl}?giga_post=1&giga_session={$smarty.request.giga_session}">{tr}Continue{/tr} &raquo;</a>
{/if}

{include file="bitpackage:gigaupload/gigaupload_progress_inc.tpl"}

</body>
</html>
