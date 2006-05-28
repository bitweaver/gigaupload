{include file="bitpackage:gigaupload/gigaupload_form_inc.tpl"}

<h2>File uploader</h2>

{section name=ix loop=$gigafiles.size|count}
<div>{$gigafiles.name[ix]}<br/>{$gigafiles.size[ix]}</div>
{/section}


{if $gBitSystem->isPackageActive( 'gigaupload' )}
	{include file="bitpackage:gigaupload/gigaupload_form_inc.tpl"}
	{assign var=id value="gigauploadform"}
	{assign var=onsubmit value="return startGigaUpload();"}

<p>
Use this form to upload some files and check out the functionality of the uploader.
</p>
<p>If you use a file that is too small the progress bar may not have enough time to display itself,
specially if you are on a high speed connection.
</p>


{form onSubmit=$onsubmit action=$action enctype="multipart/form-data" id=gigauploadform 
legend=$gigauploadLegend|default:"Upload Files"}
<div id="uploadform">
	{include file="bitpackage:gigaupload/gigaupload_body_inc.tpl"}
	
	<div class="row submit">
			<input type="submit" id="submitbutton" value="Upload">
	</div>
</div>
{/form}

{*
<div class="row">
	{forminput}
	<table border=0 align="left" cellpadding=3>
		<tr><td><input type="file" name="gigafile[0]"></td></tr>
		<tr><td><input type="file" name="gigafile[1]"></td></tr>
		<tr><td><input type="file" name="gigafile[2]"></td></tr>
		<tr><td><input type="file" name="gigafile[3]"></td></tr>
		<tr><td><input type="file" name="gigafile[4]"></td></tr>
		<tr><td><input type="file" name="gigafile[5]"></td></tr>
		<tr><td><input type="file" name="gigafile[6]"></td></tr>
		<tr><td><input type="file" name="gigafile[7]"></td></tr>
		<tr><td><input type="file" name="gigafile[8]"></td></tr>
		<tr><td><input type="file" name="gigafile[9]"></td></tr>
	</table>	
	{/forminput}
</div>
*}

{/if}
