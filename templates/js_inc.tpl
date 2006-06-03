{biticon ipackage=gigaupload iname=busy iexplain=Busy style="position:absolute; top:-500px; left:-500px;" iforce=icon}
<div id="gigaprogressdivcontainer" style="display:none; background:transparent url( {$smarty.const.GIGAUPLOAD_PKG_URL}icons/trans_bg.gif ) repeat; position:absolute; top:0; left:0; bottom:0; right:0; height:100%; width:100%;">
	<div id="gigaprogressdiv" style="background:#fff; border:2px solid #ccc; margin:20%; padding:1em;">{biticon ipackage=gigaupload iname=busy iexplain=Busy iforce=icon} {tr}Establishing Connection{/tr}&hellip;</div>
</div>

{* this iframe is required by moz browsers *}
<iframe src="about:blank" name="upload" frameborder="0" style="width:0; height:0; border:0;"></iframe>

<script type="text/javascript">
/* <![CDATA[ */
{literal}
// start fix for moz and netscape 6
if(typeof HTMLElement!="undefined" && !HTMLElement.prototype.insertAdjacentElement) {
	HTMLElement.prototype.insertAdjacentElement = function(where,parsedNode) {
		switch (where) {
			case 'beforeBegin':
				this.parentNode.insertBefore(parsedNode,this)
					break;
			case 'afterBegin':
				this.insertBefore(parsedNode,this.firstChild);
				break;
			case 'beforeEnd':
				this.appendChild(parsedNode);
				break;
			case 'afterEnd':
				if (this.nextSibling) 
					this.parentNode.insertBefore(parsedNode,this.nextSibling);
				else this.parentNode.appendChild(parsedNode);
				break;
		}
	}

	HTMLElement.prototype.insertAdjacentHTML = function	(where,htmlStr) {
		var r = this.ownerDocument.createRange();
		r.setStartBefore(this);
		var parsedHTML = r.createContextualFragment(htmlStr);
		this.insertAdjacentElement(where,parsedHTML)
	}
}
// end fix
var pu = null;
function startGigaUpload( pForm ) {
	disableSubmit('submitbutton');

	//hide('uploadblock');
	$('gigaprogressdivcontainer').style.display = 'block';
	progressUrl = "{/literal}{$smarty.const.GIGAUPLOAD_PKG_URL}{literal}progress.php";
	parameters = "giga_session="+$('gigasession').value+"&post_url={/literal}{$smarty.server.PHP_SELF}{literal}";
	var pb = $("gigaprogressbar");

	pu = new Ajax.PeriodicalUpdater('gigaprogressdiv',progressUrl,{
		'decay': 2,
		'frequency' : 2,
		'method': 'post',
		'parameters': parameters,
		'evalScripts': true,
		'onSuccess' : function(request){ updateProgress(pb,request) },
		'onFailure':function(request){ updateFailure(pb,request) }
		}
	)
	pForm.submit();
	//return true;
}

function apu() {
	$('gigaprogressdiv').style.display = 'block';
    progressUrl = "{/literal}{$smarty.const.GIGAUPLOAD_PKG_URL}{literal}progress.php";
    parameters = "&giga_session="+$('gigasession').value +"&post_url={/literal}{$smarty.server.PHP_SELF}{literal}";
	var pb = $("gigaprogressbar");
	pu = new Ajax.PeriodicalUpdater('gigaprogressdiv',progressUrl,{
		'decay': 2,
		'frequency' : 3,
		'method': 'post',
		'parameters': parameters,
		'evalScripts': true,
		'onSuccess' : function(request){ updateProgress(pb,request) },
		'onFailure':function(request){ updateFailure(pb,request) }
		}
	)
}

var slots = 10;
function addUploadSlot() {
	$('newgigaslot').insertAdjacentHTML("afterEnd", '<input name="gigaupload['+slots+']" type="file"><br>');
	slots++;
}

function updateProgress(pb,req) {
	pb.innerHTML=req.responseText;
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
