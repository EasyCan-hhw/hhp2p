<!--#include file="head.asp" -->
<!--#include file="company_function.asp"-->
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i>员工保险设置</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">

<%
if id<>"" then

else
%>

        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>员工保险设置</h5>
                </div>
                <div class="widget-content nopadding">
                  <span id="product_name_err" class="err_text"></span>
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label">&nbsp;所属分公司代码:</label>
                            <div class="controls">
                                <input type="text" id="company_number_insurance" value="<%=requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))%>" class="span5" name="company_number_insurance" style="width:220px;high:100px;" disabled/>
                                <span id="company_number_insurance_err" class="err_text"></span>
                            </div>
                        </div>
                       <div class="control-group">
                            <label class="control-label">&nbsp;填写名称:</label>
                            <div class="controls">
                                <input type="text" id="name_insurance" class="span5" name="name_insurance" style="width:220px;high:100px;"/>
                                <span id="name_insurance_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;扣除金额:</label>
                            <div class="controls">
                                <input type="text" id="money_insurance" class="span5" name="money_insurance" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="width:220px;high:100px;"/>
                                <span id="money_insurance_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="insert_insurance_submit" type="submit" class="btn btn-primary">添&nbsp;加</button>&nbsp;
                          <!--<button id="select_vacation" type="submit" class="btn btn-primary">查&nbsp;询</button>&nbsp;-->
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
                        <h5>员工保险信息表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th width="25%">所属公司代码</th>
                                <th width="25%">信息名称</th>
                                <th width="25%">扣款金额</th>
                                <th width="25%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
              err_txt="<tr><td colspan=""12"">没有保险信息</td></tr>"
              set rs=server.CreateObject("adodb.recordset")
              rs.Open "select * from insurance_set where insurance_company="&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&" order by iid",conn,1,1

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
                        showpage1=showpage(totalput,MaxPerPage,"manage_Insurance_set.asp","")
                      else
                          if (currentPage-1)*MaxPerPage<totalPut then
                              rs.move  (currentPage-1)*MaxPerPage
                              dim bookmark
                              bookmark=rs.bookmark
                              showContent
                              showpage1=showpage(totalput,MaxPerPage,"manage_Insurance_set.asp","")
                          else
                              currentPage=1
                              showContent
                              showpage1=showpage(totalput,MaxPerPage,"manage_Insurance_set.asp","")
                          end if
                      end if
                end if
                sub showContent
                i=0
              do while not rs.eof
              %>
                               <tr>
                                   <td style="vertical-align: middle;text-align:center">
                                    <input name="company<%=int(rs("iid"))%>" id="company<%=int(rs("iid"))%>" class="half" type="text" value="<%=rs("insurance_company")%>" style="text-align:center;width:60px" disabled/> 
                                    </td>
                                  <td style="vertical-align: middle;text-align:center">
                                    <input name="name<%=int(rs("iid"))%>" id="name<%=int(rs("iid"))%>" class="half" type="text" value="<%=rs("insurance_name")%>" style="text-align:center;width:100px"/>
                                     </td>
                                   <td style="vertical-align: middle;text-align:center">
                                    <input name="money<%=int(rs("iid"))%>" id="money<%=int(rs("iid"))%>" class="half" type="text" value="<%=rs("insurance_money")%>" style="text-align:center;width:60px"/> 
                                    </td>
                                  <td style="vertical-align: middle; text-align:center">
                                      <a href="javascript:;" id="insurance_edit_<%=int(rs("iid"))%>" class="insurance_edit">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                      <a href="javascript:;" id="insurance_del_<%=int(rs("iid"))%>" class="insurance_del">删除</a>
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