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

function startGigaUpload( pForm ) {
	disableSubmit('submitbutton');
    progressUrl = "{/literal}{$smarty.const.GIGAUPLOAD_PKG_URL}{literal}progress.php";
    iTotal = escape("-1");
    parameters = "&giga_session="+$('gigasession').value +"&post_url={/literal}{$smarty.server.PHP_SELF}{literal}";

    pForm.submit();

	if( $('giga_progress_popup') ) {
	    popUpWin(progressUrl+'?'+parameters,"standard",460,300);
	} else {
		hide('uploadblock');
		show('gigaprogress');
		var pb = $("gigaprogressbar");
		new Ajax.PeriodicalUpdater({},progressUrl,{
			'decay': 2,
			'frequency' : 0.5,
			'method': 'post',
			'parameters': parameters,
			'evalScripts': true,
			'onSuccess' : function(request){ updateProgress(pb,request) },
			'onFailure':function(request){ updateFailure(pb,request) }
			}
		)
	}

	return false;
}

var slots = 3;
function addUploadSlot() {
	$('gigaslots').insertAdjacentHTML("afterEnd", '<input name="gigaupload['+slots+']" type="file"><br>');
	slots++;
}

function updateProgress(pb,req) {
		pb.innerHTML=req.responseText;
//		parent.location.href={/literal}"{$postUrl|default:$smarty.server.PHP_SELF}" + "?giga_post=1&giga_session={$smarty.request.giga_session}{literal}";
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
