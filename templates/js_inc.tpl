{* preload image *}
{biticon ipackage="icons" iname="busy" iexplain=Busy style="position:absolute; top:-500px; left:-500px;" iforce=icon}
<iframe name="gigaiframe" id="gigaiframe" style="border: 0;width:0px; height:0px;"></iframe>

<script type="text/javascript">
/* <![CDATA[ */
{literal}
var pu = null;
function startGigaUpload( pForm ) {
	disableSubmit('submitbutton');
    progressUrl = "{/literal}{$smarty.const.GIGAUPLOAD_PKG_URL}{literal}progress.php";
    parameters = "&giga_session="+$('gigasession').value +"&post_url={/literal}{$smarty.server.PHP_SELF}{literal}";
	pForm.submit();

	hideById('uploadblock');
	if( $('gigaprogresspopup') ) {
	    popUpWin(progressUrl+'?'+parameters,"standard",460,200);
	} else {
		showById('gigaprogress');
		var pb = $("gigaprogressbar");
		pu = new Ajax.PeriodicalUpdater(pb,progressUrl,{
			'asynchronous':true,
			'decay': 2,
			'frequency' : 3,
			'method': 'post',
			'parameters': parameters,
			'evalScripts': true
			}
		)
	}
	return true;
}

var slots = 10;
function addUploadSlot() {
	slots++;
	var newInput = document.createElement('input');
	newInput.setAttribute( 'name', slots );
	newInput.setAttribute( 'type', 'file' );
	document.getElementById('newgigaslot').appendChild( newInput );
}

function updateProgress(pb,req) {
		pb.innerHTML=req.responseText;
//		parent.location.href={/literal}"{$postUrl|default:$smarty.server.PHP_SELF}" + "?giga_post=1&giga_session={$smarty.request.giga_session}{literal}";
}
function stopProgress() {
	if( pu ) {
		pu.stop();
	}
}

function updateFailure(pb,req) {
	var mes = req.responseText;
	pb.style.width=0;
	alert(mes);
	uploads_in_progress = uploads_in_progress - 1;
}


{/literal}
/* ]]> */
</script>
