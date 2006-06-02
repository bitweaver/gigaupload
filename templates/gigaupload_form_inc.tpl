<input type="hidden" id="giga_post_url" name="giga_post_url" value="{$smarty.server.PHP_SELF}" />
<input type="hidden" id="gigasession" name="giga_session" value="{giga_session}" />
{$gigaPostAction}

<div class="row" id="gigauploadblock">
	{formlabel label="Upload Files"}
	{forminput}
		<input name="gigaupload[9]" type="file" /><br />
		<input name="gigaupload[8]" type="file" /><br />
		<input name="gigaupload[7]" type="file" /><br />
		<input name="gigaupload[6]" type="file" /><br />
		<input name="gigaupload[5]" type="file" /><br />
		<input name="gigaupload[4]" type="file" /><br />
		<input name="gigaupload[3]" type="file" /><br />
		<input name="gigaupload[2]" type="file" /><br />
		<input name="gigaupload[1]" type="file" /><br />
		<input name="gigaupload[0]" type="file" /><br />
		<span id="newgigaslot"></span>
		<input type="button" value="{tr}Add upload slot{/tr}" onclick="addUploadSlot();" /><br /><br />
		<br />
		{if $gBitSystem->isFeatureActive( 'xupload_use_popup' )}
			<input type="hidden" name="popup" id="popup" />
		{else}
			<input type="hidden" name="inline" id="inline" />
		{/if}
		
	{/forminput}
</div>
