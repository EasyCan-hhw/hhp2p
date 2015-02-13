<!--#include file="config.asp" -->
<%
ids=Trim(SafeRequest("ids"))
if ids<>"" then
	idss=split(ids,",")
elseif id<>"" then
	idss=split(id,",")
end if
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>债权转让及受让协议</title>
<style>
td,div{
	font:12px Arial;
	line-height:20px;
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
rs.Open "select * from contracts where id="&idss(j),conn,1,1
if rs.eof then
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
        <td height="100" colspan="2" align="center" style="font-size:20px; font-weight:bold;">债权转让及受让协议</td>
      </tr>
      <tr>
        <td colspan="2" style="font-weight:bold;">尊敬的&nbsp;<%=trim(rs("full_name"))%>&nbsp;<%=sex%>，您好！<br>　　通过一明时代公司的评估与筛选，推荐您通过受让他人既有的个人间借贷合同的方式，出借资金给如下借款人，详见《债权列表》。<br></td>
      </tr>
      <tr>
        <td height="24" style="font-weight:bold;">　　在您接受该批债权转让并按时支付对价的情况下，预期您的出借获益情况如下：</td>
        <td align="right" style="font-weight:bold;">货币单位：人民币（元）&nbsp;&nbsp;&nbsp;&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="1" cellspacing="0" cellpadding="4" class="bold line20 ">
          <tr>
            <td width="10%" align="center" class="border-top border-left border-right">出借编号</td>
            <td width="12%" align="center" class="border-top border-right">资金出借及回收方式</td>
            <td width="12%" align="center" class="border-top border-right">初始出借日期</td>
            <td width="12%" align="center" class="border-top border-right">初始出借金额</td>
            <td width="12%" align="center" class="border-top border-right">下一个报告日</td>
            <td width="14%" align="center" class="border-top border-right">下一个报告期借款人应还款额</td>
            <td width="12%" align="center" class="border-top border-right">账户管理费</td>
            <td width="14%" align="center" class="border-top border-right">预计下一个报告日您的资产总额</td>
          </tr>
          <tr>
            <td align="center" class="border-top border-left border-right border-bottom"><%=trim(rs("number"))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=trim(rs("product_name"))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=trim(rs("start_date"))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=formatnumber(trim(rs("capital")),2,-1)%></td>
            <td align="center" class="border-top border-right border-bottom"><%=next_date(trim(rs("start_date")),ForMatDate(DateAdd("d", 30, rs("start_date")),2))%></td>
            <td align="center" class="border-top border-right border-bottom"><%=formatnumber(cdbl(rs("capital"))*(cdbl(rs("profit"))/12),2,-1)%></td>
            <td align="center" class="border-top border-right border-bottom">0.00</td>
            <td align="center" class="border-top border-right border-bottom"><%=formatnumber(cdbl(rs("capital"))+(cdbl(rs("capital"))*(cdbl(rs("profit"))/12)),2,-1)%></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="4" colspan="2"></td>
      </tr>
      <tr>
        <td height="26" colspan="2" align="center" class="bold" style="font-size:14px;">债权列表</td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="4">
          <tr>
            <td>转让人（原债权人）：徐步明</td>
            <td>受让人（新债权人）：<%=trim(rs("full_name"))%></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>身份证号码：<%=trim(rs("passport"))%></td>
          </tr>
          <tr>
            <td>转让债权明细：</td>
            <td align="right">货币单位：人民币（元）&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="1" cellspacing="0" cellpadding="4" class="line20">
          <tr>
            <td colspan="7" class="border-top border-right border-left">&nbsp;</td>
            <td colspan="4" align="center" nowrap="nowrap" class="border-top border-right">借款人如约还款情况下债权收益信息</td>
            </tr>
          <tr>
            <td width="6%" align="center" class="border-left border-top border-right">序号</td>
            <td width="7%" align="center" class="border-top border-right">借款人姓名</td>
            <td width="20%" align="center" class="border-top border-right">借款人身份证号码</td>
            <td width="8%" align="center" class="border-top border-right">本次转让债权价值</td>
            <td width="8%" align="center" class="border-top border-right">需支付对价</td>
            <td width="8%" align="center" class="border-top border-right">借款人职业情况</td>
            <td width="8%" align="center" class="border-top border-right">借款人抵押物</td>
            <td width="10%" align="center" class="border-top border-right">还款起始日期</td>
            <td width="8%" align="center" class="border-top border-right">还款期数</td>
            <td align="center" class="border-top border-right">剩余还款期数</td>
            <td align="center" class="border-top border-right">预计债权收益率（年）</td>
          </tr>
           <%
			set rs1=server.createobject("adodb.recordset")
			rs1.Open "select * from creditor_right_allot where c_id="&rs("id")&" order by id",conn,1,1
			i=1
			do while not rs1.eof
				zamount=zamount+rs1("amount")
				set rs2=server.createobject("adodb.recordset")
				rs2.Open "select * from creditor_right where id="&rs1("cr_id"),conn,1,1
				if not rs2.eof then
			%>
          <tr>
            <td align="center" class="border-left border-top border-right"><%=i%></td>
            <td align="center" class="border-top border-right"><%=rs2("full_name")%></td>
            <td align="center" class="border-top border-right"><%=rs2("passport")%></td>
            <td align="center" class="border-top border-right"><%=cdbl(rs2("creditor_right_value"))/10000%>万</td>
            <td align="center" class="border-top border-right"><%=cdbl(rs1("amount"))/10000%>万</td>
            <td align="center" class="border-top border-right"><%=rs2("job")%></td>
            <td align="center" class="border-top border-right"><%=rs2("collateral")%></td>
            <td align="center" class="border-top border-right">
              <%
              '=next_date(trim(rs("start_date")),ForMatDate(DateAdd("d", 30, rs("start_date")),2))
            startD =  ForMatDate(trim(rs("start_date")),2)
             response.write startD
              %></td>
            <td align="center" class="border-top border-right"><%=round(rs("cycle")/30,0)%></td>
            <td align="center" class="border-top border-right"><%=round(rs("cycle")/30,0)%></td>
            <td align="center" class="border-top border-right"><%=cdbl(rs("profit"))*100%>%</td>
          </tr>
          <%
				end if
				rs2.close
				set rs2=nothing
			rs1.movenext
			i=i+1
			loop
			rs1.close
			set rs1=nothing
			do while i<6
		   %>
          <tr>
            <td align="center" class="border-left border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
            <td align="center" class="border-top border-right">&nbsp;</td>
          </tr>
          <%
		  i=i+1
		  loop
		  %>
          <tr>
            <td colspan="4" class="border-left border-top border-right border-bottom">合计</td>
            <td align="center" class="border-top border-right border-bottom"><%=cdbl(zamount)/10000%>万</td>
            <td align="center" class="border-top border-right border-bottom">&nbsp;</td>
            <td align="center" class="border-top border-right border-bottom">&nbsp;</td>
            <td align="center" class="border-top border-right border-bottom">&nbsp;</td>
            <td align="center" class="border-top border-right border-bottom">&nbsp;</td>
            <td align="center" class="border-top border-right border-bottom">&nbsp;</td>
            <td align="center" class="border-top border-right border-bottom">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="26" colspan="2" align="center" class="bold" style="font-size:14px;">转让人声明</td>
      </tr>
      <tr>
        <td height="40" colspan="2">本人自愿将上述债权转让给受让人。如果受让人对上述债权转让没有任何异议，须于&nbsp;<%=trim(rs("start_date"))%>&nbsp;前将上述对价共计人民币（大写）&nbsp;&nbsp;<%=int2chn(zamount)%>元整&nbsp;&nbsp;（人民币小写¥   <%=formatnumber(zamount,2,-1)%>   ）支付到如下指定账户。</td>
      </tr>
      <tr>
        <td colspan="2"><table width="70%" border="0" align="center" cellpadding="4" cellspacing="0">
          <tr>
            <td>开户行：民生银行北京京广支行</td>
          </tr>
          <tr>
            <td>账户名称：北京一明时代技术服务有限公司</td>
          </tr>
          <tr>
            <td>账号：626314590</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="2">自款项到账之日起，上述债权转让即生效；债权转让生效后，署有本人签章的本文件即代表受让人对上述债权的所有权。<br>
          本人特此签章证明。</td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" Height="100%" border="0" cellspacing="0" cellpadding="4">
          <tr>
            <td style="font-size:11px">转让人：北京一明时代技术服务有限公司上海分公司</td>
            <td style="font-size:11px">见证人：天会（上海）投资有限公司</td>
            <td style="font-size:11px">受让人：</td>
            </tr>
          <tr height="60">
            <td style="font-size:11px">签&nbsp;&nbsp;章：</td>
            <td style="font-size:11px">签&nbsp;&nbsp;章：</td>
            <td>&nbsp;</td>
            </tr>
          <tr   >
            <td style="font-size:11px">日&nbsp;&nbsp;期：<%=ForMatDate(rs("start_date"),4)%></td>
            <td style="font-size:11px">日&nbsp;&nbsp;期：<%=ForMatDate(rs("start_date"),4)%></td>
            <td style="font-size:11px">日&nbsp;&nbsp;期：<%=ForMatDate(rs("start_date"),4)%></td>
            </tr>
          </table></td>
      </tr>
      </table><div style="border-bottom:#F60 solid 4px;"></div></td>
  </tr>
  <tr>
    <td><table width="98%" border="0" align="center" cellpadding="4" cellspacing="0">
      <tr>
        <td style="font-weight:bold;">北京一明时代技术服务有限公司</td>
        <td align="right" style="font-weight:bold;">行行贷<%
		set rs1=server.createobject("adodb.recordset")
		rs1.Open "select * from companys where id=(select company_id from users where uid="&rs("add_uid")&")",conn,1,1
		if not rs1.eof then
			response.write rs1("company_name")
		else
			response.write "上海分公司"
		end if
		rs1.close
		set rs1=nothing
		%></td>
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
