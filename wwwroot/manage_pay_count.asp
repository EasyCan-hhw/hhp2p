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
                        <h5>工资核算

                          
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
                                
                               <th>绩效奖金</th>
                               <th>绩效奖金追加</th>
                                <th>小组长津贴佣金</th> 
                                <th>提成</th>
                                <th><font color="#FF0000">社保</font></th> 
                                <th><font color="#FF0000">公积金</font></th> 
                                <th><font color="#FF0000">请假</font></th> 
                                <th><font color="#FF0000">迟到/早退</font></th> 
                                <th><font color="#FF0000">漏打卡</font></th> 
                                <th><font color="#FF0000">旷工</font></th> 
                                <th><font color="#FF0000">其他</font></th> 
                                <th>出勤天数</th>
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
                                  intdatemonth="2015-01"'工资核算日期int依据'
                                  datemonth="'"+"2015-01%"+"'"'工资核算日期依据'
                                  set rsjob=server.CreateObject("adodb.recordset")
                                   rsjob.Open "select * from jobs where id="&rs("job_id")&" order by id",conn,1,1
                                   least_money=rsjob("least_money")
                                   month_money=rsjob("month_money")
                                   response.write rsjob("job_name")
                                   
                                   %>
                                </td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rsjob("base_pay"))%></td>
                                <%rsjob.close%>
                                <td style="vertical-align: middle;text-align:center">2015-01</td>
                                
                                <td style="vertical-align: middle;text-align:center">绩效奖金</td>
                                <td style="vertical-align: middle;text-align:center">绩效奖金追加</td>
                                <td style="vertical-align: middle;text-align:center">小组长津贴佣金</td>
                                <td style="vertical-align: middle;text-align:center">提成</td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%
                                     set rsInsurance=server.CreateObject("adodb.recordset")
                                     rsInsurance.Open "select * from users where job_number="&rs("job_number")&" ",conn,1,1
                                     if rsInsurance("add_insurance")=1 then
                                        oneInsurance=317'城镇保险
                                        response.write oneInsurance&"/元"
                                      elseif rsInsurance("add_insurance")=2 then
                                        twoInsurance=249'农村保险
                                        response.write twoInsurance&"/元"
                                        elseif rsInsurance("add_insurance")=3 then
                                        thereInsurance=0
                                        response.write ("不交保险")
                                        else 
                                        nullInsurance=0
                                        response.write ("无选项")
                                        end if 
                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%
                                    if rsInsurance("add_insurance")=1 or rsInsurance("add_insurance")=2 then 
                                      insuranceGold=113'公积金
                                      response.write insuranceGold&"/元"
                                    else
                                      response.write ("0")
                                    end if
                                      rsInsurance.close
                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">

                                  <%
                                      set rsworkApplication=server.CreateObject("adodb.recordset")
                                     rsWorkApplication.Open "select * from work_application_message where mwork_number="&rs("job_number")&" and mwork_tody like "&datemonth&" ",conn,1,1
                                     if rsWorkApplication.recordcount = 0 then 
                                     response.write "无"
                                     else
                                     Difference = 0 '请假天数'
                                      if rsWorkApplication("mwork_type") = "请假申请" then
                                        for r=1 to rsWorkApplication.recordcount
                                         startDate=rsWorkApplication("mwork_start_date")'请假开始日期'
                                         endDate=rsWorkApplication("mwork_end_date")'请假结束日期'
                                         Difference=Difference + DateDiff("H",rsWorkApplication("mwork_start_date"),rsWorkApplication("mwork_end_date"))/24
                                         rsWorkApplication.movenext
                                         next
                                      else 

                                      end if 
                                      response.write Difference&"天"
                                     end if 
                                     rsworkApplication.close
                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%
                                     set rssetrest=server.CreateObject("adodb.recordset")
                                     rssetrest.Open "select * from setrest_worktime where setrest_year like "&datemonth&" ",conn,1,1
                                     if not rssetrest.eof then 
                                         start_worktime=rssetrest("start_worktime")'规定的上班作息时间'
                                         end_worktime=rssetrest("end_worktime")'规定的下班作息时间'
                                         rssetrest.close
                                        rssetrest.Open "select * from work_attendance where job_number="&rs("job_number")&" and work_date like "&datemonth&" ",conn,1,1
                                        if rssetrest.eof then 
                                            response.write "无"
                                        else 
                                          
                                          mcount = rssetrest.recordcount
                                          closeglod = 0 '迟到、早退 扣除的金额'
                                     
                                          for i=1 to mcount
                                          starttime = rssetrest("start_time")'下班时间'
                                          endtime = rssetrest("end_time")'下班时间'                             
                                              if starttime > CInt(start_worktime) then 
                                                    'response.write "_上班时间"&starttime&"/迟到时间"

                                                  startint = cint(starttime)-Cint(start_worktime)'上班迟到时间'
                                                  'response.write startint&"/扣除工资"
                                                  
                                                    if startint <= 10 then 
                                                    closeglod = closeglod + 10
                                                    elseif startint > 10 and startint <= 30 then 
                                                    closeglod = closeglod + 20
                                                    elseif startint > 30 and startint <= 60 then 
                                                    closeglod = closeglod + 50 
                                                    else 
                                                      closeglod = closeglod + 100 '旷工处理'
                                                      kuanggong = kuanggong + 1
                                                    end if 
                                                   
                                              end if  
                                              
                                               if endtime < CInt(end_worktime) then 
                                              
                                                    
                                                    endint = Cint(end_worktime) - cint(endtime)'下班迟到时间'
                                                  
                                                    if endint > 0 and endint <= 10 then 
                                                    closeglod = closeglod + 10
                                                    elseif endint > 10 and endint <= 30 then 
                                                    closeglod = closeglod + 20
                                                    elseif endint > 30 and endint <= 60 then 
                                                    closeglod = closeglod + 50 
                                                    else 
                                                      closeglod = closeglod + 100 '旷工处理'
                                                      kuanggong = kuanggong + 1
                                                    end if 
                                                end if   
                                              rssetrest.movenext
                                          next 
                                           response.write closeglod&"/元"
                                        end if 
                                     else
                                        response.write "没有该月作息时间"
                                     end if 
                                     rssetrest.close
                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%  '漏打卡'
                                  
                                         'Start计算给定当月的天数'
                                           ym = split(intdatemonth,"-")
                                           oldInty=cint(ym(0))
                                           oldIntm=cint(ym(1))
                                           testdate = 0
                                           oldDate = oldInty&"-"&oldIntm&"-1"
                                           if oldIntm+1 >12 then 
                                            inty = oldInty + 1
                                            oldDate2 = inty&"-1-1"
                                            newDate2 = DateAdd("d",-1,inty&"-2-1")
                                            'testdate = DateDiff("d",oldDate2,newDate2)
                                            testdate = DateDiff("d",oldInty&"-"&oldIntm&"-1",inty&"-1-1")
                                           else
                                            newDate = oldInty&"-"&oldIntm+1&"-1"
                                            testdate = DateDiff("d",oldDate,newDate)
                                           end if
                                            'response.write testdate
                                            dim  fordate
                                            redim fordate(testdate)'得到该月所有天数的日期格式'
                                            newmdate = dateadd("d",-1,intdatemonth&"-1")

                                            for da=0 to testdate-1 
                                              fordate(da) = DateAdd("d",+1,newmdate)
                                              newmdate = fordate(da)
                                              
                                            next
                                          
                                          'End计算给定当月的天数'
                                          
                                          '获得员工该月请假天数'
                                          dim mvacation
                                          dim mels
                                          mstr = "'"+"请假申请"+"'"
                                          set rsdaka=server.CreateObject("adodb.recordset")
                                          rsdaka.Open "select * from work_application_message where mwork_number='"&rs("job_number")&"' and mwork_type="&mstr&" and  mwork_tody like "&datemonth&" ",conn,1,1

                                           
                                          if not rsdaka.eof then
                                            for rse=1 to rsdaka.recordcount
                                              start_date=rsdaka("mwork_start_date")'拿出请假开始日期用于for运算'
                                             els = DateDiff("d",start_date,rsdaka("mwork_end_date"))'计算请假区间，拿出天数'
                                             maxels= maxels + els
                                             redim mels(els)
                                                for e=0 to els - 1 'for循环拿出请假期间每天的日期'
                                                  mels(e) =  DateAdd("d",+1,start_date)
                                                  start_date = DateAdd("d",+1,start_date)
                                                  'response.write mels(e)&"^"'得到这个月员工的请假所有日期'**
                                                next
                                              rsdaka.movenext
                                            next
                                          else 

                                          end if 
                                        
                                        rsdaka.close
                                            
                                          Dim myDate
                                          '获得员工这个月的打卡天数'
                                          rsdaka.Open "select work_date from work_attendance where job_number="&rs("job_number")&" and  work_date like "&datemonth&" ",conn,1,1
                                          redim myDate(rsdaka.recordcount)
                                          if not rsdaka.eof then 
                                            for Ddate=0 to rsdaka.recordcount - 1 
                                              myDate(Ddate) = rsdaka("work_date")
                                              rsdaka.movenext
                                              'response.write myDate(Ddate)&"_"'得到员工该月所有打卡日期'
                                            next
                                           
                                          else 
                                          
                                          end if
                                           for maxels = 0 to rsdaka.recordcount -1
                                            'response.write myDate(maxels)
                                            next
                                          
                                          rsdaka.close


                                          '获得这个月的假期天数'
                                          rsdaka.Open "select * from vacation_manage where vacation_date like "&datemonth&" ",conn,1,1
                                          if not rsdaka.eof then 
                                            for Xdate=1 to rsdaka.recordcount 
                                              Udate=rsdaka("vacation_date")
                                              rsdaka.movenext
                                            next
                                          else 
                                          response.write "该月没有设置假期"
                                          end if 
                                          rsdaka.close
                                          set rsdaka=nothing

                                          'for d=1 to testdate 
                                           '' set rsleak=server.CreateObject("adodb.recordset")
                                         

                                         
                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">旷工</td>
                                <td style="vertical-align: middle;text-align:center">其他</td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%
                                   set rstody=server.CreateObject("adodb.recordset")
                                     rstody.Open "select * from work_attendance where job_number="&rs("job_number")&" and work_date like "&datemonth&" ",conn,1,1
                                    response.write rstody.recordcount 
                                      rstody.close
                                  %>
                                </td>
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
                            <!--<span class="icon" style="cursor: pointer;" id="creditor_right_approvals"> <i class="icon-tags"></i> 批量审批</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
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