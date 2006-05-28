<html>
<head>
<title>File Upload Progress</title>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE" />
{if $percentDone < 100}
<meta http-equiv="refresh" content="1;{$smarty.server.PHP_SELF}?total_size={$totalSize}&amp;start_time={$startTime}&amp;giga_session={$smarty.request.giga_session}" />
{/if}
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

{include file="bitpackage:gigaupload/gigaupload_progress_inc.tpl"}

</body>
</html>
