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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 目标客户跟踪</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">



        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>目标客户添加或查询</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;联系电话:</label>
                            <div class="controls">
                                <input type="text" id="mobile" class="span5 customer_tracking_mobile" name="mobile"/>
                                <span id="mobile_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;客户来源:</label>
                            <div class="controls">
                              <table>
                              <tr>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="市场活动"> 市场活动</td>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="老客户推荐"> 老客户推荐</td>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="自有资源"> 自有资源</td>
                                </tr>
                                <tr>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="渠道"> 渠道</td>
                                <td colspan="2" height="30"><input name="custome_source" type="radio" id="custome_source" value="other"> 其他 <input type="text" id="custome_source_other" class="half" name="custome_source_other"/></td>
                                 </tr>
                                </table>
                                <span id="custome_source_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;业务员:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="uid" name="uid">
                                    	<option value="" ></option>
									    <%
										set rs=server.CreateObject("adodb.recordset")
										rs.Open "select * from users order by uid" ,conn,1,1
										do while not rs.eof
										%>
										<option value="<%=rs("uid")%>"><%=rs("full_name")%></option>
										<%
										 rs.movenext
										 loop
										 rs.close
										 set rs=nothing
										%>
                                </select>
                                </div>
                                 <span class="help-inline">此处查询时有效</span>
                                <span id="custome_source_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_target_customers_submit" type="button" class="btn btn-primary">添加目标客户</button>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                        <h5>目标客户列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap">姓名</th>
                                <th>联系电话</th>
                               <th>客户来源</th>
                                <th>业务员</th>
                                <th>所属分公司</th>
                               <th>录入/转移时间</th>
                               <th>最后跟进时间</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
if trim(request("mobile"))<>"" then mobile=" and mobile='"&trim(request("mobile"))&"'"
if trim(request("uid"))<>"" then follow_up_uid=" and follow_up_uid="&trim(request("uid"))&" or (isnull(follow_up_uid,0)=0 and add_uid="&trim(request("uid"))&")"
if trim(request("custome_source"))<>"" then
	if trim(request("custome_source"))="other" then
		custome_source=" and (custome_source<>'' and custome_source<>'市场活动' and custome_source<>'老客户推荐' and custome_source<>'自有资源' and custome_source<>'渠道')"
	else
		custome_source=" and custome_source='"&trim(request("custome_source"))&"'"
	end if
end if

				err_txt="<tr><td colspan=""10"">没有目标客户</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from target_customers where id>0"&full_name&mobile&custome_source&follow_up_uid&" order by id desc",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"customer_tracking.asp","&full_name="&trim(request("full_name"))&"&mobile="&trim(request("mobile"))&"&custome_source="&trim(request("custome_source"))&"&uid="&trim(request("uid")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"customer_tracking.asp","&full_name="&trim(request("full_name"))&"&mobile="&trim(request("mobile"))&"&custome_source="&trim(request("custome_source"))&"&uid="&trim(request("uid")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"customer_tracking.asp","&full_name="&trim(request("full_name"))&"&mobile="&trim(request("mobile"))&"&custome_source="&trim(request("custome_source"))&"&uid="&trim(request("uid")))
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("full_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mobile"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("custome_source"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%
								if rs("follow_up_uid")<>"" then
									uid=rs("follow_up_uid")
								else
									uid=rs("add_uid")
								end if
								set rs1=server.CreateObject("adodb.recordset")
								rs1.Open "select * from users where uid="&uid,conn,1,1
								if not rs1.eof then
									response.write rs1("full_name")
									company_id=rs1("company_id")
								end if
								rs1.close
								set rs1=nothing
								%></td>
                                <td style="vertical-align: middle;text-align:center"><%
								if company_id<>"" then
									set rs1=server.CreateObject("adodb.recordset")
									rs1.Open "select * from companys where id="&company_id,conn,1,1
									if not rs1.eof then
										response.write rs1("company_name")
									end if
									rs1.close
									set rs1=nothing
								end if
								%></td>
                                <td style="vertical-align: middle;text-align:center"><%=rs("add_date")%></td>
                                <td style="vertical-align: middle;text-align:center"><%=rs("follow_up_date")%></td>
                               <td style="vertical-align: middle; text-align:center">
                                    <a href="javascript:;" id="follow_up_<%=int(rs("id"))%>" class="follow_up">跟进</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="transfer_<%=int(rs("id"))%>" class="transfer">转移</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="del_target_customer_<%=int(rs("id"))%>" class="del_target_customer">删除</a>
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