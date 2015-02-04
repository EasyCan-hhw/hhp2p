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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 职位管理</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>添加职位</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  
                        <div class="control-group">
                          <label class="control-label"><font color="red">*</font>&nbsp;职位:</label>
                             <div class="controls">
                              <div class="span5" style="width:220px">
                                <select id="position_id" name="position_id">
                                      <option value="" ></option>
                                        <%
                                      set rs=server.CreateObject("adodb.recordset")
                                      rs.Open "select * from position order by id" ,conn,1,1
                                      do while not rs.eof
                                      %>
                                      <option value="<%=rs("position")%>" <%if rs("id")=position_id then%>selected<%end if%>><%=rs("position")%></option>
                                      <%
                                       rs.movenext
                                       loop
                                       rs.close
                                       set rs=nothing
                                      %>
                                    </select>
                                </div>
                                <span id="err_position_id" class="err_text"></span>
                              </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;职位名称:</label>
                            <div class="controls">
                                <input type="text" id="job_name" class="half" name="job_name"/>
                                <span id="job_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                          <label class="control-label"><font color="red">*</font>工资核算:</label>
                          <div class="controls">
                            <table>
                              <tr>
                                <td > 
                                 &nbsp;&nbsp; 基本工资&nbsp;<input type="text" id="base_pay" name="base_pay" class="span5" style="width:150px;text-align:center"/><span id="err_base_pay" class="err_text"></span>
                                </td>
                              </tr>
                              <tr>
                                <td>
                                &nbsp;&nbsp;  绩效低金&nbsp;<input type="text" id="least_money" name="least_money" class="span5" style="width:150px;text-align:center"/>
                                <span id="err_least_money" class="err_text"></span>
                                </td>
                              </tr>
                              <tr>
                                <td>
                                月考核绩效&nbsp;<input type="text" id="month_money" name="month_money" class="span5" style="width:150px;text-align:center"/>&nbsp;<span class="help-inline">(单位:万)</span><span id="err_month_money" class="err_text"></span>
                                </td>
                              </tr>
                            </table>
                          </div>
                        </div>
                   <!-- <div class="control-group">
                      <label class="control-label">权限:</label>
                      <div class="controls">
                      <table>
                      <tr>
                        <td><input name="checkbox_all" type="checkbox" id="checkbox_all" onClick="check_all('checkbox_all','quanxian')"> 全选&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><input name="quanxian" type="checkbox" id="quanxian" value="[1]"> 分公司管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                        <td><input name="quanxian" type="checkbox" id="quanxian" value="[2]"> 职位管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><input name="quanxian" type="checkbox" id="quanxian" value="[3]"> 员工管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                         </tr>
                        </table>
                      </div>
                    </div>-->
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_job_submit" type="submit" class="btn btn-primary">提交</button>
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
                        <h5>职位列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap"width="15%">职位</th>
                                <th width="15%">职位名称</th>
                                <th width="15%">基本工资</th>
                                 <th width="15%">绩效低金</th>
                                 <th width="15%">月考核绩效</th>
                                
                                
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%

				err_txt="<tr><td colspan=""3"">没有职位</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from jobs order by month_money",conn,1,1
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
            			showpage1=showpage(totalput,MaxPerPage,"manage_jobs.asp","")
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_jobs.asp","")
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_jobs.asp","")
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                   <tr>
                          <td style="vertical-align: middle;text-align:center">

                            <input name="position_id<%=int(rs("id"))%>" id="position_id<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("position_id"))%>" disabled>

                          </td>
                          <td style="vertical-align: middle;text-align:center">

                            <input name="job_name<%=int(rs("id"))%>" id="job_name<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("job_name"))%>">

                          </td>
                         
                           <td style="vertical-align: middle;text-align:center">

                            <input name="base_pay<%=int(rs("id"))%>" id="base_pay<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("base_pay"))%>">

                          </td>
                           <td style="vertical-align: middle;text-align:center">

                            <input name="least_money<%=int(rs("id"))%>" id="least_money<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("least_money"))%>">

                          </td>
                          <td style="vertical-align: middle;text-align:center">

                            <input name="month_money<%=int(rs("id"))%>" id="month_money<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("month_money"))%>">
                            &nbsp;<span class="help-inline">(单位:万)</span>
                          </td>
                        <!--  <td style="vertical-align: middle;">
                              <div style="float:left; width:140px;">
                                <input name="checkbox_all< /=int(rs("id"))%>" type="checkbox" id="checkbox_all< /=int(rs("id"))%>" onClick="check_all('checkbox_all< /=int(rs("id"))%>','quanxian< /=int(rs("id"))%>')"> 
                                  全选
                              </div>
                             <div style="float:left; width:140px;"><input name="quanxian< /=int(rs("id"))%>" type="checkbox" id="quanxian< /=int(rs("id"))%>" value="[1]" < /if InStr(rs("quanxian"),"[1]")>0 then%>checked< /end if%>> 
                              分公司管理
                            </div>
                            <div style=" clear:both"></div>
                            <div style="float:left; width:140px;"><input name="quanxian< /=int(rs("id"))%>" type="checkbox" id="quanxian< /=int(rs("id"))%>" value="[2]" < /if InStr(rs("quanxian"),"[2]")>0 then%>checked< /end if%>> 
                              职位管理
                            </div>
                            <div style="float:left; width:140px;"><input name="quanxian< /=int(rs("id"))%>" type="checkbox" id="quanxian< /=int(rs("id"))%>" value="[3]" < /if InStr(rs("quanxian"),"[3]")>0 thechecke%end if%>> 员工管理
                            </div>
                            <div style=" clear:both"></div>
                        </td>-->
                        
                         <td style="vertical-align: middle; text-align:center">
                               <a href="javascript:;" id="job_edit_<%=int(rs("id"))%>" class="job_edit">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                              <a href="javascript:;" id="job_del_<%=int(rs("id"))%>" class="job_del">删除</a>
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