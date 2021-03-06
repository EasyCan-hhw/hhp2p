﻿<!--#include file="head.asp" -->
<!--#include file="tool_function.asp"-->
<!--#include file="sidebar_menu.asp" -->
<!--#include file="getunderling_function.asp"-->

<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 债权转让查询</a></div>
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
                  <h5><%if rs("approval")=1 then%>查看详情<%else%>修改债权转让<%end if%></h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  		<input type="hidden" id="id" value="<%=rs("id")%>">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;客户身份证号(姓名):</label>
                            <div class="controls">
                            <%if rs("approval")=1 then%>
                            <input type="text" id="cid" class="span5" name="cid" value="<%
								set rs1=server.createobject("adodb.recordset")
								rs1.Open "select * from customers where id="&rs("cid"),conn,1,1
								if not rs1.eof then
									response.Write rs1("passport")&"（"&rs1("full_name")&"）"
								end if
								rs1.close
								set rs1=nothing
								%>" disabled/>
                            <%else%>
                            	<div class="span5">
                                <select id="cid" name="cid">
                                    	<option value=""></option>
                                <%
								set rs1=server.createobject("adodb.recordset")
								rs1.Open "select * from customers order by id",conn,1,1
								do while not rs1.eof
								%>
                                    	<option value="<%=rs1("id")%>"  <%if rs("cid")=rs1("id") then%>selected<%end if%>><%=rs1("passport")&"（"&rs1("full_name")&"）"%></option>
                                <%
								rs1.movenext
								loop
								rs1.close
								set rs1=nothing
								%>
                                </select>
                                </div>
                              <%end if%>
                                <span id="cid_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;合同编号:</label>
                            <div class="controls">
                                <input type="text" id="number" class="span5" name="number" value="<%=rs("number")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span id="number_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;理财产品:</label>
                            <div class="controls">
                            <%if rs("approval")=1 then%>
                            <input type="text" id="product_name" class="span5" name="product_name" value="<%=rs("product_name")%>" disabled/>
                            <%else%>
                            	<div class="span5">
                                <select id="product_name" name="product_name">
                                    	<option value=""></option>
                                <%
								set rs1=server.createobject("adodb.recordset")
								rs1.Open "select * from products order by id",conn,1,1
								do while not rs1.eof
								%>
                                    	<option value="<%=rs1("product_name")%>" <%if rs("product_name")=rs1("product_name") then%>selected<%end if%>><%=rs1("product_name")%></option>
                                <%
								rs1.movenext
								loop
								rs1.close
								set rs1=nothing
								%>
                                </select>
                                </div>
                             <%end if%>
                                <span id="product_name_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;初始理财金额:</label>
                            <div class="controls">
                                <input type="text" id="capital" class="span5" name="capital" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" value="<%=rs("capital")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span class="help-inline">元</span>
                                <span id="capital_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;初始理财日期:</label>
                            <div class="controls">
                                <input type="text" id="start_date" name="start_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("start_date")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
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
                          <%if rs("approval")=0 then%>
                          <button id="edit_attorn_creditor_right_submit" type="submit" class="btn btn-primary">再次匹配债权</button>
                          <button id="confirm_attorn_creditor_right_submit" type="submit" class="btn btn-primary" style="display:none">债权确认</button>
                        <%else%>
                          <button id="history_back" type="submit" class="btn btn-primary">返回</button>
                      <%end if%>
                      </div>
                  </form>
                </div>
              </div>
            </div>
          </div>




