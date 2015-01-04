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
                  <h5>工资模块</h5>
                </div>
                 <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label">&nbsp;员工工号:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="pay_usernumber" class="span5" name="pay_usernumber"/>
                                <span id="pay_usernumber_err" class="err_text"></span>
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label">&nbsp;月份:</label>
                            <div class="controls" style="width:500px">
                                <input type="text" id="pay_usermonth" name="pay_usermonth" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" />
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="pay_usermonth_err" class="err_text"></span>
                            </div>
                        </div>
                       <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="pay_user_submit" type="submit" class="btn btn-primary">组合查询</button>
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
                        <h5>待审批考勤列表

                          
                        </h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                              <!--<th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th>-->
                                <th>工号</th>
                                <th nowrap="nowrap">姓名</th>
                                <th>级别</th>
                                <th>底薪</th>
                                <th>月份</th>
                                <th>出勤天数</th>
                               <th>绩效奖金</th>
                               <th>绩效奖金追加</th>
                                <th>小组长津贴佣金</th> 
                                <th>加班</th>
                                <th><font color="#FF0000">社保</font></th> 
                                <th><font color="#FF0000">公积金</font></th> 
                                <th><font color="#FF0000">请假</font></th> 
                                <th><font color="#FF0000">迟到</font></th> 
                                <th><font color="#FF0000">漏打卡</font></th> 
                                <th><font color="#FF0000">旷工</font></th> 
                                <th><font color="#FF0000">其他</font></th> 
                                <th>应发工资</th> 
                                <th width="10%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                          <%
                        if trim(request("pay_usernumber"))<>"" then pay_usernumber=" and job_number='"&trim(request("pay_usernumber"))&"'"
                       '' if trim(request("pay_usermonth"))<>"" then pay_usermonth=" and mwork_name='"&trim(request("pay_usermonth"))&"'"
                       
        err_txt="<tr><td colspan=""8"">没有员工工资信息</td></tr>"
      set rs=server.CreateObject("adodb.recordset")
      rs.Open "select * from users where job_number IS NOT NULL  "&pay_usernumber&" order by uid",conn,1,1

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
                  showpage1=showpage(totalput,MaxPerPage,"manage_pay_count.asp","&pay_usernumber="&trim(request("pay_usernumber")))
              else
                  if (currentPage-1)*MaxPerPage<totalPut then
                    rs.move  (currentPage-1)*MaxPerPage
                    dim bookmark
                    bookmark=rs.bookmark
                    showContent
                    showpage1=showpage(totalput,MaxPerPage,"manage_pay_count.asp","&pay_usernumber="&trim(request("pay_usernumber")))
                else
                  currentPage=1
                    showContent
                    showpage1=showpage(totalput,MaxPerPage,"manage_pay_count.asp","&pay_usernumber="&trim(request("pay_usernumber")))
            end if
            end if
      end if
        sub showContent
        i=0
      do while not rs.eof
      %>
                              <tr>
                                 <td style="vertical-align: middle;text-align:center"><%=trim(rs("job_number"))%></td>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("full_name"))%></td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%
                                 
                                  set rsjob=server.CreateObject("adodb.recordset")
                                   rsjob.Open "select * from jobs where id="&rs("job_id")&" order by id",conn,1,1
                                   least_money=rsjob("least_money")
                                   month_money=rsjob("month_money")
                                   response.write rsjob("job_name")
                                   %>
                                </td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rsjob("base_pay"))%></td>
                                <td style="vertical-align: middle;text-align:center">2015-01</td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%
                                   rsjob.close
                                   datemonth="'"+"2015-01%"+"'"
                                   set rstody=server.CreateObject("adodb.recordset")
                                     rstody.Open "select * from work_attendance where job_number="&rs("job_number")&" and work_date like "&datemonth&" ",conn,1,1
                                    response.write rstody.recordcount
                                      rstody.close
                                  %>

                                </td>
                                <td style="vertical-align: middle;text-align:center">绩效奖金</td>
                                <td style="vertical-align: middle;text-align:center">绩效奖金追加</td>
                                <td style="vertical-align: middle;text-align:center">小组长津贴佣金</td>
                                <td style="vertical-align: middle;text-align:center">加班</td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%

                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%

                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">请假</td>
                                <td style="vertical-align: middle;text-align:center">迟到</td>
                                <td style="vertical-align: middle;text-align:center">漏打卡</td>
                                <td style="vertical-align: middle;text-align:center">旷工</td>
                                <td style="vertical-align: middle;text-align:center">其他</td>
                                <td style="vertical-align: middle;text-align:center">应发工资</td>
                                
                               <td style="vertical-align: middle; text-align:center">
                                    <a href="">查看详情</a>
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