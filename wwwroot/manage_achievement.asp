﻿<!--#include file="head.asp" -->
<!--#include file="company_function.asp"-->
<%
if id<>"" then
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from users where uid="&id,conn,1,1
if not rs.eof then
	username=rs("username")
	job_number=rs("job_number")
	full_name=rs("full_name")
	company_id=rs("company_id")
	job_id=rs("job_id")
	tel=rs("tel")
	qq=rs("qq")
	email=rs("email")
	quanxian=rs("quanxian")
end if
rs.close
set rs=nothing
end if
%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 员工业绩查询</a></div>
    </div>
    <!--End-breadcrumbs-->
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>查询员工业绩</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;" id="add_search_user_form">
                        <div class="control-group">
                            <label class="control-label">&nbsp;用户名:</label>
                            <div class="controls">
                                <input type="text" id="username" class="span5" name="username"/>
                                <span id="username_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;工号:</label>
                            <div class="controls">
                                <input type="text" id="job_number" class="span5" name="job_number"/>
                                <span id="job_number_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;所属分公司:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="company_id" name="company_id">
                                    	<option value="" ></option>
									    <%
										set rs=server.CreateObject("adodb.recordset")
										rs.Open "select * from companys order by id" ,conn,1,1
										do while not rs.eof
										%>
										<option value="<%=rs("id")%>" <%if rs("id")=company_id then%>selected<%end if%>><%=rs("company_name")%></option>
										<%
										 rs.movenext
										 loop
										 rs.close
										 set rs=nothing
										%>
                                    </select>
                                </div>
                                <span class="help-inline">从下拉菜单中选择分公司</span>
                                <span id="company_id_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;职位:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="job_id" name="job_id">
                                    	<option value="" ></option>
									    <%
										set rs=server.CreateObject("adodb.recordset")
										rs.Open "select * from jobs order by id" ,conn,1,1
										do while not rs.eof
										%>
										<option value="<%=rs("id")%>" <%if rs("id")=job_id then%>selected<%end if%>><%=rs("job_name")%></option>
										<%
										 rs.movenext
										 loop
										 rs.close
										 set rs=nothing
										%>
                                    </select>
                                </div>
                                <span class="help-inline">从下拉菜单中选择分公司</span>
                                <span id="job_id_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="search_user_submit" type="button" class="btn btn-primary">组合查询</button>
                      </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
  
<%if id="" then%>        
        <div class="row-fluid">
             <div class="span12">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-list"></i> </span>
                        <h5>员工业绩列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap">用户名</th>
                                <th>工号</th>
                                <th>姓名</th>
                                <th>分公司</th>
                                <th>职位</th>
                                <th>目标客户数</th>
                                <th>正式客户数</th>
                               <th>签单数</th>
                               <th>签单总金额</th>
                               <th>业绩提成总数</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
