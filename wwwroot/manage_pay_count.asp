<!--#include file="head.asp" -->
<!--#include file="company_function.asp"-->
<!--#include file="calculate_performance.asp" -->
<%
      
      class valMy
          public val1
         public val2
     end class
        function dateNumber(inputdate)
         
       set dateNumber= new valMy
             '' intdatemonth="2015-01"
               'Start计算给定当月的天数'
                 ym = split(inputdate,"-")
                 oldInty=cint(ym(0))
                 oldIntm=cint(ym(1))
                 testdate = 0
                 oldDate = oldInty&"-"&oldIntm&"-1"
                 if oldIntm+1 >12 then 
                  inty = oldInty + 1
                  oldDate2 = inty&"-1-1"
                  newDate2 = DateAdd("d",-1,inty&"-2-1")
                  
                  testdate = DateDiff("d",oldInty&"-"&oldIntm&"-1",inty&"-1-1")
                 else
                  newDate = oldInty&"-"&oldIntm+1&"-1"
                  testdate = DateDiff("d",oldDate,newDate)
                 end if
                 
                  dim  fordate
                  redim fordate(testdate)
                  newmdate = dateadd("d",-1,inputdate&"-1")
                 
                    '该月的天数'
                    dateNumber.val1 = testdate
                    '该月的第一天'
                    dateNumber.val2 = newmdate
                    
        end function


       function   endResult(sdate,newdate)
        dim mels
        redim mels(els)
        for e=0 to els - 1 'for循环拿出请假期间每天的日期'
         mels(e) =  DateAdd("d",+1,sdate)
         sdate = DateAdd("d",+1,sdate)
        'response.write mels(e)&"^"'得到这个月员工的请假所有日期'**
        '----------判断是否属于请假日期---------------'
          if newdate <> mels(e) then 
              '获得这个月的假期天数'
               set rsdakavacation=server.CreateObject("adodb.recordset")
               rsdakavacation.Open "select * from vacation_manage where vacation_date like "&datemonth&" ",conn,1,1
                dim Svacation
               redim Svacation(rsdakavacation.recordcount)
              if not rsdakavacation.eof then 
                for Xdate=0 to rsdakavacation.recordcount -1
                    'Udate=rsdakavacation("vacation_date")
                    Svacation(Xdate) = rsdakavacation("vacation_date")
                      '--------------判断是否属于假期的日期---------------'
                    if newdate <> Svacation(Xdate) then 
                     forget_attendance = forget_attendance + 1
                      endResult = forget_attendance
                    end if 
                       rsdakavacation.movenext
                next
              else 
                response.write "该月没有设置假期"
               end if 
                   
         end if 

       next                                                                        
      end function
                                    

%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
  <!--breadcrumbs-->
  <div id="content-header">
      <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 工资</a></div>
  </div>
  <!--End-breadcrumbs-->

  <div class="container-fluid">

