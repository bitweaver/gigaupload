<html>
<head>
<title>File Upload Progress</title>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE" />
{if !$signalExists}
<meta http-equiv="refresh" content="1;{$smarty.server.PHP_SELF}?total_size={$totalSize}&amp;start_time={$startTime}&amp;giga_session={$smarty.request.giga_session}&amp;post_url={$smarty.request.post_url}" />
{/if}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body >

{if $signalExists}
<script type="text/javascript">
	window.opener.location.href="{$postUrl|default:$smarty.server.PHP_SELF}"+"?giga_post=1&giga_session={$smarty.request.giga_session}";
</script>
{tr}Upload Complete.{/tr} 
<a href="{$postUrl}?giga_post=1&giga_session={$smarty.request.giga_session}">{tr}Continue{/tr} &raquo;</a>
{/if}

{include file="bitpackage:gigaupload/gigaupload_progress_inc.tpl"}

</body>
</html>
