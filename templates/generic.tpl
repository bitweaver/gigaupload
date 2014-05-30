<h1>File uploader</h1>

{if $gigafiles}
	Files Uploaded:
	<ol class="data">
		{section name=ix loop=$gigafiles}
			<li class="item">{$gigafiles[ix].name} / {$gigafiles[ix].size} bytes / {$gigafiles[ix].type} </li>
		{/section}
	</ol>
{/if}

{if $gBitSystem->isPackageActive( 'gigaupload' )}
	{include file="bitpackage:gigaupload/js_inc.tpl"}
	<p>Use this form to upload some files and check out the functionality of the uploader.</p>
	<p>If you use a file that is too small the progress bar may not have enough time to display itself, specially if you are on a high speed connection.</p>

	{form onsubmit=$onSubmit action=$action enctype="multipart/form-data" id=$id target=$target legend=$gigauploadLegend|default:"Upload Files"}
		<div id="uploadform">
			{$gigaPopup}

			<div id="uploadblock">
				{include file="bitpackage:gigaupload/form_inc.tpl"}
			</div>
			
			{include file="bitpackage:gigaupload/progress_container_inc.tpl"}
			
			<div class="form-group submit">
				<input type="submit" class="btn btn-default" id="submitbutton" value="Upload" {if $submitClick}onclick="{$submitClick}"{/if}/>
			</div>
		</div>
	{/form}
{/if}
