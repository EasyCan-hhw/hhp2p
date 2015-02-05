<!--#include file="head.asp" -->
<%

%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 假期添加</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">



        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>财务请款</h5>
                </div>
                <div class="widget-content nopadding">
                  <span id="product_name_err" class="err_text"></span>
                  <form action="" method="post" class="form-horizontal" >
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>日期:</label>
                            <div class="controls">
                                <input type="text" id="approval_date" name="approval_date"  value="<%=now%>" class="span5" style="width:220px;" disabled/>
                                
                                <span id="vacation_date_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>姓名:</label>
                            <div class="controls">
                                <input type="text" id="approval_name" name="approval_name"  value="<%=request.cookies("hhp2p_cookies")("full_name") %>" class="span5" style="width:220px;" disabled/>
                                
                                <span id="approval_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                          <label class="control-label"><font color="red">*</font>上传图片:</label>
                          <div class="controls">
                             <div class="span5" style="width:220px">
                             
                         
                          <!--<form method="POST" action="SaveFile.asp">
                              文件上传：
                              <input type="file" name="file" size="42">&nbsp;<input type="submit" value="提交" name="bb">-->
                            
                              
                            <input name="approval_photo" id="approval_photo" type="hidden" value="<%=passport_img_file%>" />
                             <input name="upload-approval_photo" id="upload-approval_photo" type="button" value="上传文件" class="btn btn-primary upload_imgs_submit">
                             <span class="help-inline">请上传照片，支持文件格式：JPG、GIF、PNG</span>
                                <span id="approval_photo_err" class="err_text"></span>
                            <div id="approval_photo_show" style="display:inline;">
                            <%=approval_photo%>
                            </div>
                             </div>
                              <span id="vacation_type_err" class="err_text"></span>
                          </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;备注:</label>
                            <div class="controls">
                                <input type="text" id="approval_money_text" class="span5" name="approval_money_text" style="width:220px;high:100px;"/>
                                <span id="approval_money_text_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="insert_approval_money_submit" type="submit" class="btn btn-primary">提&nbsp;交</button>&nbsp;
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
                        <h5>请款列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th width="20%">姓名</th>
                                <th width="20%">日期</th>
                                <th width="20%">图片名称</th>
                                <th width="20%">备注</th>
                                <th width="20%">状态</th>

                                
                            </tr>
                            </thead>
                            <tbody>
            <%
      err_txt="<tr><td colspan=""12"">没有请款信息</td></tr>"
      set rs=server.CreateObject("adodb.recordset")
      rs.Open "select * from request_photo order by aid desc",conn,1,1

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
                showpage1=showpage(totalput,MaxPerPage,"manage_request_money.asp","")
              else
                  if (currentPage-1)*MaxPerPage<totalPut then
                      rs.move  (currentPage-1)*MaxPerPage
                      dim bookmark
                      bookmark=rs.bookmark
                      showContent
                      showpage1=showpage(totalput,MaxPerPage,"manage_request_money.asp","")
                  else
                      currentPage=1
                      showContent
                      showpage1=showpage(totalput,MaxPerPage,"manage_request_money.asp","")
                  end if
              end if
        end if
        sub showContent
        i=0
      do while not rs.eof
      %>
                            <tr>
                                <td style="vertical-align: middle;text-align:center" name="" id="">
                                    <%=trim(rs("request_name"))%>
                                  </td>
                                  <td style="vertical-align: middle;text-align:center" name="" id="">
                                    <%=trim(rs("request_date"))%>
                                  </td>
                                <td style="vertical-align: middle;text-align:center" name="" id="" >
                                    <%=trim(rs("request_photo"))%>
                                    </td>
                                  <td style="vertical-align: middle;text-align:center" name="" id="">
                                    <%=trim(rs("request_text"))%>
                                     </td>
                                  <td style="vertical-align: middle; text-align:center">
                                      <%
                                        if rs("approval_request")<>0 then 
                                          %>
                                          已审批
                                          
                                          <%
                                        else 
                                          %>
                                            <span  class="err_text">未审批</span>
                                          <%
                                        end if 
                                      %>
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
                            <!--<span class="icon" style="cursor: pointer;" id="print_monthly_bill"> <i class="icon-print"></i> 批量打印</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
                        </div>
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
<script type="text/javascript" src="inputUpload/init_img.js"></script>
<!--#include file="foot.asp" -->