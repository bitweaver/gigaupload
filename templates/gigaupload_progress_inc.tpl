{if $signalExists}
<script type="text/javascript">
	stopProgress();
	parent.location.href="{$postUrl|default:$smarty.server.PHP_SELF}"+"?giga_post=1&giga_session={$smarty.request.giga_session}";
</script>
{elseif $currentSize}
<h2>File Upload In Progress</h2>
	{$currentSize} / {$totalSize} ({$percentDone}%) @ {$kbitSpeed} kbit/s 
	
	<div class="gigaprogress" style="clear:both">
		<div style="float:left;"></div>
		<div style="width:{$percentDone}%;background:#D1FFA3" class="gigaprogressbar">&nbsp;</div>
	</div>

	<div style="clear:both">
	Time Elapsed: {$timeElapsedStr}<br>
	Time Remaining: {$timeRemainStr}
	</div>
	
{else}
	Waiting for file upload to begin...
{/if}