if trim(request("username"))<>"" then username=" and username='"&trim(request("username"))&"'"
if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
if trim(request("company_id"))<>"" then company_id=" and company_id="&trim(request("company_id"))
if trim(request("job_id"))<>"" then job_id=" and job_id="&trim(request("job_id"))
if trim(request("tel"))<>"" then tel=" and tel='"&trim(request("tel"))&"'"
if trim(request("qq"))<>"" then qq=" and qq='"&trim(request("qq"))&"'"
if trim(request("email"))<>"" then email=" and email='"&trim(request("email"))&"'"

				err_txt="<tr><td colspan=""10"">没有员工</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from users where uid>0"&username&full_name&company_id&job_id&tel&qq&email&" and (company_id="&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&" or company_code='"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"') order by uid desc",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"manage_achievement.asp","&username="&trim(request("username"))&"&full_name="&trim(request("full_name"))&"&company_id="&trim(request("company_id"))&"&job_id="&trim(request("job_id")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_achievement.asp","&username="&trim(request("username"))&"&full_name="&trim(request("full_name"))&"&company_id="&trim(request("company_id"))&"&job_id="&trim(request("job_id")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_achievement.asp","&username="&trim(request("username"))&"&full_name="&trim(request("full_name"))&"&company_id="&trim(request("company_id"))&"&job_id="&trim(request("job_id")))
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("username"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("job_number"))%></td>
                               <td style="vertical-align: middle;text-align:center"><%=trim(rs("full_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%
                                  
                    								
                                    if IsNull(rs("company_code")) or rs("company_code") = 0 then 
                                        
                                        set rs1=server.CreateObject("adodb.recordset")
                                        rs1.Open "select * from companys where company_code="&rs("company_id"),conn,1,1
                                        if not rs1.eof then
                                            response.write "(一级)"&rs1("company_name")
                                        else
                                            response.write "其他"
                                        end if
                                        rs1.close
                                        set rs1=nothing
                                else 
                                        
                                        set rs3=server.CreateObject("adodb.recordset")
                                        rs3.Open "select * from companys where company_code="&rs("company_code"),conn,1,1
                                        if not rs3.eof then
                                            response.write "(二级)"&rs3("company_name")
                                        else
                                            response.write "其他"
                                        end if
                                        rs3.close
                                        set rs3=nothing
                                      
                                end if 
                    								%></td>
                                  <td style="vertical-align: middle;text-align:center"><%
                    								set rs1=server.CreateObject("adodb.recordset")
                    								rs1.Open "select * from jobs where id="&rs("job_id"),conn,1,1
                    								if not rs1.eof then
                    									response.write rs1("job_name")
                    									job_bonus_proportion=rs1("bonus_proportion")
                    								else
                    									response.write "其他"
                    								end if
                    								rs1.close
                    								set rs1=nothing
                    								%>
                                </td>
                                <td style="vertical-align: middle;text-align:center"><%
                  								Set db=Conn.execute("select count(*) As db from target_customers where add_uid="&rs("uid"))
                  								response.write db("db")
                  								%>
                                </td>
                                <td style="vertical-align: middle;text-align:center"><%
                  								Set db=Conn.execute("select count(*) As db from customers where uid="&rs("uid"))
                  								response.write db("db")
                  								%>
                                </td>
                                <td style="vertical-align: middle;text-align:center"><%
                  								'Set db=Conn.execute("select count(*) As db from contracts where approval=1 and add_uid="&rs("uid"))
                  								'response.write db("db")
                                  dbcount = 0
                                  dbprice = 0
                                  set rsdb=server.CreateObject("adodb.recordset")
                                  rsdb.Open "select * from contracts where approval=1",conn,1,1
                                  if not  rsdb.eof then 
                                    for d=0 to rsdb.recordcount-1
                                       
                                        set rscdb=server.CreateObject("adodb.recordset")
                                        rscdb.Open "select * from customers where id='"&rsdb("cid")&"'and uid='"&rs("uid")&"'",conn,1,1
                                        
                                        if not rscdb.eof then 
                                        
                                          dbcount = dbcount+1
                                          dbprice = dbprice + rsdb("capital")
                                         
                                        else 
                                        end if 
                                         rscdb.close
                                        set rscdb = nothing
                                    rsdb.movenext
                                    next 
                                  rsdb.close
                                  set rsdb = nothing
                                  else 
                                  end if 
                                  response.write dbcount
                  								%>
                                </td>
                                <td style="vertical-align: middle;text-align:center"><%
                  								'Set db=Conn.execute("select isnull(sum(capital),0) As db from contracts where approval=1 and add_uid="&rs("uid"))
                  								'response.write db("db")
                  								'zongjine=db("db")
                                  response.write dbprice
                  								%>
                                </td>
                               <td style="vertical-align: middle;text-align:center"><%
                  								bonus_proportion=0
                  								if cdbl(rs("bonus_proportion"))>0 then
                  									bonus_proportion=rs("bonus_proportion")
                  								elseif cdbl(job_bonus_proportion)>0 then
                  									bonus_proportion=job_bonus_proportion
                  								elseif cdbl(company_bonus_proportion)>0 then
                  									bonus_proportion=company_bonus_proportion
                  								end if
                  								response.write cdbl(zongjine)*cdbl(bonus_proportion)
                  								%>
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