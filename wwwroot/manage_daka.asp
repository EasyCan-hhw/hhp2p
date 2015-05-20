<!--#include file="head.asp" -->
<!--#include file="company_function.asp"-->
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 员工打卡录入</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
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
                            <%
                                        mon = 0
                                      if month(now())>=10 then 
                                        mon = month(now())
                                      else 
                                        mon = "0"&month(now())
                                      end if 
                                      nowtime = Year(now())&"-"&mon
                             
                              set rs=server.CreateObject("adodb.recordset")
                             rs.Open "select * from setrest_worktime where setrest_year='"&nowtime&"' order by sid desc",conn,1,1
                             if not rs.eof then 
                             Sh = int(rs("start_worktime")/60) 
                             Sm = rs("start_worktime") mod 60
                             Eh = rs("end_worktime")/60 
                             Em = rs("end_worktime") mod 60
                            %>
                            <div class="controls">
                                上午:&nbsp;&nbsp;<input type="text" id="start_time1" name="start_time1" value="<%=Sh%>" class="span5" style="width:50px;text-align:right"/>&nbsp;时&nbsp;<input type="text" id="start_time2" name="start_time2" class="span5" value="<%=Sm%>" style="width:50px;text-align:right"/>&nbsp;分&nbsp;&nbsp;下午:&nbsp;&nbsp;
                                <input type="text" id="end_time1" name="end_time1" class="span5" value="<%=Eh%>" style="width:50px;text-align:right"/>&nbsp;时&nbsp;<input type="text" id="end_time2" name="end_tem2" class="span5" value="<%=Em%>" style="width:50px;text-align:right"/>&nbsp;分&nbsp;
                                <span class="help-inline">格式：16:00分(24小时制)</span>
                                <span id="star_time_err" class="err_text"></span>
                                <span id="end_time_err" class="err_text"></span>
                            </div>
                            <%
                            else 
                            %>
                               <div class="controls">
                                上午:&nbsp;&nbsp;<input type="text" id="start_time1" name="start_time1" value="9" class="span5" style="width:50px;text-align:right"/>&nbsp;时&nbsp;<input type="text" id="start_time2" name="start_time2" class="span5" value="30" style="width:50px;text-align:right"/>&nbsp;分&nbsp;&nbsp;下午:&nbsp;&nbsp;
                                <input type="text" id="end_time1" name="end_time1" class="span5" value="18" style="width:50px;text-align:right"/>&nbsp;时&nbsp;<input type="text" id="end_time2" name="end_tem2" class="span5" value="30" style="width:50px;text-align:right"/>&nbsp;分&nbsp;
                                <span class="help-inline">格式：16:59分(24小时制)</span>
                                <span id="star_time_err" class="err_text"></span>
                                <span id="end_time_err" class="err_text"></span>
                            </div>
                            <%
                            end if 
                            rs.close
                            set rs = nothing
                            %>
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
      jobNumber = request.cookies("hhp2p_cookies")("job_number")
      'requestCompanyjudge(jobNumber) 获取分公司代码
      'response.write "select * from work_attendance inner join users on work_attendance.job_number = users.job_number and (users.company_code='"&requestCompanyjudge(jobNumber)&"' or users.company_id = "&requestCompanyjudge(jobNumber)&") order by work_id desc"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from work_attendance inner join users on work_attendance.job_number = users.job_number and (users.company_code='"&requestCompanyjudge(jobNumber)&"' or users.company_id = "&requestCompanyjudge(jobNumber)&") order by work_id desc",conn,1,1

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
	                                  <input name="username<%=int(rs("work_id"))%>" id="username<%=int(rs("work_id"))%>" class="half" type="text" value="<%=trim(rs("full_name"))%>" style="text-align:center;width:60px"/> 
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