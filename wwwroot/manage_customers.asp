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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 客户查询</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">

<%
if id<>"" then
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from customers where id="&id,conn,1,1
if not rs.eof then
%>
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>修改客户资料</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  <input type="hidden" id="id" value="<%=rs("id")%>">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name" value="<%=rs("full_name")%>"/>
                                <span id="product_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;性别:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="sex" name="sex">
                                    	<option value="0" <%if rs("sex")=0 then%>selected<%end if%>>保密</option>
                                        <option value="1" <%if rs("sex")=1 then%>selected<%end if%>>先生</option>
                                        <option value="2" <%if rs("sex")=2 then%>selected<%end if%>>女士</option>
                                </select>
                                </div>
                                <span id="sex_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;出生日期:</label>
                            <div class="controls">
                                <input type="text" id="birth_date" name="birth_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("birth_date")%>"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="birth_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;身份证（护照号）:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport" value="<%=rs("passport")%>"/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;签发日期:</label>
                            <div class="controls">
                                <input type="text" id="lssue_date" name="lssue_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("lssue_date")%>"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="lssue_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;失效日期:</label>
                            <div class="controls">
                                <input type="text" id="expiry_date" name="expiry_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("expiry_date")%>"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="expiry_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;婚姻状况:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="marital" name="marital">
                                    	<option value="0" <%if rs("marital")=0 then%>selected<%end if%>>保密</option>
                                        <option value="1" <%if rs("marital")=1 then%>selected<%end if%>>未婚</option>
                                        <option value="2" <%if rs("marital")=2 then%>selected<%end if%>>已婚</option>
                                </select>
                                </div>
                                <span id="marital_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;联系电话:</label>
                            <div class="controls">
                                <input type="text" id="mobile" class="span5" name="mobile" value="<%=rs("mobile")%>"/>
                                <span id="mobile_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;工作城市:</label>
                            <div class="controls">
                                <input type="text" id="city" class="span5" name="city" value="<%=rs("city")%>"/>
                                <span id="city_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label">&nbsp;所属行业:</label>
                            <div class="controls">
                                <input type="text" id="industry" class="span5" name="industry" value="<%=rs("industry")%>"/>
                                <span id="industry_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;邮政编码:</label>
                            <div class="controls">
                                <input type="text" id="postcodes" class="span5" name="postcodes" value="<%=rs("postcodes")%>"/>
                                <span id="postcodes_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;电子邮箱:</label>
                            <div class="controls">
                                <input type="text" id="email" class="span5" name="email" value="<%=rs("email")%>"/>
                                <span id="email_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;通讯地址:</label>
                            <div class="controls">
                                <input type="text" id="address" class="span5" name="address" value="<%=rs("address")%>"/>
                                <span id="address_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;开户行:</label>
                            <div class="controls">
                                <input type="text" id="bank_info" class="span5" name="bank_info" value="<%=rs("bank_info")%>"/>
                                <span id="bank_info_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;银行账号:</label>
                            <div class="controls">
                                <input type="text" id="bank_account" class="span5" name="bank_account" value="<%=rs("bank_account")%>"/>
                                <span id="bank_account_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;账单寄送方式:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="notify" name="notify">
                                    	<option value="0" <%if rs("notify")=0 then%>selected<%end if%>>电邮</option>
                                        <option value="1" <%if rs("notify")=1 then%>selected<%end if%>>平信</option>
                                        <option value="2" <%if rs("notify")=2 then%>selected<%end if%>>快递</option>
                                </select>
                                </div>
                                <span id="marital_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;备注:</label>
                            <div class="controls">
                                <input type="text" id="remarks" class="span5" name="remarks" value="<%=rs("remarks")%>"/>
                                <span id="remarks_err" class="err_text"></span>
                            </div>
                        </div>
                        
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;紧急联系人姓名:</label>
                            <div class="controls">
                                <input type="text" id="emergency_name" class="span5" name="emergency_name" value="<%=rs("emergency_name")%>"/>
                                <span id="emergency_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;紧急联系人称呼:</label>
                            <div class="controls">
                                <input type="text" id="emergency_title" class="span5" name="emergency_title" value="<%=rs("emergency_title")%>"/>
                                <span id="emergency_title_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人性别:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="emergency_sex" name="emergency_sex">
                                    	<option value="0" <%if rs("emergency_sex")=0 then%>selected<%end if%>>保密</option>
                                        <option value="1" <%if rs("emergency_sex")=1 then%>selected<%end if%>>先生</option>
                                        <option value="2" <%if rs("emergency_sex")=2 then%>selected<%end if%>>女士</option>
                                </select>
                                </div>
                                <span id="emergency_sex_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;紧急联系人出生日期:</label>
                            <div class="controls">
                                <input type="text" id="emergency_birth_date" name="emergency_birth_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("emergency_birth_date")%>"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="emergency_birth_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;紧急联系人身份证:</label>
                            <div class="controls">
                                <input type="text" id="emergency_passport" class="span5" name="emergency_passport" value="<%=rs("emergency_passport")%>"/>
                                <span id="emergency_passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;紧急联系人移动电话:</label>
                            <div class="controls">
                                <input type="text" id="emergency_mobile" class="span5" name="emergency_mobile" value="<%=rs("emergency_mobile")%>"/>
                                <span id="emergency_mobile_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人固定电话:</label>
                            <div class="controls">
                                <input type="text" id="emergency_tel" class="span5" name="emergency_tel" value="<%=rs("emergency_tel")%>"/>
                                <span id="emergency_tel_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人邮箱:</label>
                            <div class="controls">
                                <input type="text" id="emergency_email" class="span5" name="emergency_email" value="<%=rs("emergency_email")%>"/>
                                <span id="emergency_email_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人地址:</label>
                            <div class="controls">
                                <input type="text" id="emergency_address" class="span5" name="emergency_address" value="<%=rs("emergency_address")%>"/>
                                <span id="emergency_address_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;客户来源:</label>
                            <div class="controls">
                              <table>
                              <tr>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="市场活动" <%if rs("custome_source")="市场活动" then%>checked<%end if%>> 市场活动</td>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="老客户推荐" <%if rs("custome_source")="老客户推荐" then%>checked<%end if%>> 老客户推荐</td>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="自有资源" <%if rs("custome_source")="自有资源" then%>checked<%end if%>> 自有资源</td>
                                </tr>
                                <tr>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="渠道" <%if rs("custome_source")="渠道" then%>checked<%end if%>> 渠道</td>
                                <td colspan="2" height="30"><%if rs("custome_source")<>"渠道" and rs("custome_source")<>"市场活动" and rs("custome_source")<>"老客户推荐" and rs("custome_source")<>"自有资源" then%><input name="custome_source" type="radio" id="custome_source" value="other" checked> 其他 <input type="text" id="custome_source_other" class="half" name="custome_source_other" value="<%=rs("custome_source")%>"/><%else%><input name="custome_source" type="radio" id="custome_source" value="other"> 其他 <input type="text" id="custome_source_other" class="half" name="custome_source_other"/><%end if%></td>
                                 </tr>
                                </table>
                                <span id="custome_source_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;渠道名称:</label>
                            <div class="controls">
                                <input type="text" id="channel_name" class="span5" name="channel_name" value="<%=rs("channel_name")%>"/>
                                <span id="channel_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;推荐人:</label>
                            <div class="controls">
                                <input type="text" id="recommend" class="span5" name="recommend" value="<%=rs("recommend")%>"/>
                                <span id="recommend_err" class="err_text"></span>
                            </div>
                        </div>
                    <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="edit_custome_submit" type="submit" class="btn btn-primary">提交</button>
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
                  <h5>客户查询</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label">&nbsp;姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;身份证（护照号）:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport"/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;联系电话:</label>
                            <div class="controls">
                                <input type="text" id="mobile" class="span5" name="mobile"/>
                                <span id="mobile_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;电子邮箱:</label>
                            <div class="controls">
                                <input type="text" id="email" class="span5" name="email"/>
                                <span id="email_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;客户来源:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="custome_source" name="custome_source">
                                    	<option value="" ></option>
                                    	<option value="市场活动" >市场活动</option>
                                        <option value="老客户推荐" >老客户推荐</option>
                                        <option value="自有资源" >自有资源</option>
                                        <option value="渠道" >渠道</option>
                                        <option value="other" >其他</option>
                                </select>
                                </div>
                                <span id="custome_source_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="search_custome_submit" type="submit" class="btn btn-primary">组合查询</button>
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
                        <h5>客户列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap">姓名</th>
                                <th>身份证</th>
                                <th>联系电话</th>
                                <th>电子邮箱</th>
                                <th>工作城市</th>
                               <th>客户来源</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
