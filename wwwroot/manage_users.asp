<!--#include file="head.asp" -->
<%


if id<>"" then
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from users where uid="&id,conn,1,1
if not rs.eof then
	username=rs("username")
	job_number=rs("job_number")
	full_name=rs("full_name")
    user_code=rs("user_code")
	company_id=rs("company_id")
    add_insurance=rs("add_insurance")
	job_id=rs("job_id")
    lead_user=rs("lead_user")
	tel=rs("tel")
	qq=rs("qq")
    company_code=rs("company_code")
	email=rs("email")
    entry_date=rs("entry_date")
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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 员工管理</a></div>
    </div>
    <!--End-breadcrumbs-->
    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5><%if id<>"" then%>修改<%else%>添加或查询<%end if%>员工资料</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="manage_users.asp" method="post" class="form-horizontal" onSubmit="return false;" id="add_search_user_form">
                  <input type="hidden" id="uid" value="<%=id%>">
                  <% if id<>"" then%>
                        <div class="control-group">
                            <label class="control-label">&nbsp;用户名:</label>
                            <div class="controls">
                                <input type="text" id="username" class="span5" name="username" value="<%=username%>" disabled/>
                                <span id="username_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;密码:</label>
                            <div class="controls">
                                <input type="text" id="password" class="span5" name="password" />
                                <span class="help-inline">无需修改请留空</span>
                                <span id="password_err" class="err_text"></span>
                            </div>
                        </div>
                   <%else%>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;用户名:</label>
                            <div class="controls">
                                <input type="text" id="username" class="span5" name="username"/>
                                <span class="help-inline">初始密码：123456</span>
                                <span id="username_err" class="err_text"></span>
                            </div>
                        </div>
                     <%end if%>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;工号:</label>
                            <div class="controls">
                                <input type="text" id="job_numberS" class="span5" name="job_numberS" value="<%=job_number%>"/>
                                <span id="job_number_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name" value="<%=full_name%>"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;员工状态:</label>
                            <div class="controls">
                                <div class="span5">
                                <select id="user_code" name="user_code">
                                        <option value=""></option>
                                        <option value="0" <%if user_code=0 then%>selected<%end if%>>试用期</option>
                                        <option value="1" <%if user_code=1 then%>selected<%end if%>>正式员工</option>
                                        <option value="2" <%if user_code=2 then%>selected<%end if%>>离职</option>
                                        <option value="3" <%if user_code=3 then%>selected<%end if%>>0000</option>
                                </select>
                                </div>
                                <span class="help-inline">从下拉菜单中选择员工状态</span>
                                <span id="user_code_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;所属分公司:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="company_id" name="company_id">
                                    	<option value="" ></option>
									    <%
										set rs=server.CreateObject("adodb.recordset")
										rs.Open "select * from companys where company_code like '1%' and company_count='' order by id" ,conn,1,1
										do while not rs.eof
                                            set rsSubRegion = server.CreateObject("adodb.recordset")
                                            sqlQuery = "select * from companys where company_count='"&rs("company_code")&"'"
                                            rsSubRegion.Open sqlQuery,conn,1,1
                                            subRegionsIdAndNames = ""
                                            do while not rsSubRegion.eof
                                                subRegionsIdAndNames = subRegionsIdAndNames + rsSubRegion("company_code") + ":" + rsSubRegion("company_name") + ";"
                                                rsSubRegion.movenext
                                            loop
                                            rsSubRegion.close
                                            set rsSubRegion=nothing
                                            if subRegionsIdAndNames = "" then
                                                subRegionsIdAndNames = "none"
                                            end if
										%>
										<option id="companyId_<%=rs("id")%>"  subregions=<%=subRegionsIdAndNames%> unval="<%=rs("company_code")%>" value="<%=rs("id")%>" <%if rs("id")=company_id then%>selected<%end if%>><%=rs("company_name")%></option>
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
                            <label class="control-label">&nbsp;下属分公司:</label>
                            <div class="controls">
                                <div class="span5">
                                <select id="company_porportion" name="company_porportion">  
                                        <option value="" ></option>
                                        <%
                                        set rsc=server.CreateObject("adodb.recordset")
                                        rsc.Open "select * from companys where company_code='"&company_code&"'" ,conn,1,1
                                        if not rsc.eof then 
                                        %>
                                        <option value="<%=rsc("company_code")%>"  selected><%=rsc("company_name")%></option>
                                        <%
                                        else 
                                        end if 
                                        rsc.close
                                         set rsc=nothing
                                        %>
                                    </select>
                                </div>
                                <span class="help-inline">(没有请留空)请选择正确的下属分公司</span>
                                <span id="company_porportion_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;职位:</label>
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
                                <span class="help-inline">从下拉菜单中选择职位</span>
                                <span id="job_id_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label">&nbsp;上级:</label>
                            <div class="controls">
                                <div class="span5">
                                <select id="lead_user" name="lead_user" >
                                        <option value="" ></option>
                                        <%
                                        set rs=server.CreateObject("adodb.recordset")
                                        rs.Open "select * from users order by uid" ,conn,1,1
                                        do while not rs.eof
                                        %>
                                        <option value="<%=rs("job_number")%>" <%if rs("job_number")=lead_user then%>selected<%end if%>><%=rs("full_name")%></option>
                                        <%
                                         rs.movenext
                                         loop
                                         rs.close
                                         set rs=nothing
                                        %>
                                    </select>
                                </div>
                                <span class="help-inline">从下拉菜单中选择上级</span>
                                <span id="lead_user_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;电话:</label>
                            <div class="controls">
                                <input type="text" id="tel" class="span5" name="tel" value="<%=tel%>"/>
                                <span id="tel_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;QQ:</label>
                            <div class="controls">
                                <input type="text" id="qq" class="span5" name="qq" value="<%=qq%>"/>
                                <span id="qq_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;E-mail:</label>
                            <div class="controls">
                                <input type="text" id="email" class="span5" name="email" value="<%=email%>"/>
                                <span id="email_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;入职时间:</label>
                            <div class="controls">
                                <input type="text" id="entry_date" value="<%=entry_date%>"  name="entry_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="entry_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <!--<div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;户籍:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="census_register" name="census_register">
                                		<option value=""></option>
                                    	<option value="本地城镇">本地城镇</option>
                                        <option value="本地农村">本地农村</option>
                                        <option value="外地城镇">外地城镇</option>
                                        <option value="外地农村">外地农村</option>
                                </select>
                                </div>
                                <span class="help-inline">从下拉菜单中选择户籍状况</span>
                                <span id="census_register_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;加金:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="add_gold" name="add_gold">
                                		<option value=""></option>
                                    	<option value="0">非农业</option>
                                        <option value="1">农业</option>
                                </select>
                                </div>
                                <span class="help-inline">从下拉菜单中选择加金状况</span>
                                <span id="add_gold_err" class="err_text"></span>
                            </div>
                        </div>-->
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;保险:</label>
                            <div class="controls">
                                <div class="span5">
                                <select id="add_insurance" name="add_insurance">
                                        <option value=""></option>
                                        <option value="1" <%if add_insurance=1 then%>selected<%end if%>>交城镇保险</option>
                                        <option value="2" <%if add_insurance=2 then%>selected<%end if%>>交农村保险</option>
                                        <option value="3" <%if add_insurance=3 then%>selected<%end if%>>不交保险</option>
                                </select>
                                </div>
                                <span class="help-inline">从下拉菜单中选择保险状况</span>
                                <span id="add_insurance_err" class="err_text"></span>
                            </div>
                        </div>
                        <%
                             quanxianString = request.cookies("hhp2p_cookies")("quanxian")
                                splitvalue = split(quanxianString,",")
                                splitlength = ubound(splitvalue)

                            for s=0 to splitlength 
                                if splitvalue(s)="[29]" then 
                
                        %>
                        <div class="control-group">
                          <label class="control-label">权限:</label>
                          <div class="controls">
                          <table>
                          <tr>
                            <td><input name="checkbox_all" type="checkbox" id="checkbox_all" onClick="check_all('checkbox_all','quanxian')"> 全选&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[2]" <%if InStr(quanxian,"[2]")>0 then%>checked<%end if%>> 正式客户添加&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[3]" <%if InStr(quanxian,"[3]")>0 then%>checked<%end if%>> 客户查询&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[4]" <%if InStr(quanxian,"[4]")>0 then%>checked<%end if%>> 一般借贷申请&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[5]" <%if InStr(quanxian,"[5]")>0 then%>checked<%end if%>> 债权查询&nbsp;&nbsp;&nbsp;&nbsp;</td>

                        </tr>
                        <tr>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[6]" <%if InStr(quanxian,"[6]")>0 then%>checked<%end if%>> 债权转让&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[7]" <%if InStr(quanxian,"[7]")>0 then%>checked<%end if%>> 债权转让查询&nbsp;&nbsp;&nbsp;&nbsp;</td>    
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[8]" <%if InStr(quanxian,"[8]")>0 then%>checked<%end if%>> 员工管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[9]" <%if InStr(quanxian,"[9]")>0 then%>checked<%end if%>> 打卡录入&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[10]" <%if InStr(quanxian,"[10]")>0 then%>checked<%end if%>> 考勤申请&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[11]" <%if InStr(quanxian,"[11]")>0 then%>checked<%end if%>> 上班作息调整&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[12]" <%if InStr(quanxian,"[12]")>0 then%>checked<%end if%>> 假期添加&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[13]" <%if InStr(quanxian,"[13]")>0 then%>checked<%end if%>> 投资产品管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[14]" <%if InStr(quanxian,"[14]")>0 then%>checked<%end if%>> 派息提醒&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[15]" <%if InStr(quanxian,"[15]")>0 then%>checked<%end if%>> 工资核算&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[16]" <%if InStr(quanxian,"[16]")>0 then%>checked<%end if%>> 提佣区间设置&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[17]" <%if InStr(quanxian,"[17]")>0 then%>checked<%end if%>> 提成加薪设置&nbsp;&nbsp;&nbsp;&nbsp;</td>
                          </tr>
                          <tr>
                             <td><input name="quanxian" type="checkbox" id="quanxian" value="[18]" <%if InStr(quanxian,"[18]")>0 then%>checked<%end if%>> 员工业绩查询&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[19]" <%if InStr(quanxian,"[19]")>0 then%>checked<%end if%>> 新增债权审批&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[20]" <%if InStr(quanxian,"[20]")>0 then%>checked<%end if%>> 债权转让审批&nbsp;&nbsp;&nbsp;&nbsp;</td>
                             <td><input name="quanxian" type="checkbox" id="quanxian" value="[21]" <%if InStr(quanxian,"[21]")>0 then%>checked<%end if%>> 赎回债权审批&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[22]" <%if InStr(quanxian,"[22]")>0 then%>checked<%end if%>> 考勤审批&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[23]" <%if InStr(quanxian,"[23]")>0 then%>checked<%end if%>> 职位管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[24]" <%if InStr(quanxian,"[24]")>0 then%>checked<%end if%>> 分公司管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[25]" <%if InStr(quanxian,"[25]")>0 then%>checked<%end if%>> 债权转让赎回&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[26]" <%if InStr(quanxian,"[26]")>0 then%>checked<%end if%>> 赎回查询&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[27]" <%if InStr(quanxian,"[27]")>0 then%>checked<%end if%>> 账单查询&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[28]" <%if InStr(quanxian,"[28]")>0 then%>checked<%end if%>> 债权分类管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[30]" <%if InStr(quanxian,"[30]")>0 then%>checked<%end if%>> 财务请款&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[31]" <%if InStr(quanxian,"[31]")>0 then%>checked<%end if%>> 财务请款审批&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><input name="quanxian" type="checkbox" id="quanxian" value="[29]" <%if InStr(quanxian,"[29]")>0 then%>checked<%end if%>> 员工权限管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                             <td><input name="quanxian" type="checkbox" id="quanxian" value="[32]" <%if InStr(quanxian,"[32]")>0 then%>checked<%end if%>> 正式客户资料&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                            </table>
                            <span class="help-inline"></span>
                          </div>
                        </div>
                        <%
                                   exit for 
                            else 
                            end if 
                        next
                
                        %>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="<%if id<>"" then%>edit<%else%>add<%end if%>_user_submit" type="submit" class="btn btn-primary"><%if id<>"" then%>提交修改<%else%>添加员工<%end if%></button>
                          <%if id="" then%>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          <button id="search_user_submit" type="button" class="btn btn-primary">组合查询</button>
                          <%end if%>
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
                        <h5>员工列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th  width="10%">用户名</th>
                                <th nowrap="nowrap">工号</th>
                                <th>姓名</th>
                                <th>分公司</th>
                                <th>职位</th>
                                <th>上级</th>
                                <th>电话</th>
                               <th>QQ</th>
                               <th>E-mail</th>
                                <th width="15%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
