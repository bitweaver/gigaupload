<input type="hidden" id="giga_post_url" name="giga_post_url" value="{$smarty.server.PHP_SELF}" />
<input type="hidden" id="gigasession" name="giga_session" value="{giga_session}" />
{$gigaPostAction}

<div class="row" id="gigauploadblock">
	{formlabel label="Upload Files"}
	{forminput}
		<input size="35" name="9" type="file" /><br />
		<input size="35" name="8" type="file" /><br />
		<input size="35" name="7" type="file" /><br />
		<input size="35" name="6" type="file" /><br />
		<input size="35" name="5" type="file" /><br />
		<input size="35" name="4" type="file" /><br />
		<input size="35" name="3" type="file" /><br />
		<input size="35" name="2" type="file" /><br />
		<input size="35" name="1" type="file" /><br />
		<input size="35" name="0" type="file" /><br />
		<span id="newgigaslot"></span>
		<input type="button" value="{tr}Add upload slot{/tr}" onclick="addUploadSlot();" /><br /><br />
		<br />
	{/forminput}
</div>