if trim(request("passport"))<>"" then passport=" and passport='"&trim(request("passport"))&"'"
if trim(request("mobile"))<>"" then mobile=" and mobile='"&trim(request("mobile"))&"'"
if trim(request("email"))<>"" then email=" and email='"&trim(request("email"))&"'"
if trim(request("custome_source"))<>"" then
	if trim(request("custome_source"))="other" then
		custome_source=" and (custome_source<>'' and custome_source<>'市场活动' and custome_source<>'老客户推荐' and custome_source<>'自有资源' and custome_source<>'渠道')"
	else
		custome_source=" and custome_source='"&trim(request("custome_source"))&"'"
	end if
end if
if trim(request("c_type"))<>"" then c_type=" and c_type="&trim(request("c_type"))

				err_txt="<tr><td colspan=""8"">没有客户</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from customers where id>0"&full_name&passport&mobile&email&custome_source&c_type&" order by id desc",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"manage_customers.asp","&c_type="&trim(request("c_type"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&mobile="&trim(request("mobile"))&"&email="&trim(request("email"))&"&custome_source="&trim(request("custome_source")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_customers.asp","&c_type="&trim(request("c_type"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&mobile="&trim(request("mobile"))&"&email="&trim(request("email"))&"&custome_source="&trim(request("custome_source")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_customers.asp","&c_type="&trim(request("c_type"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&mobile="&trim(request("mobile"))&"&email="&trim(request("email"))&"&custome_source="&trim(request("custome_source")))
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("full_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mobile"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("email"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("city"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("custome_source"))%></td>
                               <td style="vertical-align: middle; text-align:center">
                                    <a href="manage_customers.asp?id=<%=int(rs("id"))%>">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="custome_del_<%=int(rs("id"))%>" class="custome_del">删除</a>
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