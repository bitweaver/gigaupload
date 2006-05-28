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

function startGigaUpload()
{
	disableSubmit('submitbutton');
    baseUrl = "{/literal}{$smarty.const.GIGAUPLOAD_PKG_URL}{literal}progress.php";
    iTotal = escape("-1");
    baseUrl += "?iTotal=" + iTotal + "&iRead=0" + "&iStatus=1";
    baseUrl += "&sessionid={/literal}{gigaupload_id}{literal}";

    popUpWin(baseUrl,"standard",460,300);
    document.forms[0].submit();
	
}
function addUploadSlot() {
	$('gigaslots').insertAdjacentHTML("afterEnd", '<input name="xupload[]" type="file"><br>');
}
{/literal}
--></script>
