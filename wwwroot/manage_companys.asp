<!--#include file="head.asp" -->
<%

%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 分公司管理</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>添加分公司</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;分公司代码:</label>
                            <div class="controls">
                                <input type="text" id="company_code" class="half" name="company_code" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)"/>
                                <span id="company_code_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;分公司名称:</label>
                            <div class="controls">
                                <input type="text" id="company_name" class="half" name="company_name"/>
                                <span id="company_name_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;上级分公司:</label>
                            <div class="controls">
                               <div class="span5" style="width:220px" >
                                <select id="superior_companys" name="superior_companys" value="">
                                      <option value="" ></option>
                                        <%
                                      set rs=server.CreateObject("adodb.recordset")
                                      rs.Open "select * from companys order by id" ,conn,1,1
                                      do while not rs.eof
                                      %>
                                      <option  value="<%=rs("company_code")%>" <%if rs("id")=company_name then%>selected<%end if%>><%=rs("company_name")%></option>
                                      <%
                                       rs.movenext
                                       loop
                                       rs.close
                                       set rs=nothing
                                      %>  
                                    </select>
                                  </div>
                                <span class="help-inline">无可不填</span>
                                <span id="company_name_err" class="err_text"></span>
                            </div>
                        </div>
                      <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_company_submit" type="submit" class="btn btn-primary">提交</button>
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
                        <h5>分公司列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th width="25%">分公司代码</th>
                                <th width="30%">分公司名称</th>
                                <th width="30">上级分公司</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%

				err_txt="<tr><td colspan=""3"">没有分公司</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from companys order by id",conn,1,1

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
            			showpage1=showpage(totalput,MaxPerPage,"manage_companys.asp","")
       				else
          				if (currentPage-1)*MaxPerPage<totalPut then
            				rs.move  (currentPage-1)*MaxPerPage
            				dim bookmark
            				bookmark=rs.bookmark
            				showContent
             				showpage1=showpage(totalput,MaxPerPage,"manage_companys.asp","")
        				else
	        				currentPage=1
           					showContent
           					showpage1=showpage(totalput,MaxPerPage,"manage_companys.asp","")
						end if
	   				end if
			end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                                                        <tr>
                                <td style="vertical-align: middle;text-align:center"><input name="company_code<%=int(rs("id"))%>" id="company_code<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("company_code"))%>"></td>
                                <td style="vertical-align: middle;text-align:center"><input name="company_name<%=int(rs("id"))%>" id="company_name<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("company_name"))%>"></td>
                                <td style="vertical-align: middle;text-align:center"><input name="company_name<%=int(rs("id"))%>" id="company_name<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("company_count"))%>"></td>
                                <td style="vertical-align: middle; text-align:center">
                                    <a href="javascript:;" id="company_edit_<%=int(rs("id"))%>" class="company_edit">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="company_del_<%=int(rs("id"))%>" class="company_del">删除</a>
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