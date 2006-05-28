<h2>File Upload In Progress</h2>

{if $signalExists}
	Upload Complete!
{elseif $currentSize}
	{$currentSize} / {$totalSize}
	
	<div class="gigaprogress" style="clear:both">
		<div style="float:left;">({$percentDone}%) {$speed|round:2} kbit/s </div>
		<div style="width:{$percentDone}%;background:red" class="gigaprogressbar">&nbsp;</div>
	</div>

	Time Elapsed: {$timeElapsedStr}<br>
	Time Remaining: {$timeRemainStr}
	
{else}
	Waiting for file upload to begin...
{/if}
