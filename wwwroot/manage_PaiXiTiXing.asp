<!--#include file="head.asp" -->
<!--#include file="company_function.asp"-->
<!--#include file="sidebar_menu.asp" --> 
<!--#include file="tool_function.asp"-->
<!--main-container-part-->

<div id="content"> 
  <!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 派息查询</a></div>
  </div>
  <!--End-breadcrumbs-->
  
  <div class="container-fluid">
    <%
   
    %>
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-list"></i> </span>
            <h5>派息查询账单列表</h5>
            <%
            'tomou=Year(now())&"-"&month(now())&"-"&day(now())+1
           '' tomou2=Year(now())&"/"&month(now())&"/"&day(now())
            'tomou3=DateAdd("d",1,tomou2)
            'response.write tomou&"===="&tomou3
            'if cdate(tomou) = cdate(tomou3) then 
            ''  response.write "通过"
            'else 
            ''  response.write "未通过"
            'end if
            %>
          </div>
          <div class="widget-content">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr> 
                  <!--<th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th> -->
                  <th nowrap="nowrap">合同编号</th>
                  <th>业务员</th>
                  <th>客户姓名</th>
                  <th>客户身份证</th>
                  <th>银行账号</th>
                  <th>理财产品</th>
                 <th>初始理财金额</th>
                 <th>初始理财日期</th>
                 <th>账单期数</th>
                  <th>账单周期</th>
                 <th>本期派息额</th>
                 <th>出账日期</th>
                  <th width="10%">操作</th>
                </tr>
              </thead>
              <tbody>
             
                <%
                
                 valuemy = contractsTools(requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number")))

                 valueCount = Ubound(valuemy)-1
                 'response.write valuemy(1)(2)
        			   err_txt="<tr><td colspan=""12"">无信息</td></tr>"
              
        			
              
        		   	if err.number<>0 or valueCount <=0 then
        				  response.write err_txt
          			end if

          			if not valueCount <=0 then 
          	  				totalPut=valueCount

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
                      			showpage1=showpage(totalput,MaxPerPage,"manage_PaiXiTiXing.asp","")
                 				else
                      				if (currentPage-1)*MaxPerPage<totalPut then
                        				'rs.move  (currentPage-1)*MaxPerPage
                        				'dim bookmark
                        				'bookmark=rs.bookmark
                        				showContent
                         				showpage1=showpage(totalput,MaxPerPage,"manage_PaiXiTiXing.asp","")
                    				else
          	        				    currentPage=1
                       					showContent
                       					showpage1=showpage(totalput,MaxPerPage,"manage_PaiXiTiXing.asp","")
            						    end if
          	   				  end if
          			end if
             		sub showContent

          	   	i=0
                 
                intlenght = 0
                'response.write valuemy(1)(2)&"=="

          			do while not valueCount<=0
                  '
                  'modnumber = datediff("d",responseEndDate(rs("start_date"),rs("cycle")).EndDate,now())
                 
          			%>
                <tr> 
                  <!--<td><input type="checkbox" name="subBox" value="</=rs("id")/>"/></td> -->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(0) %></td><!--合同编号 -->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(1) %></td><!-- '业务员'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(2) %></td><!-- '客户姓名'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(3) %></td><!-- '身份证'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(4) %></td><!-- '银行信息'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(5) %></td><!-- '理财产品'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(6) %></td><!-- '初始理财金额'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(7) %></td><!-- '初始理财日期'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(8) %></td><!-- '账单期数'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(9) %></td><!-- '账单周期'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(10) %></td><!-- '本期派息额度'-->
                  <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><% response.write valuemy(intlenght)(11) %></td><!-- '出账日期'-->
                  <td style="vertical-align: middle; text-align:center"><a href="" target="_blank">打印账单</a></td><!--操作monthly_bill.asp?id= =int(rs("id")) -->
                </tr>
              
                <%
             
      			 i=i+1
      			if i>=MaxPerPage then Exit Do
      			valueCount = valueCount-1
            intlenght = intlenght + 1
      			loop
      			'rs.close
      			'set rs=nothing
    			   End Sub   
            %>
              </tbody>
            </table>
            <div style="margin-bottom: 20px;"> <span class="icon" style="cursor: pointer;" id="print_monthly_bill"> <i class="icon-print"></i> 批量打印</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
            <%=showpage1%> </div>
        </div>
      </div>
      <%
            'set hr=server.CreateObject("adodb.recordset")
			'hr.Open "select * from monthly_bill where id=1 order by id desc",conn,1,1
            %>
    </div>
    
    
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