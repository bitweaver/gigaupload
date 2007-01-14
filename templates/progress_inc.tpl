{if $signalExists}
	<h2>{tr}File Upload Complete{/tr}</h2>

	<div class="row">
		{formlabel label="Progress"}
		{forminput}
			{$currentSize|display_bytes} / {$totalSize|display_bytes}
		{/forminput}
	</div>

	<div style="border:1px solid #ccc; background:#eee;" class="gigaprogress">
		<div style="width:{$percentDone}%;background:#f80; text-align:center; font-weight:bold;" class="gigaprogressbar">{$percentDone}%</div>
	</div>

	<br />
	<br />
	<br />

	<p class="gigaprocessing">
		{biticon ipackage="icons" iname="busy" iexplain=Busy iforce=icon}<br />{tr}Processing uploaded files. You should be redirected as soon as processing has been completed. If not, <a href="{$postUrl|default:$smarty.server.PHP_SELF}?giga_post=1&giga_session={$smarty.request.giga_session}"></a>{/tr}
	</p>

	<script type="text/javascript">
		stopProgress();
		location.href="{$postUrl|default:$smarty.server.PHP_SELF}"+"?giga_post=1&giga_session={$smarty.request.giga_session}";
	</script>
{elseif $currentSize}
	<h2>{tr}File Upload In Progress{/tr}</h2>

	<div class="row">
		{formlabel label="Progress"}
		{forminput}
			{$currentSize|display_bytes} / {$totalSize|display_bytes}
		{/forminput}
	</div>

	<div class="row">
		{formlabel label="Speed"}
		{forminput}
			{$kbitSpeed} kbit/s
		{/forminput}
	</div>

	<div class="row">
		{formlabel label="Time Elapsed"}
		{forminput}
			{$timeElapsedStr}
		{/forminput}
	</div>

	<div class="row">
		{formlabel label="Time Remaining"}
		{forminput}
			{$timeRemainStr}
		{/forminput}
	</div>

	<div style="border:1px solid #ccc; background:#eee;" class="gigaprogress">
		<div style="width:{$percentDone}%;background:#f80;padding:0.5em 0; text-align:center; font-weight:bold;" class="gigaprogressbar">{$percentDone}%</div>
	</div>
{else}
	{biticon ipackage="icons" iname="busy" iexplain=Busy iforce=icon} {tr}Waiting for file upload to begin&hellip;{/tr}
{/if}
