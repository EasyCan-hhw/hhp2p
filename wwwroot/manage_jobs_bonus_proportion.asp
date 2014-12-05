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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 职位业绩提成设置</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        
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
                                <th nowrap="nowrap">职位名称</th>
                                <th>年化提成比例</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%

				err_txt="<tr><td colspan=""3"">没有职位</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from jobs order by id",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"manage_jobs_bonus_proportion.asp","")
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_jobs_bonus_proportion.asp","")
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_jobs_bonus_proportion.asp","")
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td nowrap="nowrap" style="vertical-align: middle;text-align:center"><%=trim(rs("job_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><input name="bonus_proportion<%=int(rs("id"))%>" id="bonus_proportion<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("bonus_proportion"))*100%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="width:20px;">%</td>
                                <td style="vertical-align: middle; text-align:center">
                                    <a href="javascript:;" id="jobs_bonus_proportion_<%=int(rs("id"))%>" class="jobs_bonus_proportion">修改</a>
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