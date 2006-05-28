<input type="hidden" id="giga_post_url" name="giga_post_url" value="{$smarty.server.PHP_SELF}" />
<input type="hidden" id="gigasession" name="giga_session" value="{giga_session}" />

<div class="row" id="gigauploadblock">
	{formlabel label="Upload Files"}
	{forminput}
		<div id="gigaslots"></div>
		<input name="gigaupload[2]" type="file" /><br />
		<input name="gigaupload[1]" type="file" /><br />
		<input name="gigaupload[0]" type="file" /><br />
		<input type="button" value="{tr}Add upload slot{/tr}" onclick="addUploadSlot();" /><br /><br />
		<br />
		{if $gBitSystem->isFeatureActive( 'xupload_use_popup' )}
			<input type="hidden" name="popup" id="popup" />
		{else}
			<input type="hidden" name="inline" id="inline" />
		{/if}
		
		<iframe name="gigaiframe" id="gigaiframe" style="border: 0;width:0px; height:0px;"></iframe>
		
	{/forminput}
</div>
