{include file="bitpackage:gigaupload/gigaupload_form_inc.tpl"}

<h2>File uploader</h2>

{section name=ix loop=$gigafiles.size|count}
<div>{$gigafiles.name[ix]}<br/>{$gigafiles.size[ix]}</div>
{/section}

<form enctype="multipart/form-data" action="{$smarty.const.GIGAUPLOAD_PKG_URL}cgi-bin/upload.cgi?sid={$sid}" method="post">


<p>
Use this form to upload some files and check out the functionality of the uploader.
</p>
<p>If you use a file that is too small the progress bar may not have enough time to display itself,
specially if you are on a high speed connection.
</p>

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
<div class="row submit">
		<input type="hidden" name="sessionid" value="{$sid}">
		<input type="button" value="Send" onClick="gigaUpload();">
</div>

</form>
