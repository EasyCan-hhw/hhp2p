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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 债权查询</a></div>
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
                  <h5><%if rs("approval")=1 then%>查看详情<%else%>修改债权<%end if%></h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  <input type="hidden" id="id" value="<%=rs("id")%>">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name" value="<%=rs("full_name")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人身份证:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport" value="<%=rs("passport")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人职业:</label>
                            <div class="controls">
                                <input type="text" id="job" class="span5" name="job" value="<%=rs("job")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span id="job_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物类别:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="collateral_class" name="collateral_class" <%if rs("approval")=1 then%>disabled<%end if%>>
                                		<option value="" ></option>
                                <%
								set rs1=server.createobject("adodb.recordset")
								rs1.Open "select * from collateral_class order by id",conn,1,1
								do while not rs1.eof
								%>
                                    	<option value="<%=rs1("id")&"|"&rs1("collateral_class_name")%>" <%if rs("collateral_class_id")=rs1("id") then%>selected<%end if%>><%=rs1("collateral_class_name")%></option>
                                <%
								rs1.movenext
								loop
								rs1.close
								set rs1=nothing
								%>
                                </select>
                                </div>
                                <span id="collateral_class_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物:</label>
                            <div class="controls">
                                <input type="text" id="collateral" class="span5" name="collateral" value="<%=rs("collateral")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span id="collateral_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物价值:</label>
                            <div class="controls">
                                <input type="text" id="collateral_value" class="span5" name="collateral_value" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" value="<%=rs("collateral_value")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span class="help-inline">元</span>
                                <span id="collateral_value_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款金额:</label>
                            <div class="controls">
                                <input type="text" id="creditor_right_value" class="span5" name="creditor_right_value" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" value="<%=rs("creditor_right_value")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span class="help-inline">元</span>
                                <span id="creditor_right_value_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;还款日期:</label>
                            <div class="controls">
                                <input type="text" id="repayment_date" name="repayment_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" value="<%=rs("repayment_date")%>" <%if rs("approval")=1 then%>disabled<%end if%>/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="repayment_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;身份证:</label>
                            <div class="controls">
                            <%
							set rs1=server.CreateObject("adodb.recordset")
							rs1.Open "select * from upload_files where table_name='creditor_right' and file_type='passport_img' and cid="&rs("id"),conn,1,1
							do while not rs1.eof
								passport_img=passport_img&"<a href='Upload_file/"&rs1("filename")&"' target='_blank'><img src='Upload_file/"&rs1("filename")&"' width='160'></a>&nbsp;&nbsp;"
								if passport_img_file<>"" then passport_img_file=passport_img_file&","
								passport_img_file=passport_img_file&rs1("filename")
							rs1.movenext
							loop
							rs1.close
							set rs1=nothing
							if rs("approval")=0 then%>
                            <input name="passport_img" id="passport_img" type="hidden" value="<%=passport_img_file%>" />
                             <input name="upload-passport_img" id="upload-passport_img" type="button" value="重新上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传身份证照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="passport_img_err" class="err_text"></span>
                             <%end if%>
                            <div id="passport_img_show" style="display:inline;">
                            <%=passport_img%>
                            </div>
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
							if rs("approval")=0 then%>
                            <input name="property_card" id="property_card" type="hidden" value="<%=property_card_file%>" />
                             <input name="upload-property_card" id="upload-property_card" type="button" value="重新上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传房产证照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="property_card_err" class="err_text"></span>
                             <%end if%>
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
							if rs("approval")=0 then%>
                            <input name="notarization" id="notarization" type="hidden" value="<%=notarization_file%>" />
                             <input name="upload-notarization" id="upload-notarization" type="button" value="重新上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传公证书照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="notarization_err" class="err_text"></span>
                             <%end if%>
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
							if rs("approval")=0 then%>
                            <input name="IOU_receipt" id="IOU_receipt" type="hidden" value="<%=IOU_receipt_file%>" />
                             <input name="upload-IOU_receipt" id="upload-IOU_receipt" type="button" value="重新上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传借据、收据照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="IOU_receipt_err" class="err_text"></span>
                             <%end if%>
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
							if rs("approval")=0 then%>
                            <input name="contract" id="contract" type="hidden" value="<%=contract_file%>" />
                             <input name="upload-contract" id="upload-contract" type="button" value="重新上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传借款合同照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="contract_err" class="err_text"></span>
                             <%end if%>
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
							if rs("approval")=0 then%>
                            <input name="other_evidence" id="other_evidence" type="hidden" value="<%=other_evidence_file%>" />
                             <input name="upload-other_evidence" id="upload-other_evidence" type="button" value="重新上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传他证照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="other_evidence_err" class="err_text"></span>
                             <%end if%>
                            <div id="other_evidence_show" style="display:inline;">
                            <%=other_evidence_img%>
                            </div>
                            </div>
                        </div>
                    <div class="form-actions">
                          <label class="control-label"></label>
                        <%if rs("approval")=0 then%>
                          <button id="edit_creditor_right_submit" type="submit" class="btn btn-primary">提交</button>
                        <%else%>
                          <button id="history_back" type="submit" class="btn btn-primary">返回</button>
                      <%end if%>
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
                  <h5>债权查询</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label">&nbsp;借款人姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;借款人身份证号:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport"/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;还款日期:</label>
                            <div class="controls">
                                <input type="text" id="repayment_date" name="repayment_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" style="width:275px;"/>&nbsp;&nbsp;至&nbsp;&nbsp;
                                <input type="text" id="repayment_date2" name="repayment_date2" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5" style="width:275px;"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="repayment_date_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label">&nbsp;抵押物类别:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="collateral_class" name="collateral_class">
                                		<option value="" ></option>
                                <%
								set rs=server.createobject("adodb.recordset")
								rs.Open "select * from collateral_class order by id",conn,1,1
								do while not rs.eof
								%>
                                    	<option value="<%=rs("collateral_class_name")%>" ><%=rs("collateral_class_name")%></option>
                                <%
								rs.movenext
								loop
								rs.close
								set rs=nothing
								%>
                                </select>
                                </div>
                                <span id="collateral_class_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;状态:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="status" name="status">
                                    	<option value="" ></option>
                                    	<option value="0" >待审批</option>
                                        <option value="1" >已审批</option>
                                </select>
                                </div>
                                <span id="custome_source_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="search_creditor_right_submit" type="submit" class="btn btn-primary">组合查询</button>
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
                        <h5>债权列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap">借款人姓名</th>
                                <th>借款人身份证</th>
                                <th>抵押物类别</th>
                                <th>抵押物</th>
                                <th>抵押物价值</th>
                               <th>借款金额</th>
                               <th>还款日期</th>
                               <th>可分配债权</th>
                               <th>状态</th>
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
if trim(request("collateral_class"))<>"" then collateral_class_name=" and collateral_class_name='"&trim(request("collateral_class"))&"'"

				err_txt="<tr><td colspan=""8"">没有债权</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from creditor_right where id>0"&full_name&passportdate1&date2&status&collateral_class_name&" order by datediff(d,'"&now()&"',repayment_date),approval desc",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"manage_creditor_right.asp","&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status"))&"&collateral_class_name="&trim(request("collateral_class_name")))
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_creditor_right.asp","&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status"))&"&collateral_class_name="&trim(request("collateral_class_name")))
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_creditor_right.asp","&full_name="&trim(request("full_name"))&"&passport="&trim(request("passport"))&"&repayment_date="&trim(request("repayment_date"))&"&repayment_date2="&trim(request("repayment_date2"))&"&status="&trim(request("status"))&"&collateral_class_name="&trim(request("collateral_class_name")))
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td style="vertical-align: middle;text-align:center" nowrap="nowrap"><%=trim(rs("full_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("passport"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("collateral_class_name"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("collateral"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("collateral_value"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("creditor_right_value"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("repayment_date"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%=trim(rs("remaining_amount"))%></td>
                                <td style="vertical-align: middle;text-align:center"><%
								if rs("approval")=0 then
									response.write "待审批"
								elseif rs("approval")=1 then
									response.write "<font color='#FF0000'>已审批</font>"
								end if
								%></td>
                               <td style="vertical-align: middle; text-align:center">
                               		<%if rs("approval")=0 then%>
                                    <a href="manage_creditor_right.asp?id=<%=int(rs("id"))%>">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="creditor_right_del_<%=int(rs("id"))%>" class="creditor_right_del">删除</a>
									<%else%>
                                     <a href="manage_creditor_right.asp?id=<%=int(rs("id"))%>">查看详情</a>
									<%end if%>
                                    
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