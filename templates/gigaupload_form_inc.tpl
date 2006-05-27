<script language="javascript">
{literal}
function gigaUpload()
{
    baseUrl = "{/literal}{$smarty.const.GIGAUPLOAD_PKG_URL}{literal}/progress.php";
    sid = document.forms[0].sessionid.value;
    iTotal = escape("-1");
    baseUrl += "?iTotal=" + iTotal;
    baseUrl += "&iRead=0";
    baseUrl += "&iStatus=1";
    baseUrl += "&sessionid=" + sid;

    popUpWin(baseUrl,"standard",460,300);
    document.forms[0].submit();
}
{/literal}
</script>
