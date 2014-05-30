<input type="hidden" id="giga_post_url" name="giga_post_url" value="{$smarty.server.SCRIPT_NAME}" />
<input type="hidden" id="gigasession" name="giga_session" value="{giga_session}" />
{$gigaPostAction}

<div class="form-group" id="gigauploadblock">
	{formlabel label=$giga_label|default:"Upload Files"}
	{forminput}
		<input style="float:right" type="button" value="{tr}Add upload slot{/tr}" onclick="addUploadSlot();" />
		{section name=foo loop=$giga_slot_count|default:10}
		<input name="{$giga_input_name}{$smarty.section.foo.iteration}" type="file" /><br />
		{/section}
		<span id="newgigaslot"></span>
		{if $giga_form_help}
			{formhelp note=$giga_form_help}
		{/if}
	{/forminput}
</div>
