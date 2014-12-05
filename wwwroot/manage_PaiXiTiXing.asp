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
    <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 派息查询</a></div>
  </div>
  <!--End-breadcrumbs-->
  
  <div class="container-fluid">
    <%
   if id<>"" then
     set rs=server.CreateObject("adodb.recordset")
     rs.Open "select * from contracts where id="&id,conn,1,1
   if not rs.eof then
    %>
    <%
    end if
     rs.close
     set rs=nothing
    else
    %>
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-list"></i> </span>
            <h5>派息查询账单列表</h5>
          </div>
          <div class="widget-content">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr> 
                  <!--<th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th> -->
                  <th nowrap="nowrap">合同编号</th>
                  <th>客户姓名</th>
                  <th>客户身份证</th>
                  <th>理财产品</th>
                  <th>初始理财金额</th>
                  <th>初始理财日期</th>
                  <th>账单周期</th>
                  <th>账单期数</th>
                  <th>本期末资产总值</th>
                  <th>本期派息额</th>
                  <th>出账日期</th>
                  <th>派息提醒</th>
                  <th width="15%">操作</th>
                </tr>
              </thead>
              <tbody>
                
                <!--if trim(request("number"))<>"" then numbers=" and number='"&trim(request("number"))&"'"
					if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
					if trim(request("passport"))<>"" then passport=" and passport='"&trim(request("passport"))&"'"
					if trim(request("start_date"))<>"" then date1=" and datediff(d,'"&trim(request("start_date"))&"',start_date)>=0"
					if trim(request("start_date2"))<>"" then date2=" and datediff(d,start_date,'"&trim(request("start_date2"))&"')>=0"
					if trim(request("product_name"))<>"" then product_name=" and product_name='"&trim(request("product_name"))&"'"
					if trim(request("inputdate"))<>"" then inputdate1=" and datediff(d,'"&trim(request("inputdate"))&"',inputdate)>=0"
					if trim(request("inputdate2"))<>"" then inputdate2=" and datediff(d,inputdate,'"&trim(request("inputdate2"))&"')>=0"
              -->
                <%
          			err_txt="<tr><td colspan=""12"">没有债权转让账单信息</td></tr>"
          			set rs=server.CreateObject("adodb.recordset")
          			rs.Open "select * from monthly_bill where id>0 order by id desc",conn,1,1

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
                      			showpage1=showpage(totalput,MaxPerPage,"manage_monthly_bill.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&inputdate="&trim(request("inputdate"))&"&inputdate2="&trim(request("inputdate2")))
                 				else
                      				if (currentPage-1)*MaxPerPage<totalPut then
                        				rs.move  (currentPage-1)*MaxPerPage
                        				dim bookmark
                        				bookmark=rs.bookmark
                        				showContent
                         				showpage1=showpage(totalput,MaxPerPage,"manage_monthly_bill.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&inputdate="&trim(request("inputdate"))&"&inputdate2="&trim(request("inputdate2")))
                    				else
            	        				currentPage=1
                       					showContent
                       					showpage1=showpage(totalput,MaxPerPage,"manage_monthly_bill.asp","&number="&trim(request("number"))&"&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&start_date="&trim(request("start_date"))&"&start_date2="&trim(request("start_date2"))&"&product_name="&trim(request("product_name"))&"&inputdate="&trim(request("inputdate"))&"&inputdate2="&trim(request("inputdate2")))
            						    end if
          	   				  end if
          			end if
             			sub showContent
          	   		i=0
          			do while not rs.eof
                  nowdate=Year(now())&"-"&month(now())&"-"&day(now())
                  tomdate=Year(now())&"-"&month(now())&"-"&day(now())+1
                  if cdate(rs("periods_end_date"))=cdate(nowdate) then
                  i=i+1
          			%>
                <tr> 
                  <!-- <td><input type="checkbox" name="subBox" value="</=rs("id")/>"/></td> -->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("number"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("full_name"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("product_name"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("capital"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("start_date"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("periods_start_date"))&"至"&trim(rs("periods_end_date"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("periods"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("grand_total"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("accrual"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=ForMatDate(trim(rs("inputdate")),2)%></td>
                  <td style="vertical-align: middle;text-align:center">今天派息</td>
                  <td style="vertical-align: middle; text-align:center"><a href="monthly_bill.asp?id=<%=int(rs("id"))%>" target="_blank">打印账单</a></td>
                </tr>
                <tr></tr>
                <%
                elseif cdate(rs("periods_end_date"))=cdate(tomdate) then
                %>

                <tr> 
                  <!-- <td><input type="checkbox" name="subBox" value="</=rs("id")/>"/></td> -->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("number"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("full_name"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("product_name"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("capital"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("start_date"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("periods_start_date"))&"至"&trim(rs("periods_end_date"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("periods"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("grand_total"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=trim(rs("accrual"))%></td>
                  <td style="vertical-align: middle;text-align:center"><%=ForMatDate(trim(rs("inputdate")),2)%></td>
                  <td style="vertical-align: middle;text-align:center">明天派息</td>
                  <td style="vertical-align: middle; text-align:center"><a href="monthly_bill.asp?id=<%=int(rs("id"))%>" target="_blank">打印账单</a></td>
                </tr>

                <%
                else
                end if
			
			if i>=MaxPerPage then Exit Do
			rs.movenext
			loop
			rs.close
			set rs=nothing
			End Sub   
            %>
              </tbody>
            </table>
            <div style="margin-bottom: 20px;"> <span class="icon" style="cursor: pointer;" id="print_monthly_bill"> <i class="icon-print"></i> 批量打印</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
            <%=showpage1%> </div>
        </div>
      </div>
      <%
            set hr=server.CreateObject("adodb.recordset")
			hr.Open "select * from monthly_bill where id=1 order by id desc",conn,1,1
            %>
    </div>
    <%end if%>
    
    <!-- tips -->
    <div class="row-fluid">
      <div class="span12">
        <div class="alert alert-info alert-block"> </div>
      </div>
    </div>
  </div>
</div>
<!--end-main-container-part--> 

<!--#include file="foot.asp" -->