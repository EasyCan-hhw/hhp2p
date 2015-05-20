<!--#include file="config.asp" -->
<%
ids=Trim(SafeRequest("ids"))

if ids<>"" then
	idss=split(ids,",")
  response.write "ids"
elseif id<>"" then

	idss=split(id,",")

end if
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>出借情况报告</title>
<style>
td,div{
	font:14px Arial;
	line-height:22px;
	font-weight:bold;
}
.border-bottom{
	border-bottom:#000 solid 1px;
}
.border-top{
	border-top:#000 solid 1px;
}
.border-left{
	border-left:#000 solid 1px;
}
.border-right{
	border-right:#000 solid 1px;
}
.bold{
	font-weight:bold;
}
.line20{
	line-height:20px;
}
.dashed{
	border-bottom:#000 dashed 1px;
}
</style>
<script src="js/jquery-1.4.2.min.js"></script>
<script src="js/jquery.PrintArea.js"></script>
<script type="text/javascript"> 
$(document).ready(function() { 
$("#print").click(function(){ 
	$(".no_print").empty();
	$("#myPrintArea").printArea();
}) 
}); 
</script> 
</head>

<body>

<div style="border-bottom:#000 dashed 1px;">
	<div style="width:756px; margin:auto; padding:20px;">
    打印说明：<br>
    1、请在浏览器页面设置中，将页眉、页脚设为空。<br>
    2、请在浏览器页面设置中，将上、下、左、右的页边距都设为5mm。
    <div align="center" style="padding-top:20px;"><input type="button" id="print" value="点击打印"/> </div>
    </div>
</div>
<br><br>
<div id="myPrintArea">
<%
for j=0 to ubound(idss)

set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from contracts where id="&idss(j)&"order by id desc",conn,1,1

if  rs.eof then
	response.write "非法提交！"
else
	set rs1=server.CreateObject("adodb.recordset")
	rs1.Open "select * from customers where id="&rs("cid"),conn,1,1
	if not rs1.eof then
		if rs1("sex")=1 then
			sex="先生"
		elseif rs1("sex")=2 then
			sex="女士"
		end if
		postcodes=rs1("postcodes")
		address=rs1("address")
	end if
	rs1.close
	set rs1=nothing
if j>0 then
%>
<div style="page-break-after: always;" class="no_print"><br><div class='dashed'></div><br></div>
<%end if%>
<div style="width:756px;height:1086px; margin:auto;">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="98%" border="0" align="center" cellpadding="4" cellspacing="0">
      <tr>
        <td valign="bottom"><img src="img/agreement_img1.jpg" width="152" height="48" /></td>
        <td align="right" valign="bottom" style="color:#FF6600; font-size:18px; font-weight:bold;">成功之路&nbsp;行行相助</td>
      </tr>
    </table><div style="border-bottom:#F60 solid 4px;"></div></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="120" colspan="2" style="font-size:14px; font-weight:bold; line-height:24px;"><table width="40%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td height="60" nowrap="nowrap">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="60" height="40" nowrap="nowrap" style="font-size:14px;line-height:20px;">邮编：</td>
    <td style="font-size:14px;line-height:20px;"><%=postcodes%></td>
  </tr>
  <tr>
    <td height="40" valign="top" style="font-size:14px; line-height:20px;">地址：</td>
    <td valign="top" style="font-size:14px;line-height:20px;"><%=address%></td>
  </tr>
  <tr>
    <td height="40">&nbsp;</td>
    <td><%=rs("full_name")&"　"&sex%>　亲启</td>
  </tr>
  <tr>
    <td height="60">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
        </table>

　　　　
</td>
      </tr>
      <tr>
        <td height="60" colspan="2" align="center" style="font-size:20px; font-weight:bold;">客户资金出借情况报告</td>
      </tr>
      <tr>
        <td colspan="2" style="font-weight:bold;">　　日期：<%=ForMatDate(rs("inputdate"),4)%><br>　　尊敬的行行贷贵宾　<%=rs("full_name")%>　<%=sex%>　您好：<br>　　感谢您选择行行贷公司的服务，您目前出借的款项所产生的收益情况如下：（货币单位：人民币元整）<br></td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="1" cellspacing="0" cellpadding="4" class="bold line20 ">
          <tr>
            <td align="center" nowrap="nowrap" class="border-top border-left border-right">报告周期</td>
            <td colspan="9" align="center" class="border-top border-right"><%=rs("periods_start_date")%>至<%=rs("periods_end_date")%></td>
            </tr>
          <tr>
            <td align="center" class="border-top border-left border-right">出借编号</td>
            <td align="center" class="border-top border-right">资金出借及回收方式</td>
            <td align="center" class="border-top border-right">出借日期</td>
            <td align="center" class="border-top border-right">到期日/封闭期结束日</td>
            <td align="center" class="border-top border-right">初始出借金额</td>
            <td align="center" class="border-top border-right">本次报告期数</td>
            <td align="center" class="border-top border-right">截至本报告期末资产总值</td>
            <td align="center" class="border-top border-right">出借预期年化收益</td>
            <td align="center" class="border-top border-right">本期现金派息额</td>
            <td align="center" class="border-top border-right">每月出账单报告日</td>
            </tr>
          <tr>
            <td align="center" class="border-top border-left border-right border-bottom"><%=trim(rs("number"))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=trim(rs("product_name"))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=trim(rs("start_date"))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=next_date(rs("start_date"),ForMatDate(DateAdd("d",rs("cycle"), rs("start_date")),2))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=formatnumber(trim(rs("capital")),2,-1)%></td>
            <td align="center" class="border-top border-right border-bottom"><%=trim(rs("periods"))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=formatnumber(trim(rs("grand_total")),2,-1)%></td>
            <td align="center" class="border-top border-right border-bottom"><%=(cdbl(rs("profit"))*100&"%")%></td>
            <td align="center" class="border-top border-right border-bottom"><%=formatnumber(trim(rs("accrual")),2,-1)%></td>
            <td align="center" class="border-top border-right border-bottom"><%=split(ForMatDate(DateAdd("d",30, rs("start_date")),13),"-")(1)%></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td height="4" colspan="2"></td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="4">
          <tr>
            <td colspan="2" align="center" style="font-size:11px;">温馨提示：行行贷竭诚为您提供高效优质的服务，有任何问题请联系我们为您专门指定的客户经理，或请致电:400-092-9098</td>
            </tr>
          <tr>
            <td height="100">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>　转让人：北京一明时代技术服务有限公司</td>
            <td>见证人：天会（上海）投资有限公司</td>
            </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            </tr>
          <tr>
            <td>　盖章：</td>
            <td>盖章：</td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td height="300" colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td height="26" colspan="2" align="center" class="bold" style="font-size:14px;"><img src="img/monthly_bill_img1.jpg" width="862" height="94" /></td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      </table></td>
  </tr>
  <tr>
    <td><table width="98%" border="0" align="center" cellpadding="4" cellspacing="0">
      <tr>
        <td style="font-weight:bold;">&nbsp;</td>
        <td align="right" style="font-weight:bold;"><strong>全国免费咨询热线：400-092-9098</strong></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<%
end if
rs.close
set rs=nothing
next
%>
</div>
</body>
</html>
