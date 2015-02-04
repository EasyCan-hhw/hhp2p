<!--#include file="config.asp" -->
<%

server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))


if Request.Servervariables("REQUEST_METHOD")="POST" then

if request.cookies("hhp2p_cookies")("uid")="" then
	response.write "2|"
	response.end
end if

action=SafeRequest("action")
cid=Trim(SafeRequest("cid"))
o_number=Trim(SafeRequest("number"))
product_name=Trim(SafeRequest("product_name"))
capital=Trim(SafeRequest("capital"))
start_date=Trim(SafeRequest("start_date"))
ids=Trim(SafeRequest("ids"))
creditor_right_amount=Trim(SafeRequest("creditor_right_amount"))

if action="add"or action="edit" then
set rs=server.createobject("adodb.recordset")
rs.Open "select * from customers where id="&cid,conn,1,1
if not rs.eof then
	passport=rs("passport")
	full_name=rs("full_name")
end if
rs.close
rs.Open "select * from products where product_name='"&product_name&"'",conn,1,1
if not rs.eof then
	cycle=rs("cycle")
	profit=rs("profit")
	if cdbl(capital)<cdbl(rs("base")) then
		response.write "1|capital|初始理财资金低于所选理财产品起点资金"
		response.end
	end if
end if
rs.close
set rs=nothing
end if


if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from contracts where number='"&o_number&"'",conn,1,1
	if not rs.eof then
		response.write "1|number|合同编号已存在"
		response.end
	end if
	rs.close
	isample=0
	if creditor_right_amount="1" then
		rs.Open "select isnull(remaining_amount,0),id from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 order by datediff(d,approval_date,'"&now()&"') desc",conn,1,1
		do while not rs.eof
			if rs(0)>=cdbl(capital) then
				isample=1
				creditor_right_id1=rs(1)
				exit do
			end if
		rs.movenext
		loop
		rs.close
	elseif creditor_right_amount="2" then
		rs.Open "select isnull(remaining_amount,0),id from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 order by datediff(d,approval_date,'"&now()&"') desc",conn,1,1
		do while not rs.eof
			set rs1=server.createobject("adodb.recordset")
			rs1.Open "select isnull(remaining_amount,0) as remaining_amount,(select count(id) from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 and id<>"&rs(1)&") as total,id from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 and id<>"&rs(1)&" order by datediff(d,approval_date,'"&now()&"') desc",conn,1,1
			if not rs1.eof then
				for i=1 to rs1(1)
					if cdbl(rs(0))+cdbl(rs1(0))>=cdbl(capital) then
						isample=1
						remaining_amount1=rs(0)
						remaining_amount2=rs1(0)
						creditor_right_id1=rs(1)
						creditor_right_id2=rs1(2)
						exit for
					end if
				next
			end if
			rs1.close
			set rs1=nothing
			if isample=1 then exit do
		rs.movenext
		loop
		rs.close
	else
		rs.Open "select isnull(sum(remaining_amount),0) from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0",conn,1,1
		if rs(0)>=cdbl(capital) then
			isample=1
		end if
		rs.close
	end if
	if isample=0 then
			response.write "3|根据所选匹配债权数计算，可匹配金额不足，无法完成债权分配。"
			response.end
	end if
	sql = "Select * from contracts"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("number")=o_number
	rs("cid")=cid
	rs("passport")=passport
	rs("full_name")=full_name
	rs("product_name")=product_name
	rs("cycle")=cycle
	rs("profit")=profit
	rs("capital")=capital
	rs("start_date")=start_date
	rs("add_uid")=request.cookies("hhp2p_cookies")("uid")
	rs("inputdate")=now()
	rs.update
	temp = rs.bookmark 
	rs.bookmark = temp
	c_id=rs("id")
	rs.close
	
	if creditor_right_amount="1" then
		rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
		if not rs.eof then
			conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&capital&")"
			creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
			rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
			capital=0
			rs.update
		end if
		rs.close
	elseif creditor_right_amount="2" then
		if cdbl(remaining_amount1)>=cdbl(capital) and cdbl(remaining_amount2)>=cdbl(capital) then
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&round(capital/2,2)&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&round(capital/2,2)
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(round(capital/2,2))
				capital=capital-round(capital/2,2)
				rs.update
			end if
			rs.close
			creditor_rights=creditor_rights&"/"
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id2,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&capital&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
				rs.update
			end if
			rs.close
		elseif cdbl(remaining_amount1)<cdbl(capital) then
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&rs("remaining_amount")&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&rs("remaining_amount")
				capital=cdbl(capital)-cdbl(rs("remaining_amount"))
				rs("remaining_amount")=0
				rs.update
			end if
			rs.close
			creditor_rights=creditor_rights&"/"
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id2,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&capital&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
				rs.update
			end if
			rs.close
		elseif cdbl(remaining_amount2)<cdbl(capital) then
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id2,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&rs("remaining_amount")&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&rs("remaining_amount")
				capital=cdbl(capital)-cdbl(rs("remaining_amount"))
				rs("remaining_amount")=0
				rs.update
			end if
			rs.close
			creditor_rights=creditor_rights&"/"
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&capital&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
				rs.update
			end if
			rs.close
		end if
	else
		rs.Open "select * from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 order by datediff(d,approval_date,'"&now()&"') desc",conn,1,3
		do while not rs.eof
			if capital>0 then
				if creditor_rights<>"" then creditor_rights=creditor_rights&"/"
				if cdbl(rs("remaining_amount"))<=cdbl(capital) then
					conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&rs("remaining_amount")&")"
					creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&rs("remaining_amount")
					capital=cdbl(capital)-cdbl(rs("remaining_amount"))
					rs("remaining_amount")=0
					rs.update
				else
					conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&c_id&","&rs("id")&","&capital&")"
					creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
					rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
					capital=0
					rs.update
				end if
			else
				exit do
			end if
		rs.movenext
		loop
		rs.close
	end if
	set rs=nothing
	response.write "0|"&creditor_rights&"|"&c_id
	response.end
	
