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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 新增债权审批</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">

<%
if id<>"" then
set rs=server.CreateObject("adodb.recordset")
rs.Open "select * from creditor_right where id="&id,conn,1,1
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
                  <input type="hidden" id="id" value="<%=rs("id")%>">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name" value="<%=rs("full_name")%>" disabled/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人身份证:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport" value="<%=rs("passport")%>" disabled/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人职业:</label>
                            <div class="controls">
                                <input type="text" id="job" class="span5" name="job" value="<%=rs("job")%>" disabled/>
                                <span id="job_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物:</label>
                            <div class="controls">
                                <input type="text" id="collateral" class="span5" name="collateral" value="<%=rs("collateral")%>" disabled/>
                                <span id="collateral_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物价值:</label>
                            <div class="controls">
                                <input type="text" id="collateral_value" class="span5" name="collateral_value" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" value="<%=rs("collateral_value")%>" disabled/>
                                <span class="help-inline">元</span>
                                <span id="collateral_value_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款金额:</label>
                            <div class="controls">
                                <input type="text" id="creditor_right_value" class="span5" name="creditor_right_value" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" value="<%=rs("creditor_right_value")%>" disabled/>
                                <span class="help-inline">元</span>
                                <span id="creditor_right_value_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;还款日期:</label>
                            <div class="controls">
                                <input type="text" id="repayment_date" name="repayment_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("repayment_date")%>" disabled/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="repayment_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;房产证:</label>
                            <div class="controls">
                            <%
							set rs1=server.CreateObject("adodb.recordset")
							rs1.Open "select * from upload_files where table_name='creditor_right' and file_type='property_card' and cid="&rs("id"),conn,1,1
							do while not rs1.eof
								property_card_img=property_card_img&"<a href='Upload_file/"&rs1("filename")&"' target='_blank'><img src='Upload_file/"&rs1("filename")&"' width='160'></a>&nbsp;&nbsp;"
								if property_card_file<>"" then property_card_file=property_card_file&","
								property_card_file=property_card_file&rs1("filename")
							rs1.movenext
							loop
							rs1.close
							set rs1=nothing
							%>
                            <div id="property_card_show" style="display:inline;">
                            <%=property_card_img%>
                            </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;公证书:</label>
                            <div class="controls">
                            <%
							set rs1=server.CreateObject("adodb.recordset")
							rs1.Open "select * from upload_files where table_name='creditor_right' and file_type='notarization' and cid="&rs("id"),conn,1,1
							do while not rs1.eof
								notarization_img=notarization_img&"<a href='Upload_file/"&rs1("filename")&"' target='_blank'><img src='Upload_file/"&rs1("filename")&"' width='160'></a>&nbsp;&nbsp;"
								if notarization_file<>"" then notarization_file=notarization_file&","
								notarization_file=notarization_file&rs1("filename")
							rs1.movenext
							loop
							rs1.close
							set rs1=nothing
							%>
                            <div id="notarization_show" style="display:inline;">
                            <%=notarization_img%>
                            </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借据、收据:</label>
                            <div class="controls">
                            <%
							set rs1=server.CreateObject("adodb.recordset")
							rs1.Open "select * from upload_files where table_name='creditor_right' and file_type='IOU_receipt' and cid="&rs("id"),conn,1,1
							do while not rs1.eof
								IOU_receipt_img=IOU_receipt_img&"<a href='Upload_file/"&rs1("filename")&"' target='_blank'><img src='Upload_file/"&rs1("filename")&"' width='160'></a>&nbsp;&nbsp;"
								if IOU_receipt_file<>"" then IOU_receipt_file=IOU_receipt_file&","
								IOU_receipt_file=IOU_receipt_file&rs1("filename")
							rs1.movenext
							loop
							rs1.close
							set rs1=nothing
							%>
                            <div id="IOU_receipt_show" style="display:inline;">
                            <%=IOU_receipt_img%>
                            </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款合同:</label>
                            <div class="controls">
                            <%
							set rs1=server.CreateObject("adodb.recordset")
							rs1.Open "select * from upload_files where table_name='creditor_right' and file_type='contract' and cid="&rs("id"),conn,1,1
							do while not rs1.eof
								contract_img=contract_img&"<a href='Upload_file/"&rs1("filename")&"' target='_blank'><img src='Upload_file/"&rs1("filename")&"' width='160'></a>&nbsp;&nbsp;"
								if contract_file<>"" then contract_file=contract_file&","
								contract_file=contract_file&rs1("filename")
							rs1.movenext
							loop
							rs1.close
							set rs1=nothing
							%>
                            <div id="contract_show" style="display:inline;">
                            <%=contract_img%>
                             </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;他证:</label>
                            <div class="controls">
                            <%
							set rs1=server.CreateObject("adodb.recordset")
							rs1.Open "select * from upload_files where table_name='creditor_right' and file_type='other_evidence' and cid="&rs("id"),conn,1,1
							do while not rs1.eof
								other_evidence_img=other_evidence_img&"<a href='Upload_file/"&rs1("filename")&"' target='_blank'><img src='Upload_file/"&rs1("filename")&"' width='160'></a>&nbsp;&nbsp;"
								if other_evidence_file<>"" then other_evidence_file=other_evidence_file&","
								other_evidence_file=other_evidence_file&rs1("filename")
							rs1.movenext
							loop
							rs1.close
							set rs1=nothing
							%>
                            <div id="other_evidence_show" style="display:inline;">
                            <%=other_evidence_img%>
                            </div>
                            </div>
                        </div>
                    <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="approval_creditor_right_submit" type="submit" class="btn btn-primary">审批</button>&nbsp;&nbsp;&nbsp;&nbsp;
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
                        <h5>待审批债权列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                            	<th><input type="checkbox" id="check_all" name="title-table-checkbox"/></th>
                                <th nowrap="nowrap">借款人姓名</th>
                                <th>借款人身份证</th>
                                <th>抵押物</th>
                                <th>抵押物价值</th>
                               <th>借款金额</th>
                               <th>还款日期</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
if trim(request("full_name"))<>"" then full_name=" and full_name='"&trim(request("full_name"))&"'"
if trim(request("passport"))<>"" then passport=" and passport='"&trim(request("passport"))&"'"
if trim(request("repayment_date"))<>"" then date1=" and datediff(d,'"&trim(request("repayment_date"))&"',repayment_date)>=0"
if trim(request("repayment_date2"))<>"" then date2=" and datediff(d,repayment_date,'"&trim(request("repayment_date2"))&"')>=0"
if trim(request("status"))<>"" then status=" and approval="&trim(request("status"))

				err_txt="<tr><td colspan=""8"">没有待审批的债权</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from creditor_right where approval=0"&full_name&passportdate1&date2&status&" order by id",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"approval_creditor_right.asp","&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"approval_creditor_right.asp","&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"approval_creditor_right.asp","&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status")))
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td><input type="checkbox" name="subBox" value="<%=rs("id")%>"/></td>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("full_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("collateral"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("collateral_value"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("creditor_right_value"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("repayment_date"))%></td>
                               <td style="vertical-align: middle; text-align:center">
                               		
                                   <a href="javascript:;" id="creditor_right_approval_<%=int(rs("id"))%>" class="creditor_right_approval">审批</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="approval_creditor_right.asp?id=<%=int(rs("id"))%>">查看详情</a>
                                    
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