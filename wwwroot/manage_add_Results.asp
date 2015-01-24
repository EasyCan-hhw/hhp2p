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
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 提佣区间管理</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>添加提佣区间</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                       <div class="control-group">
                            <label class="control-label">&nbsp;工号:</label>
                            <div class="controls">
                                <input type="text" id="result_number" class="span5" name="result_number" style="width:275px;"/>
                                <span id="result_number_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">&nbsp;员工姓名:</label>
                            <div class="controls">
                                <input type="text" id="result_name" class="span5" name="result_name" style="width:275px;" disabled />
                                <span id="result_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;投资产品:</label>
                            <div class="controls">
                              <div class="span5" style="width:275px;">
                                <select id="result_product" name="result_product">
                                      <option value="" ></option>
                                      <%
                                      set rs=server.CreateObject("adodb.recordset")
                                      rs.Open "select * from products  order by id" ,conn,1,1
                                      do while not rs.eof
                                      %>
                                      <option value="<%=rs("product_name")%>" <%if rs("id")=position_id then%>selected<%end if%>><%=rs("product_name")%></option>
                                      <%
                                       rs.movenext
                                       loop
                                       rs.close
                                       set rs=nothing
                                      %>
                                    </select>
                                </div>
                                <span id="result_product_err" class="err_text"></span>
                              </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;理财金额:</label>
                            <div class="controls">
                                <input type="text" id="result_capital" class="span5" name="result_capital" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="width:275px;"/>
                                <span class="help-inline">元</span>
                                <span id="result_capital_err" class="err_text"></span>
                            </div>
                        </div>
                         
                         
                     <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_user_result_submit" type="submit" class="btn btn-primary">提交</button>
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
                        <h5>提佣区间列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap">职位</th>
                                <th>区间</th>
                                <th>提佣比例</th>
                                <th>档位</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
				err_txt="<tr><td colspan=""5"">没有添加提佣区间</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from brokerage_section order by bid",conn,1,1

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
            	  showpage1=showpage(totalput,MaxPerPage,"manage_brokerage_section.asp","")
       				else
            			if (currentPage-1)*MaxPerPage<totalPut then
                    	rs.move  (currentPage-1)*MaxPerPage
                    	dim bookmark
                    	bookmark=rs.bookmark
                    	showContent
                  		showpage1=showpage(totalput,MaxPerPage,"manage_brokerage_section.asp","")
          			  else
            	        currentPage=1
                      showContent
                      showpage1=showpage(totalput,MaxPerPage,"manage_brokerage_section.asp","")
  						    end if
  	   				end if
			  end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                            <tr>
                                <td style="vertical-align: middle;text-align:center">

                                  <input name="b_jobs_<%=int(rs("bid"))%>" id="b_jobs_<%=int(rs("bid"))%>" class="half" type="text" value="<%=trim(rs("bjobs"))%>"  disabled>
                                
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <input name="b_min_<%=int(rs("bid"))%>" id="b_min_<%=int(rs("bid"))%>" class="half" type="text" value="<%=trim(rs("bmin"))%>"  onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:100px"> 
                                   &nbsp;至&nbsp;
                                   <input name="b_max_<%=int(rs("bid"))%>" id="b_max_<%=int(rs("bid"))%>" class="half" type="text" value="<%=trim(rs("bmax"))%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:100px">
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <input name="b_scale_<%=int(rs("bid"))%>" id="b_scale_<%=int(rs("bid"))%>" class="half" type="text" value="<%=FormatNumber(trim(rs("bscale"))*100,2,-1,-1,0)%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:60px">&nbsp;%
                                 </td>
                                <td style="vertical-align: middle;text-align:center">
                                  
                                    <%
                                      if  rs("ladder") = 1 then
                                        response.write("一档")
                                      elseif rs("ladder")= 2 then
                                        response.write("二档")
                                     elseif rs("ladder")=3 then
                                        response.write("三档")
                                     elseif rs("ladder")=4 then
                                        response.write("四档")
                                     elseif rs("ladder")=5 then
                                        response.write("五档")
                                     elseif rs("ladder")=6 then
                                        response.write("六档")
                                     elseif rs("ladder")=7 then
                                        response.write("七档")
                                     elseif rs("ladder")=8 then
                                        response.write("八档")
                                     else
                                        response.write("九档")
                                      end if
                                    %>

                                   

                                  
                                   
                                
                                 </td>
                               
                                <td style="vertical-align: middle; text-align:center">
                                  
                                    <a href="javascript:;" id="section_edit_<%=int(rs("bid"))%>" class="section_edit">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="section_del_<%=int(rs("bid"))%>" class="section_del">删除</a>
                                
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