if trim(request("username"))<>"" then username=" and username='"&trim(request("username"))&"'"
if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
if trim(request("company_id"))<>"" then company_id=" and company_id="&trim(request("company_id"))
if trim(request("job_id"))<>"" then job_id=" and job_id="&trim(request("job_id"))
if trim(request("lead_user"))<>"" then lead_user= " and lead_user="&trim(request("lead_user"))
if trim(request("tel"))<>"" then tel=" and tel='"&trim(request("tel"))&"'"
if trim(request("qq"))<>"" then qq=" and qq='"&trim(request("qq"))&"'"
if trim(request("email"))<>"" then email=" and email='"&trim(request("email"))&"'"

				err_txt="<tr><td colspan=""9"">没有员工</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from users where uid>0"&username&full_name&company_id&job_id&tel&qq&email&" order by uid desc",conn,1,1
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
            			showpage1=showpage(totalput,MaxPerPage,"manage_users.asp","&username="&trim(request("username"))&"&full_name="&trim(request("full_name"))&"&company_id="&trim(request("company_id"))&"&job_id="&trim(request("job_id"))&"&lead_user="&trim(request("lead_user"))&"&tel="&trim(request("tel"))&"&qq="&trim(request("qq"))&"&email="&trim(request("email")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_users.asp","&username="&trim(request("username"))&"&full_name="&trim(request("full_name"))&"&company_id="&trim(request("company_id"))&"&job_id="&trim(request("job_id"))&"&lead_user="&trim(request("lead_user"))&"&tel="&trim(request("tel"))&"&qq="&trim(request("qq"))&"&email="&trim(request("email")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_users.asp","&username="&trim(request("username"))&"&full_name="&trim(request("full_name"))&"&company_id="&trim(request("company_id"))&"&job_id="&trim(request("job_id"))&"&lead_user="&trim(request("lead_user"))&"&tel="&trim(request("tel"))&"&qq="&trim(request("qq"))&"&email="&trim(request("email")))
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
								else
									response.write "其他"
								end if
								rs1.close
								set rs1=nothing
								%></td>
                                <td style="vertical-align: middle;text-align:center">
                                    <%
                                    if rs("lead_user")="" Or IsNull(rs("lead_user")) Or IsEmpty(rs("lead_user"))then 
                                        response.write("无")
                                    else
                                        
                                        set rs2=server.CreateObject("adodb.recordset")
                                        rs2.Open "select * from users where job_number='"&rs("lead_user")&"'",conn,1,1
                                        if not rs2.eof then 
                                         response.write rs2("full_name")
                                         else 
                                         response.write "无"
                                         end if 
                                        rs2.close
                                        

                                    end if 
                                    %>
                                </td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("tel"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("qq"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("email"))%></td>
                               <td style="vertical-align: middle; text-align:center">
                                    <a href="?id=<%=int(rs("uid"))%>">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <%if rs("ifshow")=0 then%>
                                    <a href="javascript:;" id="user_Invalid_<%=int(rs("uid"))%>" class="user_Invalid">冻结</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <%else%>
                                    <a href="javascript:;" id="user_Enable_<%=int(rs("uid"))%>" class="user_Enable">解冻</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <%end if%>
                                    <a href="javascript:;" id="user_del_<%=int(rs("uid"))%>" class="user_del">删除</a>
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