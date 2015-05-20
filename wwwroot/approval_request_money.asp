
<!--#include file="head.asp" -->
<%


%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 财务请款审批</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">

<%
if id<>"" then
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from request_photo where aid="&id,conn,1,1
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
                  <input type="hidden" id="id" value="<%=rs("aid")%>">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name" value="<%=rs("request_name")%>" disabled/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;备注:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport" value="<%=rs("request_text")%>" disabled/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;申请时间:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport" value="<%=rs("request_date")%>" disabled/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                         
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;请款证件:</label>
                            <div class="controls">
                            <%
                           set rs1=server.CreateObject("adodb.recordset")
                            rs1.Open "select * from request_photo where aid="&rs("aid"),conn,1,1
                            
                            do while not rs1.eof
                                request_photo=request_photo&"<a href='Upload_file/"&rs1("request_photo")&"' target='_blank'><img src='Upload_file/"&rs1("request_photo")&"' width='160'></a>&nbsp;&nbsp;"
                                if approval_photo_file <> "" then 
                                	approval_photo_file=approval_photo_file&","
                                	approval_photo_file=approval_photo_file&rs1("request_photo")
                                end if
                            	rs1.movenext
                            loop
                            rs1.close
                            set rs1=nothing
                            %>
                            <div id="approval_photo_show" style="display:inline;">
                            <%=request_photo%>
                            </div>
                            </div>
                        </div>
                        
                    <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="request_money_approval" type="submit" class="btn btn-primary">审批</button>&nbsp;&nbsp;&nbsp;&nbsp;
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
                    <div class="widget-title"> <span class="icon"> <i class="icon-list"></i> </span>
                        <h5>财务请款列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                            	<th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th>
                                <th nowrap="nowrap">姓名</th>
                                <th>备注</th>
                                <th>申请时间</th> 
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                          <%
                       
				err_txt="<tr><td colspan=""8"">没有待审批的请款</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from request_photo where approval_request=0 order by aid",conn,1,1
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
            			showpage1=showpage(totalput,MaxPerPage,"aproval_request_money.asp","")
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"aproval_request_money.asp","")
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"aproval_request_money.asp","")
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                         <tr>
                                 <td><input type="checkbox" name="subBox" value="<%=rs("aid")%>"/></td>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("request_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("request_text"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("request_date"))%></td>
                               <td style="vertical-align: middle; text-align:center">
                                   <a href="javascript:;" id="request_money_approval_<%=int(rs("aid"))%>" class="request_money_approval">审批</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="approval_request_money.asp?id=<%=int(rs("aid"))%>">查看详情</a>
                                    
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