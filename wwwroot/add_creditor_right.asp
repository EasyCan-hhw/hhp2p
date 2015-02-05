<!--#include file="head.asp" -->
<%

%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 添加债权</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>添加借款人资料</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人身份证:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport"/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款人职业:</label>
                            <div class="controls">
                                <input type="text" id="job" class="span5" name="job"/>
                                <span id="job_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物类别:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="collateral_class" name="collateral_class">
                                		<option value="" ></option>
                                <%
								set rs=server.createobject("adodb.recordset")
								rs.Open "select * from collateral_class order by id",conn,1,1
								do while not rs.eof
								%>
                                    	<option value="<%=rs("id")&"|"&rs("collateral_class_name")%>" ><%=rs("collateral_class_name")%></option>
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
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物:</label>
                            <div class="controls">
                                <input type="text" id="collateral" class="span5" name="collateral"/>
                                <span id="collateral_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;抵押物价值:</label>
                            <div class="controls">
                                <input type="text" id="collateral_value" class="span5" name="collateral_value" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)"/>
                                <span class="help-inline">元</span>
                                <span id="collateral_value_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;借款金额:</label>
                            <div class="controls">
                                <input type="text" id="creditor_right_value" class="span5" name="creditor_right_value" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)"/>
                                <span class="help-inline">元</span>
                                <span id="creditor_right_value_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;还款日期:</label>
                            <div class="controls">
                                <input type="text" id="repayment_date" name="repayment_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="repayment_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;月金额数:</label>
                            <div class="controls">
                                <input type="text" id="advance_pay_creditorRight" class="span5" name="advance_pay_creditorRight" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="width:275px;"/>
                                <span class="help-inline">元</span>&nbsp;&nbsp;
                                <input type="text" id="month_pay_creditorRight" class="span5" name="month_pay_creditorRight" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="width:275px;"/>
                                <span class="help-inline">月</span>
                                <span id="advance_pay_creditorRight_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;身份证:</label>
                            <div class="controls">
                            <input name="passport_img" id="passport_img" type="hidden" value="" />
                             <input name="upload-passport_img" id="upload-passport_img" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传身份证照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="passport_img_err" class="err_text"></span>
                            <div id="passport_img_show"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;房产证:</label>
                            <div class="controls">
                            <input name="property_card" id="property_card" type="hidden" value="" />
                             <input name="upload-property_card" id="upload-property_card" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传房产证照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="property_card_err" class="err_text"></span>
                            <div id="property_card_show"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;公证书:</label>
                            <div class="controls">
                            <input name="notarization" id="notarization" type="hidden" value="" />
                             <input name="upload-notarization" id="upload-notarization" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传公证书照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="notarization_err" class="err_text"></span>
                            <div id="notarization_show"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;借据、收据:</label>
                            <div class="controls">
                            <input name="IOU_receipt" id="IOU_receipt" type="hidden" value="" />
                             <input name="upload-IOU_receipt" id="upload-IOU_receipt" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传借据、收据照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="IOU_receipt_err" class="err_text"></span>
                            <div id="IOU_receipt_show"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;借款合同:</label>
                            <div class="controls">
                            <input name="contract" id="contract" type="hidden" value="" />
                             <input name="upload-contract" id="upload-contract" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传借款合同照片，支持文件格式：JPG、GIF、PNG</span>
                             <span id="contract_err" class="err_text"></span>
                             <div id="contract_show"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;他证:</label>
                            <div class="controls">
                            <input name="other_evidence" id="other_evidence" type="hidden" value="" />
                             <input name="upload-other_evidence" id="upload-other_evidence" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传他证照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="other_evidence_err" class="err_text"></span>
                            <div id="other_evidence_show"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;其他证件:</label>
                            <div class="controls">
                            <input name="other_other" id="other_other" type="hidden" value="" />
                             <input name="upload-other_other" id="upload-other_other" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传他证照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="other_other_err" class="err_text"></span>
                            <div id="other_other_show"></div>
                            </div>
                        </div>
                    <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_creditor_right_submit" type="submit" class="btn btn-primary">提交</button>
                      </div>
                  </form>
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
<script type="text/javascript" src="inputUpload/init_img.js"></script>

<!--#include file="foot.asp" -->