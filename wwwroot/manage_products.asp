<!--#include file="head.asp" -->
<%

%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 投资产品管理</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>添加投资产品</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;产品名称:</label>
                            <div class="controls">
                                <input type="text" id="product_name" class="half" name="product_name"/>
                                <span id="product_name_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;投资周期:</label>
                            <div class="controls">
                                <input type="text" id="cycle" class="half" name="cycle" style="text-align:right"/> 天
                                <span id="cycle_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;投资起点:</label>
                            <div class="controls">
                                <input type="text" id="base" class="half" name="base" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right"/> 元
                                <span id="base_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;年化收益率:</label>
                            <div class="controls">
                                <input type="text" id="profit" class="half" name="profit" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right"/> %
                                <span id="profit_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;赎回违约金:</label>
                            <div class="controls">
                                <input type="text" id="penalty" class="half" name="penalty" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right"/> ‰
                                <span id="penalty_err" class="err_text"></span>
                            </div>
                        </div>
                     <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_product_submit" type="submit" class="btn btn-primary">提交</button>
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
                        <h5>产品列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th nowrap="nowrap">产品名称</th>
                                <th>投资周期</th>
                                <th>投资起点</th>
                                <th>年化收益率</th>
                                <th>赎回违约金</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
				err_txt="<tr><td colspan=""5"">没有产品</td></tr>"
  			set rs=server.CreateObject("adodb.recordset")
  			rs.Open "select * from products order by id",conn,1,1

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
            	  showpage1=showpage(totalput,MaxPerPage,"manage_products.asp","")
       				else
            			if (currentPage-1)*MaxPerPage<totalPut then
                    	rs.move  (currentPage-1)*MaxPerPage
                    	dim bookmark
                    	bookmark=rs.bookmark
                    	showContent
                  		showpage1=showpage(totalput,MaxPerPage,"manage_products.asp","")
          			  else
            	        currentPage=1
                      showContent
                      showpage1=showpage(totalput,MaxPerPage,"manage_products.asp","")
  						    end if
  	   				end if
			  end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                            <tr>
                                <td style="vertical-align: middle;text-align:center">

                                  <input name="product_name<%=int(rs("id"))%>" id="product_name<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("product_name"))%>" style="width:60px" >
                                
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                 
                                  <input name="cycle<%=int(rs("id"))%>" id="cycle<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("cycle"))%>" style="text-align:right;width:60px"> 
                                  天
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                
                                  <input name="base<%=int(rs("id"))%>" id="base<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("base"))%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:60px">
                                   元
                                
                                 </td>
                                <td style="vertical-align: middle;text-align:center">
                                  
                                  <input name="profit<%=int(rs("id"))%>" id="profit<%=int(rs("id"))%>" class="half" type="text" value="<%=trim(rs("profit"))*100%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:60px">
                                   %
                                
                                 </td>
                                <td style="vertical-align: middle;text-align:center">
                                  
                                  <input name="penalty<%=int(rs("id"))%>" id="penalty<%=int(rs("id"))%>" class="half" type="text" value="<%=FormatNumber(trim(rs("penalty"))*1000,-1,-1,-1)%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:60px">
                                   ‰
                                 
                                 </td>
                                <td style="vertical-align: middle; text-align:center">
                                  
                                    <a href="javascript:;" id="product_edit_<%=int(rs("id"))%>" class="product_edit">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="product_del_<%=int(rs("id"))%>" class="product_del">删除</a>
                                
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