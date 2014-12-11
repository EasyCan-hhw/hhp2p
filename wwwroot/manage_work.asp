
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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 考勤申请</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>考勤申请</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  
                        <div class="control-group">
                          <label class="control-label"><font color="red">*</font>&nbsp;员工工号:</label>
                             <div class="controls">
                              <input type="text" id="work_number" class="half" name="work_number" value="<%=request.cookies("hhp2p_cookies")("job_number")%>"/>
                                <span id="work_number_err" class="err_text"></span>
                              </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;员工姓名:</label>
                            <div class="controls">
                                <input type="text" id="work_name" class="half" name="work_name" value="<%=request.cookies("hhp2p_cookies")("full_name")%>"/>
                                <span id="work_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                          <label class="control-label"><font color="red">*</font>申请条目:</label>
                          <div class="controls">
                             <div class="span5" style="width:220px">
                                <select id="work_type" name="work_type">
                                      <option value="" ></option>
                                        <%
                                      set rs=server.CreateObject("adodb.recordset")
                                      rs.Open "select * from work_application order by id" ,conn,1,1
                                      do while not rs.eof
                                      %>
                                      <option  value="<%=rs("work_application")%>" <%if rs("id")=work_application then%>selected<%end if%>><%=rs("work_application")%></option>
                                      <%
                                       rs.movenext
                                       loop
                                       rs.close
                                       set rs=nothing
                                      %>
                                    </select>
                                </div>
                                <span id="work_type_err" class="err_text"></span>
                          </div>
                        </div>

                   <!-- <div class="control-group">
                      <label class="control-label">权限:</label>
                      <div class="controls">
                      <table>
                      <tr>
                        <td><input name="checkbox_all" type="checkbox" id="checkbox_all" onClick="check_all('checkbox_all','quanxian')"> 全选&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><input name="quanxian" type="checkbox" id="quanxian" value="[1]"> 分公司管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                        <td><input name="quanxian" type="checkbox" id="quanxian" value="[2]"> 职位管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><input name="quanxian" type="checkbox" id="quanxian" value="[3]"> 员工管理&nbsp;&nbsp;&nbsp;&nbsp;</td>
                         </tr>
                        </table>
                      </div>
                    </div>-->
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_work_application" type="submit" class="btn btn-primary">提交</button>
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