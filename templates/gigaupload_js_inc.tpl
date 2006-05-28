<script type="text/javascript"><!--
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

function startGigaUpload( pForm )
{
	disableSubmit('submitbutton');
    progressUrl = "{/literal}{$smarty.const.GIGAUPLOAD_PKG_URL}{literal}progress.php";
    iTotal = escape("-1");
    parameters = "iTotal=" + iTotal + "&iRead=0" + "&iStatus=1" + "&giga_session="+$('gigasession').value;

    pForm.submit();

	if( $('giga_progress_popup') ) {
	    popUpWin(baseUrl,"standard",460,300);
	} else {
	    popUpWin(progressUrl+'?'+parameters,"standard",460,170);
	//	show('gigaprogress')
		var pb = $("gigaprogressbar");
		Element.show(pb.parentNode);
/*	
		new Ajax.PeriodicalUpdater({},progressUrl,{
			'decay': 2,
			'frequency' : 0.5,
			'method': 'post',
			'parameters': parameters,
			'onSuccess' : function(request){updateProgress(pb,request)},
			'onFailure':function(request){updateFailure(pb,request)}
			}
		)
*/
	}

	return false;
}

function addUploadSlot() {
	$('gigaslots').insertAdjacentHTML("afterEnd", '<input name="xupload[]" type="file"><br>');
}

function updateProgress(pb,req) {
	var percent = parseInt(req.responseText);
	if(!percent) percent = 0;
	pb.style.width = percent + "%";
	if(percent >= 100) {
		var inp_id = pb.id.replace("_progress","");
		if(sids[inp_id]) {
			uploads_in_progress = uploads_in_progress - 1;
			var inp = $(inp_id);
			if(inp) {
				inp.value = sids[inp_id];
			}
		}
		Element.hide(pb.parentNode);
		sids[inp_id] = false;
	}
}

function updateFailure(pb,req) {
	var mes = req.responseText;
	pb.style.width=0;
	alert(mes);
	uploads_in_progress = uploads_in_progress - 1;
}


{/literal}
--></script>