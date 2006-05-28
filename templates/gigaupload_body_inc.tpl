<div class="row">
	{formlabel label="Upload Files"}
	{forminput}
		<input name="gigaupload[]" type="file" /><br />
		<input name="gigaupload[]" type="file" /><br />
		<input name="gigaupload[]" type="file" /><br />
		<div id="gigaslots"></div>
		<input type="button" value="{tr}Add upload slot{/tr}" onclick="addUploadSlot();" /><br /><br />
		<br />
		{if $gBitSystem->isFeatureActive( 'xupload_use_popup' )}
			<input type="hidden" name="popup" id="popup" />
		{else}
			<input type="hidden" name="inline" id="inline" />
		{/if}
		<input type="hidden" id="url_post" name="url_post" value="{$smarty.server.PHP_SELF}" />
		<div id="gigauploadinline"></div>
		</div>
	{/forminput}
</div>
