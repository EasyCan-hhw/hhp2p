<!--#include file="head.asp" -->
<%

%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 添加客户</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>添加客户资料</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  
                        <div class="control-group">
                            <label class="control-label">&nbsp;从我的目标客户中选择:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="tc_id" name="tc_id">
                                		<option value="" ></option>
                                <%
								set rs=server.createobject("adodb.recordset")
								rs.Open "select * from target_customers where add_uid="&request.cookies("hhp2p_cookies")("uid"),conn,1,1
								do while not rs.eof
								%>
                                    	<option value="<%=rs("full_name")&"|"&rs("mobile")&"|"&rs("custome_source")%>" ><%=rs("full_name")&"("&rs("mobile")&")"%></option>
                                <%
								rs.movenext
								loop
								rs.close
								set rs=nothing
								%>
                                </select>
                                </div>
                                <span id="sex_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;姓名:</label>
                            <div class="controls">
                                <input type="text" id="full_name" class="span5" name="full_name"/>
                                <span id="full_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;性别:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="sex" name="sex">
                                    	<option value="0" >保密</option>
                                        <option value="1" >先生</option>
                                        <option value="2" >女士</option>
                                </select>
                                </div>
                                <span id="sex_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;出生日期:</label>
                            <div class="controls">
                                <input type="text" id="birth_date" name="birth_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="birth_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;身份证（护照号）:</label>
                            <div class="controls">
                                <input type="text" id="passport" class="span5" name="passport"/>
                                <span id="passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;签发日期:</label>
                            <div class="controls">
                                <input type="text" id="lssue_date" name="lssue_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="lssue_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;失效日期:</label>
                            <div class="controls">
                                <input type="text" id="expiry_date" name="expiry_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="expiry_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;婚姻状况:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="marital" name="marital">
                                    	<option value="0" >保密</option>
                                        <option value="1" >未婚</option>
                                        <option value="2" >已婚</option>
                                </select>
                                </div>
                                <span id="marital_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;联系电话:</label>
                            <div class="controls">
                                <input type="text" id="mobile" class="span5" name="mobile"/>
                                <span id="mobile_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;工作城市:</label>
                            <div class="controls">
                                <input type="text" id="city" class="span5" name="city"/>
                                <span id="city_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label">&nbsp;所属行业:</label>
                            <div class="controls">
                                <input type="text" id="industry" class="span5" name="industry"/>
                                <span id="industry_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;邮政编码:</label>
                            <div class="controls">
                                <input type="text" id="postcodes" class="span5" name="postcodes"/>
                                <span id="postcodes_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;电子邮箱:</label>
                            <div class="controls">
                                <input type="text" id="email" class="span5" name="email"/>
                                <span id="email_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;通讯地址:</label>
                            <div class="controls">
                                <input type="text" id="address" class="span5" name="address"/>
                                <span id="address_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;开户行:</label>
                            <div class="controls">
                                <input type="text" id="bank_info" class="span5" name="bank_info"/>
                                <span id="bank_info_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;银行账号:</label>
                            <div class="controls">
                                <input type="text" id="bank_account" class="span5" name="bank_account"/>
                                <span id="bank_account_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;账单寄送方式:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="notify" name="notify">
                                    	<option value="0" >电邮</option>
                                        <option value="1" >平信</option>
                                        <option value="2" >快递</option>
                                </select>
                                </div>
                                <span id="marital_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;备注:</label>
                            <div class="controls">
                                <input type="text" id="remarks" class="span5" name="remarks"/>
                                <span id="remarks_err" class="err_text"></span>
                            </div>
                        </div>
                        
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;紧急联系人姓名:</label>
                            <div class="controls">
                                <input type="text" id="emergency_name" class="span5" name="emergency_name"/>
                                <span id="emergency_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;跟紧急联系人关系:</label>
                            <div class="controls">
                                <input type="text" id="emergency_title" class="span5" name="emergency_title"/>
                                <span id="emergency_title_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人性别:</label>
                            <div class="controls">
                            	<div class="span5">
                                <select id="emergency_sex" name="emergency_sex">
                                    	<option value="0" >保密</option>
                                        <option value="1" >先生</option>
                                        <option value="2" >女士</option>
                                </select>
                                </div>
                                <span id="emergency_sex_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人出生日期:</label>
                            <div class="controls">
                                <input type="text" id="emergency_birth_date" name="emergency_birth_date" onFocus="WdatePicker({el:this})" autocomplete="off" class="span5"/>
                                <span class="help-inline">格式：1970-01-01</span>
                                <span id="emergency_birth_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人身份证:</label>
                            <div class="controls">
                                <input type="text" id="emergency_passport" class="span5" name="emergency_passport"/>
                                <span id="emergency_passport_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label"><font color="red">*</font>&nbsp;紧急联系人移动电话:</label>
                            <div class="controls">
                                <input type="text" id="emergency_mobile" class="span5" name="emergency_mobile"/>
                                <span id="emergency_mobile_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人固定电话:</label>
                            <div class="controls">
                                <input type="text" id="emergency_tel" class="span5" name="emergency_tel"/>
                                <span id="emergency_tel_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人邮箱:</label>
                            <div class="controls">
                                <input type="text" id="emergency_email" class="span5" name="emergency_email"/>
                                <span id="emergency_email_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group alert">
                            <label class="control-label">&nbsp;紧急联系人地址:</label>
                            <div class="controls">
                                <input type="text" id="emergency_address" class="span5" name="emergency_address"/>
                                <span id="emergency_address_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;客户来源:</label>
                            <div class="controls">
                              <table>
                              <tr>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="市场活动"> 市场活动</td>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="老客户推荐"> 老客户推荐</td>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="自有资源"> 自有资源</td>
                                </tr>
                                <tr>
                                <td width="200" height="30"><input name="custome_source" type="radio" id="custome_source" value="渠道"> 渠道</td>
                                <td colspan="2" height="30"><input name="custome_source" type="radio" id="custome_source" value="other"> 其他 <input type="text" id="custome_source_other" class="half" name="custome_source_other"/></td>
                                 </tr>
                                </table>
                                <span id="custome_source_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;渠道名称:</label>
                            <div class="controls">
                                <input type="text" id="channel_name" class="span5" name="channel_name"/>
                                <span id="channel_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;推荐人:</label>
                            <div class="controls">
                                <input type="text" id="recommend" class="span5" name="recommend"/>
                                <span id="recommend_err" class="err_text"></span>
                            </div>
                        </div>
                    <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_custome_submit" type="submit" class="btn btn-primary">提交</button>
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

<!--#include file="foot.asp" -->