<%
if id<>"" then

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
                          <label class="control-label"><font color="red">*</font>&nbsp;月份:</label>
                          <div class="controls" style="width:500px">
                              <input type="text" id="pay_usermonth" name="pay_usermonth" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=Request("pay_usermonth")%>" />
                              <span class="help-inline">取值：1970-01</span>
                              <span id="pay_usermonth_err" class="err_text"></span>
                          </div>
                      </div>
                      <div class="control-group">
                          <label class="control-label"><font color="red">*</font>选择计算方式:</label>
                          <div class="controls">
                             <div class="span5" style="width:220px">
                                <select id="choose_fashion" name="choose_fashion" value="">
                                      <option value="" ></option>
                                      <option value="1" >按上海方式</option>
                                      <option value="2" >按温州方式</option>
                                    </select>
                                </div>
                                <span id="work_type_err" class="err_text"></span>
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
                    <%
                       if trim(request("choose_fashion"))<>"" then '获得工资计算方式'
                        choose_fashion = request.form("choose_fashion")
                        response.cookies("hhp2p_cookies")("choose_fashion")=choose_fashion
                       end if 
                       '工资计算方法判断'
                        choose = request.cookies("hhp2p_cookies")("choose_fashion")
                        if choose=1 then 
                        %>

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
                             if trim(request("pay_usermonth"))<>"" then '获得月份写入cookies'
                               pay_usermonth=request.form("pay_usermonth")
                               response.cookies("hhp2p_cookies")("pay_usermonth")=pay_usermonth
                             end if 
                                err_txt="<tr><td colspan=""8"">没有工资信息</td></tr>"
                                companyId = request.cookies("hhp2p_cookies")("company_id")
                               set rs=server.CreateObject("adodb.recordset")

                               if choose="" then 
                                response.write "<tr><td colspan=""8"">没有选择计算方式</td></tr>"
                               end if 
                              
                              rs.Open "select * from users where job_number IS NOT NULL  "&pay_usernumber&" and ( company_id="&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&" or company_code='"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"' )  order by uid",conn,1,1
                         
                           paymonth = request.cookies("hhp2p_cookies")("pay_usermonth")
                               paymonth = request.cookies("hhp2p_cookies")("pay_usermonth")
                            if paymonth="" then 
                            response.write "<tr><td colspan=""8"">没有选择月份</td></tr>"
                            end if       

                              if err.number<>0 or rs.eof  then
                              response.write err_txt
                            end if

                            response.write set_monthPay
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
                                        showContent1
                                        showpage1=showpage(totalput,MaxPerPage,"manage_pay_count.asp","")
                                    else
                                        if (currentPage-1)*MaxPerPage<totalPut then
                                          rs.move  (currentPage-1)*MaxPerPage
                                          dim bookmark
                                          bookmark=rs.bookmark
                                          showContent1
                                          showpage1=showpage(totalput,MaxPerPage,"manage_pay_count.asp","")
                                        else
                                        currentPage=1
                                          showContent1
                                          showpage1=showpage(totalput,MaxPerPage,"manage_pay_count.asp","")
                                        end if
                                   end if

                            end if
                              
                              sub showContent1
                             
                              i=0
                            
                            do while not rs.eof and not paymonth=""
                            %>
                            <tr>
                             

                               <td style="vertical-align: middle;text-align:center"><%=trim(rs("job_number"))%></td>
                              <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("full_name"))%></td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                  month_pay = split(paymonth,"-") 
                                    intdatemonth=month_pay(0)&"-"&month_pay(1)'工资核算日期int依据'
                                    datemonth="'"+month_pay(0)&"-"&month_pay(1)&"%"+"'"'工资核算日期依据'
                                    forget_attendance = 0 '漏打卡'
                                    set rsjob=server.CreateObject("adodb.recordset")
                                   rsjob.Open "select * from jobs where id="&rs("job_id")&" order by id",conn,1,1

                                   if not rsjob("least_money")=0 then '拿到绩效低金'
                                   least_money=rsjob("least_money")
                                   else 
                                   least_money = 0
                                   end if 
                                   if not rsjob("month_money") then '拿到月考核绩效'
                                   month_money=rsjob("month_money")
                                   else 
                                   month_money=0
                                   end if 
                                   response.write rsjob("job_name")
                                 %>
                              </td>
                              <td style="vertical-align: middle;text-align:center"><%

                              basePay = rsjob("base_pay")
                              rsjob.close
                              response.write basePay
                              %>
                              </td>
                              
                              <td style="vertical-align: middle;text-align:center"><%=intdatemonth%></td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                set isnulldate=server.CreateObject("adodb.recordset")
                                isnulldate.Open "select * from contracts where approval_date is not null",conn,1,1
                                if not isnulldate.eof then 
                                    '绩效奖金'
                                   'testString = "2015-01%"
                                   Salaryperformence  = 0
                                    testPerformence = performence(datemonth)
                                    if month_money=0 or least_money=0 then 
                                      response.write "无绩效"
                                    else 
                                        BMoney = month_money*10000 '月考核数'
                                        leastMoney = least_money  '绩效低金'

                                        for h=0 to Ubound(testPerformence) 
                                          test = testPerformence(h)
                                          if test(0) = rs("job_number") then 
                                            money_performence=leastMoney*test(1)/BMoney
                                             Response.write round(money_performence,2)
                                             Exit for
                                          else 
                                            
                                          end if
                                        next
                                     Salaryperformence = round(money_performence,2)
                                    end if 
                                  else 
                                 end if  
                                isnulldate.close
                                set isnulldate = nothing
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                  <%
                                  '绩效奖金追加'
                                    addedPerformence = 0
                                    set rscommission=server.CreateObject("adodb.recordset")
                                    rscommission.Open "select * from Commission_manage where Cjob_number='" & rs("job_number") & "'",conn,1,1
                                      if not rscommission.eof then
                                        if rscommission("Cjixiao") <> 0 then
                                        addedPerformence = rscommission("Cjixiao")
                                            response.write addedPerformence
                                        else
                                          response.write "无"
                                        end if 
                                      else
                                        response.write "无"
                                      end if 
                                  %>
                              </td>
                               <td style="vertical-align: middle;text-align:center">
                                <%
                                '小组长津贴佣金'
                                  addedcommission = 0
                                  if not rscommission.eof then
                                        if rscommission("Cchargehand") <> 0 then
                                        addedcommission = rscommission("Cchargehand")
                                            response.write addedcommission
                                        
                                        else
                                          response.write "无"
                                        end if 

                                  else
                                    response.write "无"
                                  end if 
                                  rscommission.close
                                  set rscommission = nothing
                                %>
                              </td>
                              
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                  '提成'
                                  trueperformence  = 0
                                  selfPerformence =  getmySelfPerformence(rs("job_number"),datemonth)
                                  SubordinatesPerformence = ordinatesPerformence(rs("job_number"),datemonth)-selfPerformence
                                 
                                  self = sumSection(rs("job_id"),selfPerformence,1)
                                  subordinates = sumSection(rs("job_id"),SubordinatesPerformence,0)
                                  trueperformence = round(self+subordinates,2)
                                  response.write trueperformence
                                %>

                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                Insurance=0
                                   set rsInsurance=server.CreateObject("adodb.recordset")
                                   rsInsurance.Open "select * from users where job_number='"&rs("job_number")&"' ",conn,1,1
                                   if rsInsurance("add_insurance")=1 then
                                      Insurance=317'城镇保险
                                      response.write Insurance&"/元"
                                    elseif rsInsurance("add_insurance")=2 then
                                      Insurance=249'农村保险
                                      response.write Insurance&"/元"
                                      elseif rsInsurance("add_insurance")=3 then
                                      Insurance=0
                                      response.write ("不交保险")
                                      else 
                                      nullInsurance=0
                                      response.write ("无选项")
                                      end if 
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                  insuranceGold = 0
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
                                intDifference = 0

                                    set rsworkApplication=server.CreateObject("adodb.recordset")
                                   rsWorkApplication.Open "select * from work_application_message where mwork_number='"&rs("job_number")&"' and mwork_tody like "&datemonth&" ",conn,1,1
                                   if rsWorkApplication.recordcount = 0 then 
                                   response.write "无"
                                   else
                                   Difference = 0 '请假天数'
                                    if rsWorkApplication("mwork_type") = "请假申请" then
                                        set rsw=server.CreateObject("adodb.recordset")
                                        rsw.Open "select * from jobs where id="&rs("job_id")&" ",conn,1,1
                                        hours = rsw("base_pay")/30/8

                                        rsw.close
                                        set rsw=nothing
                                        hnumber = 0
                                        for  r=1 to rsWorkApplication.recordcount
                                         hnumber = hnumber + rsWorkApplication("mwork_input_hour")
                                        next

                                        Difference = hours * hnumber
                                      'for r=1 to rsWorkApplication.recordcount
                                       'startDate=rsWorkApplication("mwork_start_date")'请假开始日期'
                                       'endDate=rsWorkApplication("mwork_end_date")'请假结束日期'
                                       'Difference=Difference + DateDiff("H",rsWorkApplication("mwork_start_date"),rsWorkApplication("mwork_end_date"))/24
                                       'rsWorkApplication.movenext
                                       'next
                                    else 

                                    end if 
                                    'response.write  Round(Difference, 2)&"元"
                                    intDifference = Round(Difference, 2)
                                    response.write hnumber&"小时/"&intDifference&"元"
                                   end if 
                                   rsworkApplication.close
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                   set rssetrest=server.CreateObject("adodb.recordset") 
                                   rssetrest.Open "select * from setrest_worktime where company_number='"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"' and  setrest_year like "&datemonth&" ",conn,1,1
                                   if not rssetrest.eof then 
                                       start_worktime=rssetrest("start_worktime")'规定的上班作息时间'
                                       end_worktime=rssetrest("end_worktime")'规定的下班作息时间'
                                       rssetrest.close
                                      rssetrest.Open "select * from work_attendance where job_number='"&rs("job_number")&"' and work_date like "&datemonth&" ",conn,1,1
                                      if rssetrest.eof then 
                                          response.write "无"
                                      else 
                                        mcount = rssetrest.recordcount
                                        closeglod = 0 '迟到、早退 扣除的金额'
                                        lateNumber = 0
                                        workhours = 0
                                        for index=1 to mcount
                                          starttime = rssetrest("start_time")'上班时间'
                                          endtime = rssetrest("end_time")'下班时间'                             
                                            if starttime > CInt(start_worktime) then 
                                                  'response.write "_上班时间"&starttime&"/迟到时间"
                                                  workstart = starttime
                                                startint = cint(starttime)-Cint(start_worktime)'上班迟到时间'
                                                'response.write startint&"/扣除工资"
                                                  if startint <= 10 then 
                                                    lateNumber = lateNumber + 1
                                                    if lateNumber > 3 then  '迟到前三次免责'
                                                     closeglod = closeglod + 10
                                                    end if 
                                                  elseif startint > 10 and startint <= 30 then 
                                                  closeglod = closeglod + 20
                                                  elseif startint > 30 and startint <= 60 then 
                                                  closeglod = closeglod + 50 
                                                  else 
                                                    closeglod = closeglod + 100 '旷工处理'
                                                    forget_attendance = forget_attendance + 1
                                                    workhours = workhours + startint\60
                                                    workhours1 = startint mod 60
                                                  end if 
                                                 
                                            end if  
                                            
                                             if endtime < CInt(end_worktime) then 
                                            
                                                  workend = endtime
                                                  endint = Cint(end_worktime) - cint(endtime)'下班早退时间'
                                                  if endint > 0 and endint <= 10 then 
                                                  closeglod = closeglod + 10
                                                  elseif endint > 10 and endint <= 30 then 
                                                  closeglod = closeglod + 20
                                                  elseif endint > 30 and endint <= 60 then 
                                                  closeglod = closeglod + 50 
                                                  else 
                                                    closeglod = closeglod + 100 '旷工处理'
                                                    forget_attendance = forget_attendance + 1
                                                    workhours = workhours + endint\60
                                                    workhours2 = endint mod 60
                                                  end if 
                                              end if
                                            rssetrest.movenext
                                        next 
                                        response.write closeglod
                                         'response.write closeglod&"/元迟到早退次数"&forget_attendance&"/迟到早退小时数"&workhours&"/迟到分钟数"&workhours1&"/早退分钟数"&workhours2&"/迟到时间"&workstart&"/早退时间"&workend
                                      end if 
                                   else
                                      response.write "没有该月作息时间"
                                   end if 
                                   rssetrest.close
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                
                                <%  
                                
                                   set missWork=server.CreateObject("adodb.recordset")
                                    missw = "'"+"考勤申诉"+"'"
                                   missWork.Open "select * from work_application_message where mwork_number='"&rs("job_number")&"' and mwork_type like "&missw&" ",conn,1,1
                                    forgetWork = 0
                                    if not missWork.eof then
                                     
                                      for miss=0 to  missWork.recordcount-1 

                                        forgetWork = forgetWork + 10
                                      next
                                     response.write forgetWork&"元/"&missWork.recordcount&"次"
                                    else
                                      response.write "无"
                                    end if 
                                       
                                %>

                              </td>
                             
                              <td style="vertical-align: middle;text-align:center">
                                 <%  
                                      '本月应该打卡的天数'
                                          workNumber = 0
                                          workdate = 0
                                        '该月的第一天 dateNumber.val2 该月的天数 dateNumber.val1  

                                        myDatenumber = dateNumber(intdatemonth).val1
                                        '拿到本月的假期天数'
                                        set vacationDate=server.CreateObject("adodb.recordset")
                                        vacationDate.Open "select * from vacation_manage where vacation_date like "&datemonth&" ",conn,1,1
                                        workDateNumber = myDatenumber - vacationDate.recordcount
                                        workdate = workDateNumber
                                       vacationDate.close
                                       '拿出请假申请天数'
                                       mstr = "'"+"请假申请"+"'"
                                       vacationDate.Open "select * from work_application_message where mwork_number='"&rs("job_number")&"' and mwork_type="&mstr&" and  mwork_tody like "&datemonth&" ",conn,1,1
                                        
                                        hoursNumber = 0
                                        
                                        if not vacationDate.eof then
                                          for rse=1 to vacationDate.recordcount
                                            'start_date=vacationDate("mwork_start_date")'拿出请假开始日期用于for运算'
                                           'els = els + DateDiff("d",start_date,vacationDate("mwork_end_date"))'计算请假区间，拿出天数'
                                            hoursNumber = hoursNumber + vacationDate("mwork_input_hour")
                                           
                                            vacationDate.movenext
                                          next
                                        else 

                                        end if 
                                        els = round(hoursNumber/8,0)
                                        
                                       workDateNumber = workDateNumber - els
                                       workNumber = workDateNumber
                                       vacationDate.close
                                       '拿到本月打卡的天数'
                                       vacationDate.Open "select * from work_attendance where job_number='"&rs("job_number")&"' and  work_date like "&datemonth&" ",conn,1,1
                                       workDateNumber = workDateNumber - vacationDate.recordcount 
                                       forget_attendance = forget_attendance +workDateNumber
                                       response.write workDateNumber&"天/"&workDateNumber*100&"元"
                                       '旷工总次数*100+旷工总小时数*（底薪/21.75/8）= 该月的旷工应扣除的金额
                                       Zkuanggong =  workDateNumber*100 + workDateNumber*(basepay/21.75) 
                                       set vacationDate = nothing
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">其他</td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                 set rstody=server.CreateObject("adodb.recordset")
                                   rstody.Open "select * from work_attendance where job_number='"&rs("job_number")&"' and work_date like "&datemonth&" ",conn,1,1
                                  response.write rstody.recordcount 
                                    rstody.close
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center"><%

                              '应发工资'

                              ' + basePay + Salaryperformence + addedPerformence + addedcommission + trueperformence - Insurance - insuranceGold - intDifference - closeglod - forgetWork - (workDateNumber*100) - workDateNumber*(basepay/workDateNumber)
                              'response.write basePay&"+"& Salaryperformence &"+"& addedPerformence &"+"& addedcommission &"+"& trueperformence &"-"& Insurance &"-"& insuranceGold &"-"& intDifference &"-"& closeglod &"-"& forgetWork &"-"& (workDateNumber*100) &"-"& workDateNumber*round(basepay/workdate,2)
                              response.write "pay="&basePay + Salaryperformence + addedPerformence + addedcommission + trueperformence - Insurance - insuranceGold - intDifference - closeglod - forgetWork - (workDateNumber*100) - workDateNumber*round(basepay/workdate,2)
                              %></td>
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
                       <%
                        else
                          %>
                          <table class="table table-bordered table-striped with-check">
                          <thead>
                           

                          <tr>
                            <!--<th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th>-->
                              <th>工号</th>
                              <th nowrap="nowrap">姓名</th>
                              <th>级别</th>
                              <th>底薪</th>
                              <th>月份</th>
                             <th>绩效部分</th>
                             <th>业务提成</th>
                              <th>岗位提成</th> 
                              <th><font color="#FF0000">社保</font></th> 
                              <th><font color="#FF0000">公积金</font></th> 
                              <th><font color="#FF0000">请假</font></th> 
                              <th><font color="#FF0000">迟到/早退</font></th> 
                              <th><font color="#FF0000">漏打卡</font></th> 
                              <th><font color="#FF0000">旷工</font></th> 
                              <th><font color="#FF0000">全勤奖</font></th> 
                              <th>出勤天数</th>
                              <th>应发工资</th> 
                              <th width="10%">操作</th>
                          </tr>
                          </thead>
                          <tbody>
                        <%

                            if trim(request("pay_usernumber"))<>"" then pay_usernumber=" and job_number='"&trim(request("pay_usernumber"))&"'"
                           if trim(request("pay_usermonth"))<>"" then '获得月份写入cookies'
                           pay_usermonth=request.form("pay_usermonth")
                           response.cookies("hhp2p_cookies")("pay_usermonth")=pay_usermonth
                           end if 
                          
                            err_txt="<tr><td colspan=""8"">没有工资信息</td></tr>"
                            companyId = request.cookies("hhp2p_cookies")("company_id")
                           set rs=server.CreateObject("adodb.recordset")

                           if choose="" then 
                            response.write "<tr><td colspan=""8"">没有选择计算方式</td></tr>"
                           end if 
                          rs.Open "select * from users where job_number IS NOT NULL  "&pay_usernumber&" and ( company_id="&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&" or company_code='"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"' )  order by uid",conn,1,1
                         
                          paymonth = request.cookies("hhp2p_cookies")("pay_usermonth")
                          if paymonth="" then 
                          response.write "<tr><td colspan=""8"">没有选择月份</td></tr>"
                          end if 
                            if err.number<>0 or rs.eof  then
                            response.write err_txt
                          end if
                          response.write set_monthPay
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
                                        dim bookmark1
                                        bookmark1=rs.bookmark
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
                            
                          do while not rs.eof and not paymonth=""
                          %>
                            <tr>
                             

                               <td style="vertical-align: middle;text-align:center"><%=trim(rs("job_number"))%></td>
                              <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("full_name"))%></td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                  month_pay = split(paymonth,"-") 
                                    intdatemonth=month_pay(0)&"-"&month_pay(1)'工资核算日期int依据'
                                    datemonth="'"+month_pay(0)&"-"&month_pay(1)&"%"+"'"'工资核算日期依据'
                                    forget_attendance = 0 '漏打卡'
                                    set rsjob=server.CreateObject("adodb.recordset")
                                   rsjob.Open "select * from jobs where id="&rs("job_id")&" order by id",conn,1,1
                                   if not rsjob("least_money")=0 then '拿到绩效低金'
                                   least_money=rsjob("least_money")
                                   else 
                                   least_money = 0
                                   end if 
                                   if not rsjob("month_money") then '拿到月考核绩效'
                                   month_money=rsjob("month_money")
                                   else 
                                   month_money=0
                                   end if 
                                   response.write rsjob("job_name")
                                 %>
                              </td>
                              <td style="vertical-align: middle;text-align:center"><%

                              basePay = rsjob("base_pay")
                              rsjob.close
                              response.write basePay
                              %>
                              </td>
                              
                              <td style="vertical-align: middle;text-align:center"><%=intdatemonth%></td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                 set isnulldateWenZhou=server.CreateObject("adodb.recordset")
                                isnulldateWenZhou.Open "select * from contracts where approval_date is not null",conn,1,1
                                if not isnulldateWenZhou.eof then 
                                      '绩效奖金'
                                     'testString = "2015-01%"
                                     Salaryperformence  = 0
                                      testPerformence = performence(datemonth)
                                      if month_money=0 or least_money=0 then 
                                        response.write "无绩效"
                                      else 
                                          BMoney = month_money*10000 '月考核数'
                                          leastMoney = least_money  '绩效低金'

                                          for h=0 to Ubound(testPerformence) 
                                            test = testPerformence(h)
                                            if test(0) = rs("job_number") then 
                                              money_performence=leastMoney*test(1)/BMoney
                                               Response.write round(money_performence,2)
                                               Exit for
                                            else 
                                              
                                            end if
                                          next
                                       Salaryperformence = round(money_performence,2)
                                      end if 
                                else 
                                end if       
                                isnulldateWenZhou.close
                                set isnulldateWenZhou = nothing
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                  <%
                                    addedPerformence = 0
                                    set rscommission=server.CreateObject("adodb.recordset")
                                    rscommission.Open "select * from Commission_manage where Cjob_number='" & rs("job_number") & "'",conn,1,1
                                      if not rscommission.eof then
                                        if rscommission("Cjixiao") <> 0 then
                                        addedPerformence = rscommission("Cjixiao")
                                            response.write addedPerformence
                                        else
                                          response.write "无"
                                        end if 
                                      else
                                        response.write "无"
                                      end if 
                                  %>
                              </td>
                              
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                  '提成'
                                  trueperformence  = 0
                                  selfPerformence =  getmySelfPerformence(rs("job_number"),datemonth)
                                  SubordinatesPerformence = ordinatesPerformence(rs("job_number"),datemonth)-selfPerformence
                                 
                                  self = sumSection(rs("job_id"),selfPerformence,1)
                                  subordinates = sumSection(rs("job_id"),SubordinatesPerformence,0)
                                  trueperformence = round(self+subordinates,2)
                                  response.write trueperformence
                                %>

                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                Insurance=0
                                   set rsInsurance=server.CreateObject("adodb.recordset")
                                   rsInsurance.Open "select * from users where job_number='"&rs("job_number")&"' ",conn,1,1
                                   if rsInsurance("add_insurance")=1 then
                                      Insurance=317'城镇保险
                                      response.write Insurance&"/元"
                                    elseif rsInsurance("add_insurance")=2 then
                                      Insurance=249'农村保险
                                      response.write Insurance&"/元"
                                      elseif rsInsurance("add_insurance")=3 then
                                      Insurance=0
                                      response.write ("不交保险")
                                      else 
                                      nullInsurance=0
                                      response.write ("无选项")
                                      end if 
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                  insuranceGold = 0
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
                                intDifference = 0

                                    set rsworkApplication=server.CreateObject("adodb.recordset")
                                   rsWorkApplication.Open "select * from work_application_message where mwork_number='"&rs("job_number")&"' and mwork_tody like "&datemonth&" ",conn,1,1
                                   if rsWorkApplication.recordcount = 0 then 
                                   response.write "无"
                                   else
                                   Difference = 0 '请假天数'
                                    if rsWorkApplication("mwork_type") = "请假申请" then
                                        set rsw=server.CreateObject("adodb.recordset")
                                        rsw.Open "select * from jobs where id="&rs("job_id")&" ",conn,1,1
                                        hours = rsw("base_pay")/30/8

                                        rsw.close
                                        set rsw=nothing
                                        hnumber = 0
                                        for  r=1 to rsWorkApplication.recordcount
                                         hnumber = hnumber + rsWorkApplication("mwork_input_hour")
                                        next

                                        Difference = hours * hnumber
                                      'for r=1 to rsWorkApplication.recordcount
                                       'startDate=rsWorkApplication("mwork_start_date")'请假开始日期'
                                       'endDate=rsWorkApplication("mwork_end_date")'请假结束日期'
                                       'Difference=Difference + DateDiff("H",rsWorkApplication("mwork_start_date"),rsWorkApplication("mwork_end_date"))/24
                                       'rsWorkApplication.movenext
                                       'next
                                    else 

                                    end if 
                                    'response.write  Round(Difference, 2)&"元"
                                    intDifference = Round(Difference, 2)
                                    response.write hnumber&"小时/"&intDifference&"元"
                                   end if 
                                   rsworkApplication.close
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                   set rssetrest=server.CreateObject("adodb.recordset") 
                                   rssetrest.Open "select * from setrest_worktime where company_number='"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"' and  setrest_year like "&datemonth&" ",conn,1,1
                                   if not rssetrest.eof then 
                                       start_worktime=rssetrest("start_worktime")'规定的上班作息时间'
                                       end_worktime=rssetrest("end_worktime")'规定的下班作息时间'
                                       rssetrest.close
                                      rssetrest.Open "select * from work_attendance where job_number='"&rs("job_number")&"' and work_date like "&datemonth&" ",conn,1,1
                                      if rssetrest.eof then 
                                          response.write "无"
                                      else 
                                        mcount = rssetrest.recordcount
                                        closeglod = 0 '迟到、早退 扣除的金额'
                                        lateNumber = 0
                                        workhours = 0
                                        for index=1 to mcount
                                          starttime = rssetrest("start_time")'上班时间'
                                          endtime = rssetrest("end_time")'下班时间'                             
                                            if starttime > CInt(start_worktime) then 
                                                  'response.write "_上班时间"&starttime&"/迟到时间"
                                                  workstart = starttime
                                                startint = cint(starttime)-Cint(start_worktime)'上班迟到时间'
                                                'response.write startint&"/扣除工资"
                                                  if startint <= 10 then 
                                                    lateNumber = lateNumber + 1
                                                    if lateNumber > 3 then  '迟到前三次免责'
                                                     closeglod = closeglod + 10
                                                    end if 
                                                  elseif startint > 10 and startint <= 30 then 
                                                  closeglod = closeglod + 20
                                                  elseif startint > 30 and startint <= 60 then 
                                                  closeglod = closeglod + 50 
                                                  else 
                                                    closeglod = closeglod + 100 '旷工处理'
                                                    forget_attendance = forget_attendance + 1
                                                    workhours = workhours + startint\60
                                                    workhours1 = startint mod 60
                                                  end if 
                                                 
                                            end if  
                                            
                                             if endtime < CInt(end_worktime) then 
                                            
                                                  workend = endtime
                                                  endint = Cint(end_worktime) - cint(endtime)'下班早退时间'
                                                  if endint > 0 and endint <= 10 then 
                                                  closeglod = closeglod + 10
                                                  elseif endint > 10 and endint <= 30 then 
                                                  closeglod = closeglod + 20
                                                  elseif endint > 30 and endint <= 60 then 
                                                  closeglod = closeglod + 50 
                                                  else 
                                                    closeglod = closeglod + 100 '旷工处理'
                                                    forget_attendance = forget_attendance + 1
                                                    workhours = workhours + endint\60
                                                    workhours2 = endint mod 60
                                                  end if 
                                              end if
                                            rssetrest.movenext
                                        next 
                                        response.write closeglod
                                         'response.write closeglod&"/元迟到早退次数"&forget_attendance&"/迟到早退小时数"&workhours&"/迟到分钟数"&workhours1&"/早退分钟数"&workhours2&"/迟到时间"&workstart&"/早退时间"&workend
                                      end if 
                                   else
                                      response.write "没有该月作息时间"
                                   end if 
                                   rssetrest.close
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                <%  
                                   set missWork=server.CreateObject("adodb.recordset")
                                    missw = "'"+"考勤申诉"+"'"
                                   missWork.Open "select * from work_application_message where mwork_number='"&rs("job_number")&"' and mwork_type like "&missw&" ",conn,1,1
                                    forgetWork = 0
                                    if not missWork.eof then
                                     
                                      for miss=0 to  missWork.recordcount-1 

                                        forgetWork = forgetWork + 10
                                      next
                                     response.write forgetWork&"元/"&missWork.recordcount&"次"
                                    else
                                      response.write "无"
                                    end if 
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">
                                 <%  
                                      '本月应该打卡的天数'
                                          workNumber = 0
                                          workdate = 0
                                        '该月的第一天 dateNumber.val2 该月的天数 dateNumber.val1  

                                        myDatenumber = dateNumber(intdatemonth).val1
                                        '拿到本月的假期天数'
                                        set vacationDate=server.CreateObject("adodb.recordset")
                                        vacationDate.Open "select * from vacation_manage where vacation_date like "&datemonth&" ",conn,1,1
                                        workDateNumber = myDatenumber - vacationDate.recordcount
                                        workdate = workDateNumber
                                       vacationDate.close
                                       '拿出请假申请天数'
                                       mstr = "'"+"请假申请"+"'"
                                       vacationDate.Open "select * from work_application_message where mwork_number='"&rs("job_number")&"' and mwork_type="&mstr&" and  mwork_tody like "&datemonth&" ",conn,1,1
                                        
                                        hoursNumber = 0
                                        
                                        if not vacationDate.eof then
                                          for rse=1 to vacationDate.recordcount
                                            'start_date=vacationDate("mwork_start_date")'拿出请假开始日期用于for运算'
                                           'els = els + DateDiff("d",start_date,vacationDate("mwork_end_date"))'计算请假区间，拿出天数'
                                            hoursNumber = hoursNumber + vacationDate("mwork_input_hour")
                                           
                                            vacationDate.movenext
                                          next
                                        else 

                                        end if 
                                        els = round(hoursNumber/8,0)
                                        
                                       workDateNumber = workDateNumber - els
                                       workNumber = workDateNumber
                                       vacationDate.close
                                       '拿到本月打卡的天数'
                                       vacationDate.Open "select * from work_attendance where job_number='"&rs("job_number")&"' and  work_date like "&datemonth&" ",conn,1,1
                                       workDateNumber = workDateNumber - vacationDate.recordcount 
                                       forget_attendance = forget_attendance +workDateNumber
                                       response.write workDateNumber&"天/"&workDateNumber*100&"元"
                                       '旷工总次数*100+旷工总小时数*（底薪/21.75/8）= 该月的旷工应扣除的金额
                                       Zkuanggong =  workDateNumber*100 + workDateNumber*(basepay/21.75) 
                                       set vacationDate = nothing
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center">其他</td>
                              <td style="vertical-align: middle;text-align:center">
                                <%
                                 set rstody=server.CreateObject("adodb.recordset")
                                   rstody.Open "select * from work_attendance where job_number='"&rs("job_number")&"' and work_date like "&datemonth&" ",conn,1,1
                                  response.write rstody.recordcount 
                                    rstody.close
                                %>
                              </td>
                              <td style="vertical-align: middle;text-align:center"><%

                              '应发工资'

                              'response.write basePay&"+"& Salaryperformence &"+"& addedPerformence &"+"& addedcommission &"+"& trueperformence &"-"& Insurance &"-"& insuranceGold &"-"& intDifference &"-"& closeglod &"-"& forgetWork &"-"& (workDateNumber*100) &"-"& workDateNumber*round(basepay/workdate,2)
                              response.write "pay="&basePay + Salaryperformence + addedPerformence + addedcommission + trueperformence - Insurance - insuranceGold - intDifference - closeglod - forgetWork - (workDateNumber*100) - workDateNumber*round(basepay/workdate,2)
                              %></td>
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
                          <%
                        end if 
                    %>
                      <div style="margin-bottom: 20px;">
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