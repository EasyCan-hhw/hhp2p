<!--sidebar-menu-->
<%
     quanxianString = request.cookies("hhp2p_cookies")("quanxian")
    splitvalue = split(quanxianString,",")
    splitlength = ubound(splitvalue)
%>
<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
    <ul>
    	
        
        
    	
        <li><a href="javascript:;" id="sidebar_1" class="menu"><i class="icon <%if filename="add_customers" or filename="customer_tracking" or filename="manage_customers" then%>icon-chevron-up<%else%>icon-chevron-down<%end if%>"></i> <span>客户管理</span></a> 
        	<div class="sidebar" id="menu1" <%if filename="add_customers" or filename="customer_tracking" or filename="manage_customers" then%>style="display:inherit"<%end if%>>

                 <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[1]" then 
                %>
                <a href="customer_tracking.asp" <%if filename="customer_tracking" then%>class="active1"<%end if %> ><i class="icon icon-edit"></i> <span>目标客户添加及跟踪</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[2]" then 
                %>
            	<a href="add_customers.asp" <%if filename="add_customers" then%>class="active1" <%end if %> ><i class="icon icon-edit"></i> <span>添加正式客户</span></a>
                 <%          exit for 
                        else 
                        end if 
                    next
                %>
                 <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[3]" or splitvalue(s)="[33]" then 
                %>
            	<a href="manage_customers.asp" <%if filename="manage_customers" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>客户查询</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
            </div>
        </li>
        
    	
        <li><a href="javascript:;" id="sidebar_2" class="menu"><i class="icon <%if   filename="redeem_attorn_creditor_right" or filename="manage_redeem"  or filename="add_creditor_right" or filename="manage_attorn_creditor_right" then%>icon-chevron-up<%else%>icon-chevron-down<%end if%>"></i> <span>债权管理</span></a> 
        	<div class="sidebar" id="menu2" <%if   filename="add_creditor_right" or filename="redeem_attorn_creditor_right" or filename="manage_redeem" or filename="manage_attorn_creditor_right" then%>style="display:inherit"<%end if%>>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[4]" then 
                %>
                <a href="add_creditor_right.asp" <%if filename="add_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>一般借贷申请</span></a>
                 <%          exit for 
                        else 
                        end if 
                    next
                %>
                
               
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[7]" then 
                %>
            	<a href="manage_attorn_creditor_right.asp" <%if filename="manage_attorn_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>债权转让查询</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[25]" then 
                %>
                <a href="redeem_attorn_creditor_right.asp" <%if filename="redeem_attorn_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>债权转让赎回</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[26]" then 
                %>
                <a href="manage_redeem.asp" <%if filename="manage_redeem" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>赎回查询</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
            </div>
        </li>
        
    	
        <li><a href="javascript:;" id="sidebar_3" class="menu"><i class="icon <%if filename="manage_products" or filename="manage_creditor_right" or filename="attorn_creditor_right" then%>icon-chevron-up<%else%>icon-chevron-down<%end if%>"></i> <span>客服管理</span></a> 
        	<div class="sidebar" id="menu3" <%if filename="manage_products" or filename="manage_creditor_right" or filename="attorn_creditor_right"  then%>style="display:inherit"<%end if%>>
                 <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[5]" then 
                %>
                <a href="manage_creditor_right.asp" <%if filename="manage_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>债权查询</span></a>
                 <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[6]" then 
                %>
                <a href="attorn_creditor_right.asp" <%if filename="attorn_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>债权转让</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[13]" then 
                %>
                <a href="manage_products.asp" <%if filename="manage_products" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>投资产品管理</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
            </div>
        </li>
        
    	
        <li><a href="javascript:;" id="sidebar_6" class="menu"><i class="icon <%if filename="manage_users" or filename="manage_Insurance_set" or filename="manage_work_setrest" or filename="manage_daka" or filename="manage_work" or filename="manage_add_vacation" then%>icon-chevron-up<%else%>icon-chevron-down<%end if%>"></i> <span>行政人事</span></a> 
        	<div class="sidebar" id="menu6" <%if filename="manage_users" or filename="manage_Insurance_set" or filename="manage_daka" or filename="manage_work" or filename="manage_work_setrest" or filename="manage_add_vacation" then%>style="display:inherit"<%end if%>>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[8]" then 
                %>
            	<a href="manage_users.asp" <%if filename="manage_users" then%>class="active1"<%end if%>><i class="icon icon-user"></i> <span>员工管理</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                 <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[9]" then 
                %>
                <a href="manage_daka.asp" <%if filename="manage_daka" then%>class="active1"<%end if%>><i class="icon icon-user"></i> <span>打卡录入</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[10]" then 
                %>
                <a href="manage_work.asp" <%if filename="manage_work" then%>class="active1"<%end if%>><i class="icon icon-user"></i> <span>考勤申请</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[11]" then 
                %>
                <a href="manage_work_setrest.asp" <%if filename="manage_work_setrest" then%>class="active1"<%end if%>><i class="icon icon-user"></i> <span>上班作息调整</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[12]" then 
                %>
                <a href="manage_add_vacation.asp" <%if filename="manage_add_vacation" then%>class="active1"<%end if%>><i class="icon icon-user"></i> <span>假期添加</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <a href="manage_Insurance_set.asp" <%if filename="manage_Insurance_set" then%>class="active1"<%end if%>><i class="icon icon-user"></i> <span>员工保险设置</span></a>
            </div>
        </li>
        
    	
        <li><a href="javascript:;" id="sidebar_4" class="menu"><i class="icon <%if  filename="manage_brokerage_section"  or filename="manage_monthly_bill" or filename="manage_user_bonus_proportion" or filename="manage_jobs_bonus_proportion" or filename="manage_pay_count" or filename="manage_companys_bonus_proportion" or filename="manage_achievement" or filename="manage_add_Results" or filename="manage_request_money" or filename="manage_commission_set" or filename="manage_PaiXiTiXing"  then%>icon-chevron-up<%else%>icon-chevron-down<%end if%>"></i> <span>财务管理</span></a> 
        	<div class="sidebar" id="menu4" <%if  filename="manage_monthly_bill" or filename="manage_user_bonus_proportion" or filename="manage_PaiXiTiXing" or filename="manage_jobs_bonus_proportion" or filename="manage_brokerage_section" or filename="manage_companys_bonus_proportion" or filename="manage_pay_count" or filename="manage_achievement" or filename="manage_commission_set" or filename="manage_request_money" or filename="manage_add_Results"  then%>style="display:inherit"<%end if%>>
                 <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[30]" then 
                %>
                <a href="manage_request_money.asp" <%if filename="manage_request_money" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>财务请款</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[27]" then 
                %>
            	<a href="manage_monthly_bill.asp" <%if filename="manage_monthly_bill" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>账单查询</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[14]" then 
                %>
                <a href="manage_PaiXiTiXing.asp" <%if filename="manage_PaiXiTiXing" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>派息提醒</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[15]" then 
                %>
                <a href="manage_pay_count.asp" <%if filename="manage_pay_count" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>工资核算</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                
                 <a href="manage_add_Results.asp" <%if filename="manage_add_Results" then%>class="active1"<%end if%> style="display: none;"><i class="icon icon-th-list"></i> <span>添加线上员工业绩</span></a>
                 
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[16]" then 
                %>
                <a href="manage_brokerage_section.asp" <%if filename="manage_brokerage_section" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>提佣区间设置</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[17]" then 
                %>
                <a href="manage_commission_set.asp" <%if filename="manage_commission_set" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>提成加薪设置</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[18]" then 
                %>
            	<a href="manage_achievement.asp" <%if filename="manage_achievement" then%>class="active1"<%end if%>><i class="icon icon-edit"></i> <span>员工业绩查询</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
            	<a href="manage_companys_bonus_proportion.asp" <%if filename="manage_companys_bonus_proportion" then%>class="active1"<%end if%> style="display: none;"><i class="icon icon-th-list"></i> <span>分公司业绩提成设置</span></a>
            	<a href="manage_jobs_bonus_proportion.asp" <%if filename="manage_jobs_bonus_proportion" then%>class="active1"<%end if%> style="display: none;"><i class="icon icon-th-list"></i> <span>职位业绩提成设置</span></a>
            	<a href="manage_user_bonus_proportion.asp" <%if filename="manage_user_bonus_proportion" then%>class="active1"<%end if%> style="display: none;"><i class="icon icon-th-list"></i> <span>员工业绩提成设置</span></a>

            </div>
        </li>
        
    	
        <li><a href="javascript:;" id="sidebar_5" class="menu"><i class="icon <%if filename="approval_creditor_right" or filename="approval_request_money" or filename="approval_attorn_creditor_right" or filename="manage_examine_work" then%>icon-chevron-up<%else%>icon-chevron-down<%end if%>"></i> <span>审批中心</span></a> 
        	<div class="sidebar" id="menu5" <%if filename="approval_creditor_right" or filename="approval_attorn_creditor_right" or filename="approval_redeem_attorn_creditor_right" or filename="manage_examine_work" or filename="approval_request_money" then%>style="display:inherit"<%end if%>>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[31]" then 
                %>
                <a href="approval_request_money.asp" <%if filename="approval_request_money" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>财务请款审批</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[19]" then 
                %>
            	<a href="approval_creditor_right.asp" <%if filename="approval_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>新增债权审批</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[20]" then 
                %>
            	<a href="approval_attorn_creditor_right.asp" <%if filename="approval_attorn_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>债权转让审批</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[21]" then 
                %>
            	<a href="approval_redeem_attorn_creditor_right.asp" <%if filename="approval_redeem_attorn_creditor_right" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>赎回债权转让审批</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[22]" then 
                %>
                <a href="manage_examine_work.asp" <%if filename="manage_examine_work" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>考勤审批</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
            </div>
        </li>
        
    	
        <li><a href="javascript:;" id="sidebar_7" class="menu"><i class="icon <%if filename="manage_companys" or filename="manage_jobs" or filename="manage_collateral_class" then%>icon-chevron-up<%else%>icon-chevron-down<%end if%>"></i> <span>系统设置</span></a> 
        	<div class="sidebar" id="menu7" <%if filename="manage_companys" or filename="manage_jobs" or filename="manage_collateral_class" then%>style="display:inherit"<%end if%>>
                 <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[24]" then 
                %>
            	<a href="manage_companys.asp" <%if filename="manage_companys" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>分公司管理</span></a>
                 <%          exit for 
                        else 
                        end if 
                    next
                %>
                 <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[23]" then 
                %>
            	<a href="manage_jobs.asp" <%if filename="manage_jobs" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>职位管理</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
                <%
                    for s=0 to splitlength 
                        if splitvalue(s)="[28]" then 
                %>
            	<a href="manage_collateral_class.asp" <%if filename="manage_collateral_class" then%>class="active1"<%end if%>><i class="icon icon-th-list"></i> <span>债权分类管理</span></a>
                <%          exit for 
                        else 
                        end if 
                    next
                %>
            </div>
        </li>
        
    </ul>
</div>
<!--sidebar-menu-->
