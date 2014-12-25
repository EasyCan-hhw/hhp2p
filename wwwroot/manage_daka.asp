<!--#include file="head.asp" -->
<%
if InStr(request.cookies("hhp2p_cookies")("quanxian"),"[1]")=0 then
response.Write "<p align=center><font color=red>您没有此项目管理权限！</font></p>"
response.End
end if
%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 员工打卡录入</a></div>
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
                                <span id="product_name_err1" class="err_text"></span>
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
                  <h5>员工打卡录入</h5>
                </div>
                <div class="widget-content nopadding">
                  <span id="product_name_err" class="err_text"></span>
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label">&nbsp;工号:</label>
                            <div class="controls">
                                <input type="text" id="job_number" class="span5" name="job_number" style="width:275px;"/>
                                <span id="job_number_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;员工姓名:</label>
                            <div class="controls">
                                <input type="text" id="username" class="span5" name="username" style="width:275px;" />
                                <span id="username_err" class="err_text"></span>
                            </div>
                        </div>
                     
                        <div class="control-group">
                            <label class="control-label">&nbsp;打卡日期:</label>
                            <div class="controls">
                                <input type="text" id="work_date" name="work_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" style="width:275px;"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="work_date_err" class="err_text"></span>
                            </div>
                        </div>
                        
                        
                       
                        <div class="control-group">
                            <label class="control-label">&nbsp;打卡时间:</label>
                            <div class="controls">
                                上午:&nbsp;&nbsp;<input type="text" id="start_time1" name="start_time1" class="span5" style="width:50px;text-align:right"/>&nbsp;时&nbsp;<input type="text" id="start_time2" name="start_time2" class="span5" style="width:50px;text-align:right"/>&nbsp;分&nbsp;&nbsp;下午:&nbsp;&nbsp;
                                <input type="text" id="end_time1" name="end_time1" class="span5" style="width:50px;text-align:right"/>&nbsp;时&nbsp;<input type="text" id="end_time2" name="end_tem2" class="span5" style="width:50px;text-align:right"/>&nbsp;分&nbsp;
                                <span class="help-inline">格式：16:59分(24小时制)</span>
                                <span id="star_time_err" class="err_text"></span>
                                <span id="end_time_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="insert_daka_submit" type="submit" class="btn btn-primary">添&nbsp;&nbsp;加</button>
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
                        <h5>员工打卡信息列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap">工号</th>
                                <th>员工姓名</th>
                                <th>打卡日期</th>
                                <th>上午打卡时间</th>
                               <th>下午打卡时间</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
			err_txt="<tr><td colspan=""12"">没有员工录入信息</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from work_attendance order by work_id desc",conn,1,1

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
            	  showpage1=showpage(totalput,MaxPerPage,"manage_daka.asp","")
       				else
            			if (currentPage-1)*MaxPerPage<totalPut then
                    	rs.move  (currentPage-1)*MaxPerPage
                    	dim bookmark
                    	bookmark=rs.bookmark
                    	showContent
                  		showpage1=showpage(totalput,MaxPerPage,"manage_daka.asp","")
          			  else
            	        currentPage=1
                      showContent
                      showpage1=showpage(totalput,MaxPerPage,"manage_daka.asp","")
  						    end if
  	   				end if
			  end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                               <tr>
	                                <td style="vertical-align: middle;text-align:center" name="job_number<%=int(rs("work_id"))%>" id="job_number<%=int(rs("work_id"))%>">
	                                  <%=trim(rs("job_number"))%>
	                                </td>
	                                <td style="vertical-align: middle;text-align:center">
	                                  <input name="username<%=int(rs("work_id"))%>" id="username<%=int(rs("work_id"))%>" class="half" type="text" value="<%=trim(rs("username"))%>" style="text-align:center;width:60px"/> 
	                                  </td>
	                                <td style="vertical-align: middle;text-align:center">
	                                  <input name="work_date<%=int(rs("work_id"))%>" id="work_date<%=int(rs("work_id"))%>" class="half" type="text" value="<%=trim(rs("work_date"))%>" style="text-align:center;width:100px"/>
	                                   </td>
	                                <td style="vertical-align: middle;text-align:center">
	                                  <input name="start_time1<%=int(rs("work_id"))%>" id="start_time1<%=int(rs("work_id"))%>" class="half" type="text" value="<%=trim(rs("start_time")\60) %>" style="text-align:right;width:30px"/>
                                    <span class="help-inline">&nbsp;:&nbsp;</span>
                                     <input name="start_time2<%=int(rs("work_id"))%>" id="start_time2<%=int(rs("work_id"))%>" class="half" type="text" value="<%=trim(rs("start_time") mod 60)%>" style="text-align:right;width:30px"/>
	                                 </td>
	                                <td style="vertical-align: middle;text-align:center">
	                                  
                                     <input name="end_time1<%=int(rs("work_id"))%>" id="end_time1<%=int(rs("work_id"))%>" class="half" type="text" value="<%=trim(rs("end_time")\60) %>" style="text-align:right;width:30px"/>
                                    <span class="help-inline">&nbsp;:&nbsp;</span>
                                     <input name="end_time2<%=int(rs("work_id"))%>" id="end_time2<%=int(rs("work_id"))%>" class="half" type="text" value="<%=trim(rs("end_time") mod 60)%>" style="text-align:right;width:30px"/>
	                                   </td>
	                                <td style="vertical-align: middle; text-align:center">
	                                    <a href="javascript:;" id="daka_edit_<%=int(rs("work_id"))%>" class="daka_edit">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
	                                    <a href="javascript:;" id="daka_del_<%=int(rs("work_id"))%>" class="daka_del">删除</a>
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