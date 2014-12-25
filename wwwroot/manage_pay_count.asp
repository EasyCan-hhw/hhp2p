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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 员工考勤审批审批</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">

<%
if id<>"" then
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from work_application_message where wid="&id,conn,1,1
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
                  <input type="hidden" id="id" value="<%=rs("wid")%>">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;申请日期:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="mwork_tody" class="span5" name="mwork_tody" value="<%=rs("mwork_tody")%>" disabled/>
                                <span id="mwork_tody_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;员工工号:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="mwork_number" class="span5" name="mwork_number" value="<%=rs("mwork_number")%>" disabled/>
                                <span id="mwork_number_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;员工姓名:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="mwork_name" class="span5" name="mwork_name" value="<%=rs("mwork_name")%>" disabled/>
                                <span id="mwork_name_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;申请类型:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="mwork_type" class="span5" name="mwork_type" value="<%=rs("mwork_type")%>" disabled/>
                                <span id="mwork_type_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;时间:</label>
                            <div class="controls" >
                                <input type="text" id="mwork_start_time" class="span5" name="mwork_start_time" value="<%=trim(rs("mwork_start_time") \ 60)%>" style="width:35px;text-align:right" disabled/>
                                &nbsp;:&nbsp;<input type="text" id="mwork_start_time" class="span5" name="mwork_start_time" value="<%=trim(rs("mwork_start_time") mod 60)%>" style="width:35px;text-align:right" disabled/>
                                &nbsp;&nbsp;至&nbsp;&nbsp;
                                <input type="text" id="mwork_end_time" class="span5" name="mwork_end_time" value="<%=trim(rs("mwork_end_time") \ 60)%>" style="width:35px;text-align:right" disabled/>
                                &nbsp;:&nbsp;<input type="text" id="mwork_end_time" class="span5" name="mwork_end_time" value="<%=trim(rs("mwork_end_time") mod 60)%>" style="width:35px;text-align:right" disabled/>
                                <span id="mwork_time_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;日期:</label>
                            <div class="controls" style="width:217px">
                                <input type="text" id="mwork_start_date" class="span5" name="mwork_start_date" value="<%=rs("mwork_start_date")%>" disabled/>
                                &nbsp;&nbsp;至&nbsp;&nbsp;
                                <input type="text" id="mwork_end_date" class="span5" name="mwork_end_date" value="<%=rs("mwork_end_date")%>" disabled/>
                                <span id="mwork_type_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;原因:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" style="width:220px;height:150px" id="mwork_cause_txt" class="span5" name="mwork_cause_txt" value="<%=rs("mwork_cause_txt")%>" disabled/>
                                <span id="mwork_cause_txt_err" class="err_text"></span>
                            </div>
                        </div>
                        
                    <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="manage_work_submit" type="submit" class="btn btn-primary">审批</button>&nbsp;&nbsp;&nbsp;&nbsp;
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
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>员工考勤查询</h5>
                </div>
                 <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label">&nbsp;员工工号:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="sel_mwork_number" class="span5" name="sel_mwork_number"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;员工姓名:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="sel_mwork_name" class="span5" name="sel_mwork_name"/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;申请日期:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="sel_mwork_tody" name="sel_mwork_tody" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" />
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="sel_mwork_tody" class="err_text"></span>
                            </div>
                        </div>
                       <!-- <div class="control-group">
                            <label class="control-label">&nbsp;申请类型:</label>
                            <div class="controls">
                                <input type="text" id="sel_mwork_type" class="span5" name="sel_mwork_type"/>
                                <span id="email_err" class="err_text"></span>
                            </div>
                        </div>-->
                        <div class="control-group">
                          <label class="control-label"><font color="red">*</font>申请条目:</label>
                          <div class="controls">
                             <div class="span5" style="width:220px">
                                <select id="sel_mwork_type" name="sel_mwork_type" value="">
                                      <option value="" ></option>
                                        <%
                                      set rs=server.CreateObject("adodb.recordset")
                                      rs.Open "select * from work_application order by id" ,conn,1,1
                                      do while not rs.eof
                                      %>
                                      <option  value="<%=rs("work_application")%>" <%if rs("id")=work_application then%>selected<%end if%>><%=rs("work_application")%></option>
                                      <%
                                       rs.movenext
                                       loop
                                       rs.close
                                       set rs=nothing
                                      %>  
                                    </select>
                                </div>
                                <span id="work_type_err" class="err_text"></span>
                          </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="search_mwork_submit" type="submit" class="btn btn-primary">组合查询</button>
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
                        <h5>待审批考勤列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                              <th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th>
                                <th nowrap="nowrap">申请时间</th>
                                <th>员工工号</th>
                                <th>员工姓名</th>
                                <th>申请类型</th>
                               <th>时间</th>
                               <th>日期</th>
                                <th>原因</th> 
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                          <%
                        if trim(request("sel_mwork_number"))<>"" then sel_mwork_number=" and mwork_number='"&trim(request("sel_mwork_number"))&"'"
                        if trim(request("sel_mwork_name"))<>"" then sel_mwork_name=" and mwork_name='"&trim(request("sel_mwork_name"))&"'"
                        if trim(request("sel_mwork_tody"))<>"" then sel_mwork_tody=" and mwork_tody='"&trim(request("sel_mwork_tody"))&"'"
                        if trim(request("sel_mwork_type"))<>"" then sel_mwork_type=" and mwork_type='"&trim(request("sel_mwork_type"))&"'"
        err_txt="<tr><td colspan=""8"">没有待审批的债权</td></tr>"
      set rs=server.CreateObject("adodb.recordset")
      rs.Open "select * from work_application_message where mwork_tody IS NOT NULL  "&sel_mwork_number&sel_mwork_name&sel_mwork_tody&sel_mwork_type&" order by wid",conn,1,1

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
                  showpage1=showpage(totalput,MaxPerPage,"manage_examine_work.asp","&sel_mwork_number="&trim(request("sel_mwork_number"))&"&sel_mwork_name="&trim(request("sel_mwork_name"))&"&sel_mwork_tody="&trim(request("sel_mwork_tody"))&"&sel_mwork_type="&trim(request("sel_mwork_type")))
              else
                  if (currentPage-1)*MaxPerPage<totalPut then
                    rs.move  (currentPage-1)*MaxPerPage
                    dim bookmark
                    bookmark=rs.bookmark
                    showContent
                    showpage1=showpage(totalput,MaxPerPage,"manage_examine_work.asp","&sel_mwork_number="&trim(request("sel_mwork_number"))&"&sel_mwork_name="&trim(request("sel_mwork_name"))&"&sel_mwork_tody="&trim(request("sel_mwork_tody"))&"&sel_mwork_type="&trim(request("sel_mwork_type")))
                else
                  currentPage=1
                    showContent
                    showpage1=showpage(totalput,MaxPerPage,"manage_examine_work.asp","&sel_mwork_number="&trim(request("sel_mwork_number"))&"&sel_mwork_name="&trim(request("sel_mwork_name"))&"&sel_mwork_tody="&trim(request("sel_mwork_tody"))&"&sel_mwork_type="&trim(request("sel_mwork_type")))
            end if
            end if
      end if
        sub showContent
        i=0
      do while not rs.eof
      %>
                              <tr>
                                <td><input type="checkbox" name="subBox" value="<%=rs("wid")%>"/></td>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("mwork_tody"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mwork_number"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mwork_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mwork_type"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mwork_start_time") \ 60)%>&nbsp;:&nbsp;<%=trim(rs("mwork_start_time") mod 60)%>&nbsp;至&nbsp;&nbsp;<%=trim(rs("mwork_end_time")\60)%>&nbsp;:&nbsp;<%=trim(rs("mwork_end_time") mod 60)%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mwork_start_date"))%>&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;<%=trim(rs("mwork_end_date"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("mwork_cause_txt"))%></td>
                               <td style="vertical-align: middle; text-align:center">
                                   
                                    <%if rs("approval")=1 then
                                    %>
                                    <a ><font color="#FF0000">
                                     <%
                                     response.write("已审批</font></a>&nbsp;&nbsp;|&nbsp;&nbsp;") 
                                    else 
                                    %>
                                    
                                    <a href="javascript:;" id="manage_work_<%=int(rs("wid"))%>" class="manage_examine_work">
                                      <%
                                      response.write("审批</a>&nbsp;&nbsp;|&nbsp;&nbsp;") 
                                      end if%>
                                    <a href="manage_examine_work.asp?id=<%=int(rs("wid"))%>">查看详情</a>
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
                            <span class="icon" style="cursor: pointer;" id="creditor_right_approvals"> <i class="icon-tags"></i> 批量审批</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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