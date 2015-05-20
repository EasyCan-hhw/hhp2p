<!--#include file="conn.asp" -->
<!--#include file="company_function.asp"-->


<%
	class responseSub
          public EndDate
         public dateNumber
         public  error
     end class

    
     
	function responseEndDate(startDate,Number)
		set responseEndDate = new responseSub
		error = 520
		listDate = split(startDate,"-")
		if datediff("d",startDate,now())>Number+5 then '判断理财是否已过期' 
				'response.write "  start="&datediff("d",startDate,now())&"//"&Number+5&"  "
				'responseEndDate.error = 0

		elseif cint(listdate(2))=1 then '如果为月初一号'
			
				monthnumber = datediff("m",startDate,dateadd("d",3,now()))'dateadd("d",3,now()) 提前三天的时间，三月一号和二月月底算出来的时间不一样 所以要加上提前的天数
				responseEndDate.dateNumber = monthnumber
				responseEndDate.EndDate = DateAdd("d",-1,dateadd("m",monthnumber,startDate))
				exit function
			 
		elseif cint(listDate(2))=28 or cint(listDate(2))=29 or cint(listDate(2))=30 or cint(listDate(2))=31 then '如果为月底'
			
				monthnumber1 = datediff("m",startDate,dateadd("d",3,now()))
				responseEndDate.dateNumber = monthnumber1
				responseEndDate.EndDate = dateadd("d",-1,DateAdd("m",monthnumber1,startDate))
				exit function
		else 
				monthnumber2 = datediff("m",startDate,dateadd("d",3,now()))'dateadd("d",3,now()) 提前三天的时间，三月一号和二月月底算出来的时间不一样 所以要加上提前的天数
				responseEndDate.dateNumber = monthnumber2
				responseEndDate.EndDate = DateAdd("d",-1,dateadd("m",monthnumber2,startDate))
				exit function
	
		end if 

	end function

	 class testboolen
     	public valuevalue
     	public valueRs
     	public valueExpire 
     end class

	function  test(startDate,number)
	set test = new testboolen
		
		if datediff("d",startDate,now()) > number then  '判断合同是否过期'
			test.valuevalue = false
			test.valueExpire = 0
		else
			monthnumber = datediff("m",startDate,now())
			EndDate = DateAdd("d",-1,DateAdd("m",monthnumber,startDate))
			nowdate = year(date())&"/"&month(date())&"/"&day(date())
			twodate = DateAdd("d",1,nowdate)
			theredate = DateAdd("d",2,nowdate)
			if cstr(EndDate) = cstr(nowdate) or cstr(EndDate) = cstr(twodate) or cstr(EndDate) = cstr(theredate) then
			 	'response.write "通过"
				'response.write EndDate&"="&nowdate&"后一天="&EndDate&"="&twodate&"后第二天="&EndDate&"="&theredate&"<>"&nowdate&twodate&theredate&"</br>"
				test.valuevalue = true
				'test.valueRs = rs
			else
				test.valuevalue = false
			end if 

		end if 

		set rs=server.CreateObject("adodb.recordset")
		'rs.Open "select * from contracts inner join users on contracts.job_number = users.job_number and (users.company_code = '"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"' or users.company_id ="&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&" ) and contracts.approval=1 and contracts.redeem=0 order by id desc",conn,1,1

	end function


	

	
	function contractsTools(company_code)
		
		'response.write requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))
		dim contractsValue1
		'redim contractsValue(0,11)
		intValue = 0
		dim contractsValue2
		redim contractsValue1(1)
		redim contractsValue2(12)
		set rs=server.CreateObject("adodb.recordset")
		rs.Open "select * from contracts inner join users on contracts.job_number = users.job_number and (users.company_code='"&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&"' or users.company_id="&requestCompanyjudge(request.cookies("hhp2p_cookies")("job_number"))&" ) and contracts.approval=1 and contracts.redeem=0 order by start_date desc",conn,1,1

			do while not rs.eof
				if test(rs("start_date"),rs("cycle")).valuevalue then 

					contractsValue2(0) = rs("number")'合同编号'
					contractsValue2(1) = salesmanName(rs("job_number"))'业务员'
					contractsValue2(2) = rs("c_name")'客户姓名'
					contractsValue2(3) = rs("passport")'身份证'
					contractsValue2(4) = customBankMessage(rs("cid"))'银行信息'
					contractsValue2(5) = rs("product_name")'理财产品'
					contractsValue2(6) = rs("capital")'初始理财金额'
					contractsValue2(7) = rs("start_date")'初始理财日期'
					contractsValue2(8) = responseEndDate(rs("start_date"),rs("cycle")).dateNumber'账单期数
					contractsValue2(9) = rs("start_date")&"&nbsp;至&nbsp;"&responseEndDate(rs("start_date"),rs("cycle")).EndDate'账单周期
					contractsValue2(10) = Round((cdbl(rs("profit"))*cdbl(rs("capital")))/12,2)'本期派息额度'
					contractsValue2(11) = responseEndDate(rs("start_date"),rs("cycle")).EndDate'出账日期

					contractsValue1(intValue) = contractsValue2
					intValue = intValue+1
					ReDim Preserve contractsValue1(intValue + 1)
				end if 
				
				rs.movenext

			loop

		rs.close
		set rs = nothing

		for v = 0 to UBound(contractsValue1)-2
			
			for u= v+1 to UBound(contractsValue1)-2
				if datediff("d",contractsValue1(int(v))(11),contractsValue1(int(u))(11)) > 0 then 

					
				elseif datediff("d",contractsValue1(int(v))(11),contractsValue1(int(u))(11)) < 0 then 
				
					'response.write "first_contractsValue1(v)="&contractsValue1(v)(11)
					'response.write "first_contractsValue1(u)"&contractsValue1(u)(11)&"</br>"
					minValue = contractsValue1(v)
					contractsValue1(v) = contractsValue1(u)
					contractsValue1(u) = minValue
					'response.write "contractsValue1(v)="&contractsValue1(v)(11)
					'response.write "contractsValue1(u)"&contractsValue1(u)(11)&"</br>"
					
					
				elseif datediff("d",contractsValue1(int(v))(11),contractsValue1(int(u))(11)) = 0 then 

				end if 
			next

		next
		contractsTools = contractsValue1
	end function 

	function salesmanName(rsjob_number)
		set rs=server.CreateObject("adodb.recordset")
		rs.Open "select * from users where job_number='"&job_number&"'",conn,1,1
		if not rs.eof then 
			salesmanName = rs("full_name")
		else 
			salesmanName = 0
		end if 
		rs.close
		set rs = nothing
	end function 
	function customBankMessage(rscid)
		set rs=server.CreateObject("adodb.recordset")
		rs.Open "select * from users where job_number='"&job_number&"'",conn,1,1
		if isnull(rs("bank_account")) or isnull(rs("bank_info")) then 

			customBankMessage = rs("bank_account")&"/"&rs("bank_info")

		else


			customBankMessage = 0

		end if
		rs.close
		set rs = nothing
	end function
%>
