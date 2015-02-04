<!--#include file="head.asp" -->
<%

%>
<!--#include file="sidebar_menu.asp" -->
<!--main-container-part-->

<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="####" class="tip-bottom"><i class="icon-th-list"></i> 提成加薪设置</a></div>
    </div>
    <!--End-breadcrumbs-->

    <div class="container-fluid">
        
        <div class="row-fluid">
            <div class="span12">
              <div class="widget-box">
                <div class="widget-title"> <span class="icon"> <i class="icon-edit"></i> </span>
                  <h5>添加</h5>
                </div>
                <div class="widget-content nopadding">
                  <form action="" method="post" class="form-horizontal" onSubmit="return false;">
                  
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;员工工号:</label>
                            <div class="controls">
                                <input type="text" id="Cjob_number" class="half" name="Cjob_number"/>
                                <span id="Cjob_number_err" class="err_text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;月份:</label>
                            <div class="controls">
                                <input type="text" id="Cdate" name="Cdate" onFocus="WdatePicker({el:this})" autocomplete="off" class="half" /> 
                                <span id="Cdate_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;绩效奖金追加:</label>
                            <div class="controls">
                                <input type="text" id="Cjixiao" class="half" name="Cjixiao"  onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right"/> 元
                                <span id="Cjixiao_err" class="err_text"></span>
                            </div>
                        </div>
                         <div class="control-group">
                            <label class="control-label"><font color="red">*</font>&nbsp;津贴佣金:</label>
                            <div class="controls">
                                <input type="text" id="Cchargehand" class="half" name="Cchargehand" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right"/> 元
                                <span id="Cchargehand_err" class="err_text"></span>
                            </div>
                        </div>
                       
                     <div class="form-actions">
                          <label class="control-label"></label>
                          <button id="add_commission_manage_submit" type="submit" class="btn btn-primary">提交</button>
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
                        <h5>奖金津贴列表</h5>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped with-check">
                            <thead>
                            <tr>
                                <th>工号</th>
                                <th>姓名</th>
                                <th>月份</th>
                                <th>绩效奖金追加</th>
                                <th>小组长津贴佣金</th>
                                <th width="20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
            <%
				err_txt="<tr><td colspan=""5"">没有奖金信息</td></tr>"
			set rs=server.CreateObject("adodb.recordset")
			rs.Open "select * from Commission_manage order by cid",conn,1,1

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
            	  showpage1=showpage(totalput,MaxPerPage,"manage_commission_set.asp","")
       				else
            			if (currentPage-1)*MaxPerPage<totalPut then
                    	rs.move  (currentPage-1)*MaxPerPage
                    	dim bookmark
                    	bookmark=rs.bookmark
                    	showContent
                  		showpage1=showpage(totalput,MaxPerPage,"manage_commission_set.asp","")
          			  else
            	        currentPage=1
                      showContent
                      showpage1=showpage(totalput,MaxPerPage,"manage_commission_set.asp","")
  						    end if
  	   				end if
			  end if
   			sub showContent
	   		i=0
			do while not rs.eof
			%>
                            <tr>
                                <td style="vertical-align: middle;text-align:center">
                                  <%=trim(rs("Cjob_number"))%>
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <%
                                    set rsUser=server.CreateObject("adodb.recordset")
                                    rsUser.Open "select * from users where job_number="&rs("Cjob_number")&"",conn,1,1
                                   response.write rsUser("full_name")
                                   rsUser.close
                                   set rsUser = nothing
                                  %>
                                </td>
                                <td style="vertical-align: middle;text-align:center">
                                 <%=trim(rs("Cdate"))%>
                                 </td>
                                <td style="vertical-align: middle;text-align:center">
                                  <input name="Cjixiao_<%=int(rs("cid"))%>" id="Cjixiao_<%=int(rs("cid"))%>" class="half" type="text" value="<%=trim(rs("Cjixiao"))%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:60px">
                                 </td>
                                <td style="vertical-align: middle;text-align:center">
                                   <input name="Cchargehand_<%=int(rs("cid"))%>" id="Cchargehand_<%=int(rs("cid"))%>" class="half" type="text" value="<%=trim(rs("Cchargehand"))%>" onKeyUp="onlymoney(this,this.value)" onafterpaste="onlymoney(this,this.value)" style="text-align:right;width:60px">
                                 </td>
                                <td style="vertical-align: middle; text-align:center">
                                    <a href="javascript:;" id="commission_edit_<%=int(rs("cid"))%>" class="commission_edit">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                    <a href="javascript:;" id="commission_del_<%=int(rs("cid"))%>" class="commission_del">删除</a>
                                
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