elseif action="edit" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from contracts where number='"&o_number&"' and id<>"&id,conn,1,1
	if not rs.eof then
		response.write "1|number|合同编号已存在"
		response.end
	end if
	rs.close
	rs.Open "select * from contracts where approval=0 and id="&id,conn,1,1
	if rs.eof then
		response.write "3|已审批不能修改"
		response.end
	end if
	rs.close
	rs.Open "select * from creditor_right_allot where c_id="&id&" and status=0 order by id",conn,1,1
	do while not rs.eof
		conn.execute "update creditor_right set remaining_amount=remaining_amount+"&cdbl(rs("amount"))&" where id="&rs("cr_id")
	rs.movenext
	loop
	rs.close
	conn.execute "delete from creditor_right_allot where status=0 and c_id="&id
	if creditor_right_amount="1" then
		rs.Open "select isnull(remaining_amount,0),id from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 order by datediff(d,approval_date,'"&now()&"') desc",conn,1,1
		do while not rs.eof
			if rs(0)>=cdbl(capital) then
				isample=1
				creditor_right_id1=rs(1)
				exit do
			end if
		rs.movenext
		loop
		rs.close
	elseif creditor_right_amount="2" then
		rs.Open "select isnull(remaining_amount,0),id from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 order by datediff(d,approval_date,'"&now()&"') desc",conn,1,1
		do while not rs.eof
			set rs1=server.createobject("adodb.recordset")
			rs1.Open "select isnull(remaining_amount,0) as remaining_amount,(select count(id) from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 and id<>"&rs(1)&") as total,id from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 and id<>"&rs(1)&" order by datediff(d,approval_date,'"&now()&"') desc",conn,1,1
			if not rs1.eof then
				for i=1 to rs1(1)
					if cdbl(rs(0))+cdbl(rs1(0))>=cdbl(capital) then
						isample=1
						remaining_amount1=rs(0)
						remaining_amount2=rs1(0)
						creditor_right_id1=rs(1)
						creditor_right_id2=rs1(2)
						exit for
					end if
				next
			end if
			rs1.close
			set rs1=nothing
			if isample=1 then exit do
		rs.movenext
		loop
		rs.close
	else
		rs.Open "select isnull(sum(remaining_amount),0) from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0",conn,1,1
		if rs(0)>=cdbl(capital) then
			isample=1
		end if
		rs.close
	end if
	if isample=0 then
			response.write "3|根据所选匹配债权数计算，可匹配金额不足，无法完成债权分配。"
			response.end
	end if
	
	conn.execute "update contracts set number='"&o_number&"',cid="&cid&",passport='"&passport&"',full_name='"&full_name&"',product_name='"&product_name&"',cycle="&cycle&",profit="&profit&",capital="&capital&",start_date='"&start_date&"',edit_uid="&request.cookies("hhp2p_cookies")("uid")&",editdate='"&now()&"' where approval=0 and id="&id
	if creditor_right_amount="1" then
		rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
		if not rs.eof then
			conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&capital&")"
			creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
			rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
			capital=0
			rs.update
		end if
		rs.close
	elseif creditor_right_amount="2" then
		if cdbl(remaining_amount1)>=cdbl(capital) and cdbl(remaining_amount2)>=cdbl(capital) then
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&round(capital/2,2)&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&round(capital/2,2)
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(round(capital/2,2))
				capital=capital-round(capital/2,2)
				rs.update
			end if
			rs.close
			creditor_rights=creditor_rights&"/"
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id2,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&capital&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
				rs.update
			end if
			rs.close
		elseif cdbl(remaining_amount1)<cdbl(capital) then
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&rs("remaining_amount")&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&rs("remaining_amount")
				capital=cdbl(capital)-cdbl(rs("remaining_amount"))
				rs("remaining_amount")=0
				rs.update
			end if
			rs.close
			creditor_rights=creditor_rights&"/"
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id2,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&capital&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
				rs.update
			end if
			rs.close
		elseif cdbl(remaining_amount2)<cdbl(capital) then
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id2,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&rs("remaining_amount")&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&rs("remaining_amount")
				capital=cdbl(capital)-cdbl(rs("remaining_amount"))
				rs("remaining_amount")=0
				rs.update
			end if
			rs.close
			creditor_rights=creditor_rights&"/"
			rs.Open "select * from creditor_right where remaining_amount>0 and id="&creditor_right_id1,conn,1,3
			if not rs.eof then
				conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&capital&")"
				creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
				rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
				rs.update
			end if
			rs.close
		end if
	else
		rs.Open "select * from creditor_right where approval=1 and remaining_amount>0 and datediff(d,'"&now()&"',repayment_date)>0 order by datediff(d,approval_date,'"&now()&"') desc",conn,1,3
		do while not rs.eof
			if capital>0 then
				if creditor_rights<>"" then creditor_rights=creditor_rights&"/"
				if cdbl(rs("remaining_amount"))<=cdbl(capital) then
					conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&rs("remaining_amount")&")"
					creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&rs("remaining_amount")
					capital=cdbl(capital)-cdbl(rs("remaining_amount"))
					rs("remaining_amount")=0
					rs.update
				else
					conn.execute "insert into creditor_right_allot (c_id,cr_id,amount) VALUES ("&id&","&rs("id")&","&capital&")"
					creditor_rights=creditor_rights&rs("full_name")&";"&rs("passport")&";"&capital
					rs("remaining_amount")=cdbl(rs("remaining_amount"))-cdbl(capital)
					capital=0
					rs.update
				end if
			else
				exit do
			end if
		rs.movenext
		loop
		rs.close
	end if
	set rs=nothing
	response.write "0|"&creditor_rights
	response.end
elseif action="del" then	
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from creditor_right_allot where c_id="&id&" and status=0 order by id",conn,1,1
	do while not rs.eof
		conn.execute "update creditor_right set remaining_amount=remaining_amount+"&cdbl(rs("amount"))&" where id="&rs("cr_id")
	rs.movenext
	loop
	rs.close
	set rs=nothing
	conn.execute "delete from creditor_right_allot where status=0 and c_id="&id
	conn.execute "delete from contracts where approval=0 and id="&id
elseif action="approval" then	
	conn.execute "update contracts set approval=1,approval_uid="&request.cookies("hhp2p_cookies")("uid")&",approval_date='"&now()&"' where approval=0 and id="&id
	conn.execute "update creditor_right_allot set status=1 where status=0 and c_id="&id
elseif action="approvals" then	
	if ids<>"" then
		cid=Split(ids,",")
		for i=0 to Ubound(cid)
			conn.execute "update contracts set approval=1,approval_uid="&request.cookies("hhp2p_cookies")("uid")&",approval_date='"&now()&"' where approval=0 and id="&cid(i)
			conn.execute "update creditor_right_allot set status=1 where status=0 and c_id="&cid(i)
		next
	end if
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
