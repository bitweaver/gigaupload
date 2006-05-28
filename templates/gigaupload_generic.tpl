<h1>File uploader</h1>

{if $gigafiles}
Files Uploaded:
<ol class="data">
{section name=ix loop=$gigafiles.size|count}
	<li class="item">{$gigafiles.name[ix]} / {$gigafiles.size[ix]} bytes / {$gigafiles.mime_type[ix]} </li>
{/section}
</ol>
{/if}

{if $gBitSystem->isPackageActive( 'gigaupload' )}
	{include file="bitpackage:gigaupload/gigaupload_js_inc.tpl"}
	{assign var=id value="gigauploadform"}
	{assign var=onsubmit value="return startGigaUpload(this);"}
	{assign var=target value="gigaiframe"}

<p>
Use this form to upload some files and check out the functionality of the uploader.
</p>
<p>If you use a file that is too small the progress bar may not have enough time to display itself,
specially if you are on a high speed connection.
</p>


{form onSubmit=$onsubmit action=$action enctype="multipart/form-data" id=$id target=$target legend=$gigauploadLegend|default:"Upload Files"}
<div id="uploadform">

	<div id="uploadblock">
	{include file="bitpackage:gigaupload/gigaupload_form_inc.tpl"}
	</div>
	
	{include file="bitpackage:gigaupload/gigaupload_progress_container_inc.tpl"}
	
	<div class="row submit">
		<input type="submit" id="submitbutton" value="Upload">
	</div>
</div>
{/form}

{/if}
