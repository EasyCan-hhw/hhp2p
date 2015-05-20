<!--#include file="head.asp" -->
<%


%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 债权转让审批</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">

<%
if id<>"" then
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from contracts where id="&id,conn,1,1
if not rs.eof then
%>
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>查看详情</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  		<input type="hidden" id="id" value="<%=rs("id")%>">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;客户身份证号(姓名):</label>
                            <div class="controls">
                            	<input type="text" id="cid" class="span5" name="cid" value="<%
								set rs1=server.createobject("adodb.recordset")
								rs1.Open "select * from customers where id="&rs("cid"),conn,1,1
								if not rs1.eof then
									response.Write rs1("passport")&"（"&rs1("full_name")&"）"
								end if
								rs1.close
								set rs1=nothing
								%>" disabled/>
                                <span id="cid_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;合同编号:</label>
                            <div class="controls">
                                <input type="text" id="number" class="span5" name="number" value="<%=rs("number")%>" disabled/>
                                <span id="number_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;理财产品:</label>
                            <div class="controls">
                            	<input type="text" id="product_name" class="span5" name="product_name" value="<%=rs("product_name")%>" disabled/>
                                <span id="product_name_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;初始理财金额:</label>
                            <div class="controls">
                                <input type="text" id="capital" class="span5" name="capital" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" value="<%=rs("capital")%>" disabled/>
                                <span class="help-inline">元</span>
                                <span id="capital_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;初始理财日期:</label>
                            <div class="controls">
                                <input type="text" id="start_date" name="start_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("start_date")%>" disabled/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="start_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert" id="creditor_right_detailed_div">
                            <label class="control-label"><font color="red">*</font>&nbsp;债权匹配明细:</label>
                            <div class="controls">
                                <table border="1" id="creditor_right_detailed">
                                  <tr>
                                    <th style="width:100px; height:26px;">借款人</th>
                                    <th style="width:200px; height:26px;">身份证号</th>
                                    <th style="width:100px; height:26px;">支付对价</td>
                                  </tr>
                                <%
								set rs1=server.createobject("adodb.recordset")
								rs1.Open "select * from creditor_right_allot where c_id="&rs("id")&" order by id",conn,1,1
								do while not rs1.eof
									set rs2=server.createobject("adodb.recordset")
									rs2.Open "select * from creditor_right where id="&rs1("cr_id"),conn,1,1
									if not rs2.eof then
								%>
                                  <tr class="old_creditor_right_detailed">
                                	<td align="center"><%=rs2("full_name")%></td>
                                    <td align="center"><%=rs2("passport")%></td>
                                	<td align="center"><%=rs1("amount")%></td>
                                  </tr>
                                <%
									end if
									rs2.close
									set rs2=nothing
								rs1.movenext
								loop
								rs1.close
								set rs1=nothing
								%>
                                </table>
                            </div>
                        </div>
                    <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="approval_attorn_creditor_right_submit" type="submit" class="btn btn-primary">审批</button>&nbsp;&nbsp;&nbsp;&nbsp;
                          <button id="history_back" type="submit" class="btn btn-primary">返回</button>
                      </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
<script type="text/javascript" src="inputUpload/init_img.js"></script>
<%
end if
rs.close
set rs=nothing
else
%>


        
  
        <div class="row-fluid">
             <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-list"></i> </span>
                        <h5>待审批债权转让列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                            	<th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th>
                                <th nowrap="nowrap">合同编号</th>
                                <th>客户姓名</th>
                                <th>客户身份证</th>
                                <th>理财产品</th>
                               <th>初始理财金额</th>
                               <th>初始理财日期</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
if trim(request("full_name"))<>"" then full_name=" and c_name='"&trim(request("full_name"))&"'"
if trim(request("passport"))<>"" then passport=" and passport='"&trim(request("passport"))&"'"
if trim(request("repayment_date"))<>"" then date1=" and datediff(d,'"&trim(request("repayment_date"))&"',repayment_date)>=0"
if trim(request("repayment_date2"))<>"" then date2=" and datediff(d,repayment_date,'"&trim(request("repayment_date2"))&"')>=0"
if trim(request("status"))<>"" then status=" and approval="&trim(request("status"))

				err_txt="<tr><td colspan=""8"">没有待审批的债权转让</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from contracts where approval=0"&full_name&passportdate1&date2&status&" order by datediff(d,'"&now()&"',start_date),approval desc",conn,1,1

		   	if err.number<>0 or rs.eof then
				response.write err_txt
			end if
			if not rs.eof then
				
	  				totalPut=rs.recordcount
      				if currentpage<1 then
          				currentpage=1
      				end if
      				if (currentpage-1)*MaxPerPage>totalput then
	   					if (totalPut mod MaxPerPage)=0 then
	     					currentpage= totalPut \ MaxPerPage
	   					else
	      					currentpage= totalPut \ MaxPerPage + 1
	   					end if
      				end if
       				if currentPage=1 then
            			showContent
            			showpage1=showpage(totalput,MaxPerPage,"approval_attorn_creditor_right.asp","&c_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"approval_attorn_creditor_right.asp","&c_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"approval_attorn_creditor_right.asp","&c_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status")))
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td><input type="checkbox" name="subBox" value="<%=rs("id")%>"/></td>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("number"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("c_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("product_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("capital"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("start_date"))%></td>
                               <td style="vertical-align: middle; text-align:center">
                               		
                                   <a href="javascript:;" id="attorn_creditor_right_approval_<%=int(rs("id"))%>" class="attorn_creditor_right_approval">审批</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="approval_attorn_creditor_right.asp?id=<%=int(rs("id"))%>">查看详情</a>
                                    
                                </td>
                            </tr>
            <%
			i=i+1
			if i>=MaxPerPage then Exit Do
			rs.movenext
			loop
			rs.close
			set rs=nothing
			End Sub   
            %>
                                                        </tbody>
                        </table> 
                        <div style="margin-bottom: 20px;">
                            <span class="icon" style="cursor: pointer;" id="attorn_creditor_right_approvals"> <i class="icon-tags"></i> 批量审批</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                       
<%=showpage1%>
                       
                    
                    
                </div>
            </div>
        </div>
        </div>
            
<%end if%>
        <!-- tips -->
        <div class="row-fluid">
            <div class="span12">
                <div class="alert alert-info alert-block">
                </div>
            </div>
        </div>        
        
     </div>
        
</div>
<!--end-main-container-part-->

<!--#include file="foot.asp" -->