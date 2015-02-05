<!--#include file="head.asp" -->
<%


%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 赎回查询</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">


        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>债权转让赎回查询</h5>
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
                            <label class="control-label">&nbsp;状态:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="status" name="status">
                                    	<option value="" ></option>
                                    	<option value="0" >待审批</option>
                                        <option value="1" >已审批</option>
                                </select>
                                </div>
                                <span id="custome_source_err" class="err_text"></span>
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
                        <h5>债权转让赎回列表</h5>
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
                               <th>赎回违约金</th>
                               <th>状态</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
if trim(request("number"))<>"" then numbers=" and number='"&trim(request("number"))&"'"
if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
if trim(request("passport"))<>"" then passport=" and passport='"&trim(request("passport"))&"'"
if trim(request("start_date"))<>"" then date1=" and datediff(d,'"&trim(request("start_date"))&"',start_date)>=0"
if trim(request("start_date2"))<>"" then date2=" and datediff(d,start_date,'"&trim(request("start_date2"))&"')>=0"
if trim(request("product_name"))<>"" then product_name=" and product_name='"&trim(request("product_name"))&"'"
if trim(request("status"))<>"" then status=" and approval_redeem="&trim(request("status"))

				err_txt="<tr><td colspan=""10"">没有债权转让赎回信息</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from contracts where redeem=1"&numbers&full_name&passport&product_name&date1&date2&status&" order by datediff(d,'"&now()&"',start_date),approval desc",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"manage_redeem.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&status="&trim(request("status")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_redeem.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&status="&trim(request("status")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_redeem.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&status="&trim(request("status")))
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                                       
                                <td><%if rs("approval_redeem")=0 then%><input type="checkbox" name="subBox" value="<%=rs("id")%>"/><%end if%></td>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("number"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("full_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("product_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("capital"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("start_date"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%
								set rs1=server.CreateObject("adodb.recordset")
								rs1.Open "select penalty from products where product_name='"&rs("product_name")&"'",conn,1,1
								if not rs1.eof then
									response.Write cdbl(rs1("penalty"))*cdbl(rs("capital"))
								end if
								rs1.close
								set rs1=nothing
								%></td>
                               <td style="vertical-align: middle; text-align:center">
                               <%
							   if rs("approval_redeem")=0 then
							   		response.Write "待审批"
							   else
							   		response.Write "已审批"
							   end if
							   %>
                               </td>
                               <td style="vertical-align: middle; text-align:center">
                               <%if rs("approval_redeem")=0 then%>
                                    <a href="javascript:;" id="cancel_redeem_<%=int(rs("id"))%>" class="cancel_redeem">取消赎回</a>
                                <%end if%>
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
                            <span class="icon" style="cursor: pointer;" id="cancel_redeems"> <i class="icon-print"></i> 批量取消赎回</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
<%=showpage1%>
                       
                    
                    
                </div>
            </div>
        </div>
        </div>
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