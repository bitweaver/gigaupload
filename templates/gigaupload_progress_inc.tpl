{if $signalExists}
<script type="text/javascript">
	parent.location.href="{$postUrl|default:$smarty.server.PHP_SELF}"+"?giga_post=1&giga_session={$smarty.request.giga_session}";
</script>
{elseif $currentSize}
<h2>File Upload In Progress</h2>
	{$currentSize} / {$totalSize}
	
	<div class="gigaprogress" style="clear:both">
		<div style="float:left;">({$percentDone}%) {$speed|round:2} kbit/s </div>
		<div style="width:{$percentDone}%;background:red" class="gigaprogressbar">&nbsp;</div>
	</div>

	<div style="clear:both">
	Time Elapsed: {$timeElapsedStr}<br>
	Time Remaining: {$timeRemainStr}
	</div>
	
{else}
	Waiting for file upload to begin...
{/if}