<%
end if
rs.close
set rs=nothing
else
%>

        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>债权转让账单查询</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label">&nbsp;合同编号:</label>
                            <div class="controls">
                                <input type="text" id="number" class="span5" name="number"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;客户姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;客户身份证:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport"/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;理财产品:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="product_name" name="product_name">
                                    	<option value=""></option>
                                <%
								set rs=server.createobject("adodb.recordset")
								rs.Open "select * from products order by id",conn,1,1
								do while not rs.eof
								%>
                                    	<option value="<%=rs("product_name")%>"><%=rs("product_name")%></option>
                                <%
								rs.movenext
								loop
								rs.close
								set rs=nothing
								%>
                                </select>
                                </div>
                                <span id="product_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;初始理财日期:</label>
                            <div class="controls">
                                <input type="text" id="start_date" name="start_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" style="width:275px;"/>&nbsp;&nbsp;至&nbsp;&nbsp;
                                <input type="text" id="start_date2" name="start_date2" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" style="width:275px;"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="start_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;出账日期:</label>
                            <div class="controls">
                                <input type="text" id="inputdate" name="inputdate" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" style="width:275px;"/>&nbsp;&nbsp;至&nbsp;&nbsp;
                                <input type="text" id="inputdate2" name="inputdate2" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" style="width:275px;"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="inputdate_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="search_creditor_right_submit" type="submit" class="btn btn-primary">组合查询</button>
                      </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
  
        <div class="row-fluid">
             <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-list"></i> </span>
                        <h5>债权转让账单列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                            	 <th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th>
                                <th nowrap="nowrap">合同编号</th>
                                <th>业务员</th>
                                <th>客户姓名</th>
                                <th>客户身份证</th>
                                <th>理财产品</th>
                               <th>初始理财金额</th>
                               <th>初始理财日期</th>
                               <th>账单期数</th>
                                <th>账单周期</th>
                               <!--<th>本期末资产总值</th>-->
                               <th>本期派息额</th>
                               <th>出账日期</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
          if trim(request("number"))<>"" then numbers=" and number='"&trim(request("number"))&"'"
          if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
          if trim(request("passport"))<>"" then passport=" and passport='"&trim(request("passport"))&"'"
          if trim(request("start_date"))<>"" then date1=" and datediff(d,'"&trim(request("start_date"))&"',start_date)>=0"
          'if trim(request("start_date2"))<>"" then date2=" and datediff(d,start_date,'"&trim(request("start_date2"))&"')>=0"
          if trim(request("product_name"))<>"" then product_name=" and product_name='"&trim(request("product_name"))&"'"
          'if trim(request("inputdate"))<>"" then inputdate1=" and datediff(d,'"&trim(request("inputdate"))&"',inputdate)>=0"
          'if trim(request("inputdate2"))<>"" then inputdate2=" and datediff(d,inputdate,'"&trim(request("inputdate2"))&"')>=0"

				err_txt="<tr><td colspan=""12"">没有债权转让账单信息</td></tr>"
        '"&numbers&full_name&passport&product_name&date1&date2&inputdate1&inputdate2&" 
			   set rs=server.CreateObject("adodb.recordset")
         if requestCompany(request.cookies("hhp2p_cookies")("uid")).parentCompany = 1 then 

			       rs.Open "select * from contracts where id>0 "&numbers&full_name&passport&"and approval=1 order by id desc",conn,1,1
          else 
              rs.Open "select * from contracts inner join users on contracts.job_number = users.job_number and (users.company_code = '"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"' or users.company_id = "&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&" ) and contracts.approval=1 order by id desc",conn,1,1
              'rs.Open "select * from contracts where id>0 "&numbers&full_name&passport&"and approval=1 and  order by id desc",conn,1,1
          end if 
         
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
            			showpage1=showpage(totalput,MaxPerPage,"manage_monthly_bill.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&inputdate="&trim(request("inputdate"))&"&inputdate2="&trim(request("inputdate2")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_monthly_bill.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&inputdate="&trim(request("inputdate"))&"&inputdate2="&trim(request("inputdate2")))
        			else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_monthly_bill.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&inputdate="&trim(request("inputdate"))&"&inputdate2="&trim(request("inputdate2")))
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
                                <td style="vertical-align: middle;text-align:center"><%
                                   if not rs("job_number")="" then
                                      set rsjob=server.CreateObject("adodb.recordset")
                                     rsjob.Open "select * from users where job_number='"&rs("job_number")&"'",conn,1,1
                                      response.write rsjob("full_name")
                                     rsjob.close
                                     set rsjob = nothing
                                   else 
                                      response.write "无"
                                   end if 
                                %></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("c_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("product_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("capital"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("start_date"))%></td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%

                                   response.write responseEndDate(rs("start_date"),rs("cycle")).dateNumber
                                  %></td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%

                                  '账单周期'
                                    
                                    response.write rs("start_date")&"&nbsp;至&nbsp;"&responseEndDate(rs("start_date"),rs("cycle")).EndDate
                                  %>
                                </td>
                                
                                 <!--<td style="vertical-align: middle;text-align:center">
                                  
                                   set rs1=server.CreateObject("adodb.recordset")
                                    rs1.Open "select penalty from products where product_name='"&rs("product_name")&"'",conn,1,1
                                    if not rs1.eof then
                                      penalty=cdbl(rs1("penalty"))*cdbl(rs("capital"))
                                    end if
                                    rs1.close
                                    'set rs1=nothing
                                    'accrual=round(cdbl(rs("capital"))*(cdbl(rs("profit"))/365)*datediff("d",periods_start_date,now())-cdbl(penalty),2)
                                    'Set db=Conn.execute("select sum(accrual) As db from monthly_bill where c_id="&rs("id"))
                                    'if db("db")>0 then
                                    ''  grand_total=cdbl(rs("capital"))+cdbl(db("db"))+cdbl(accrual)
                                    'else
                                    ''  grand_total=cdbl(rs("capital"))+cdbl(accrual)
                                    'end if
                                     grand_total = rs("")(penalty /12 * periods)
                                    response.write grand_total
                                 
                                </td> -->
                                <td style="vertical-align: middle;text-align:center">
                                  <%

                                 
                                      profit=cdbl(rs("profit"))*(cdbl(rs("capital"))/12)
                                   
                                    'set rs1=nothing
                                    'accrual=round(cdbl(rs("capital"))*(cdbl(rs("profit"))/365)*datediff("d",periods_start_date,now())-cdbl(penalty),2)
                                    'Set db=Conn.execute("select sum(accrual) As db from monthly_bill where c_id="&rs("id"))
                                    'if db("db")>0 then
                                    ''  grand_total=cdbl(rs("capital"))+cdbl(db("db"))+cdbl(accrual)
                                    'else
                                    ''  grand_total=cdbl(rs("capital"))+cdbl(accrual)
                                    'end if
                                    response.write Round(profit,2)'Round(profit/12, 2)
                                  %>
                              </td>
                                <td style="vertical-align: middle;text-align:center"><%=responseEndDate(rs("start_date"),rs("cycle")).EndDate%></td>
                               <td style="vertical-align: middle; text-align:center">
                                     <a href="monthly_bill.asp?id=<%=int(rs("id"))%>" target="_blank">打印账单</a>
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
                            <span class="icon" style="cursor: pointer;" id="print_monthly_bill"> <i class="icon-print"></i> 批量打印</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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