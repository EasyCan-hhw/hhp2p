<!--#include file="config.asp" -->
<%

server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))


'if Request.Servervariables("REQUEST_METHOD")="POST" then

if request.cookies("hhp2p_cookies")("uid")="" then
	response.write "2|"
	response.end
end if

action=SafeRequest("action")
ids=Trim(SafeRequest("ids"))

Function approval(my_id)
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from contracts where redeem=1 and approval_redeem=0 and id="&my_id,conn,1,3
	if not rs.eof then
		if datediff("d",rs("start_date"),now())<30 then
			periods=1
		else
			if (datediff("d",rs("start_date"),now())/30)=int(datediff("d",rs("start_date"),now())/30) then

				periods=datediff("d",rs("start_date"),now())/30

			else

				periods=int(datediff("d",rs("start_date"),now())/30)+1

			end if
		end if
		if periods>1 then
			periods_start_date=DateAdd("d",(periods-1)*30+1, rs("start_date"))
		else
			periods_start_date=rs("start_date")
		end if
		
		set rs1=server.CreateObject("adodb.recordset")
		rs1.Open "select penalty from products where product_name='"&rs("product_name")&"'",conn,1,1
		if not rs1.eof then
			penalty=cdbl(rs1("penalty"))*cdbl(rs("capital"))
		end if
		rs1.close
		set rs1=nothing
		accrual=round(cdbl(rs("capital"))*(cdbl(rs("profit"))/365)*datediff("d",periods_start_date,now())-cdbl(penalty),2)
		Set db=Conn.execute("select sum(accrual) As db from monthly_bill where c_id="&rs("id"))
		if db("db")>0 then
			grand_total=cdbl(rs("capital"))+cdbl(db("db"))+cdbl(accrual)
		else
			grand_total=cdbl(rs("capital"))+cdbl(accrual)
		end if
		conn.execute "insert into monthly_bill (number,cid,passport,full_name,product_name,cycle,profit,capital,start_date,c_id,periods,periods_start_date,periods_end_date,grand_total,accrual,redeem,inputdate) VALUES ('"&rs("number")&"',"&rs("cid")&",'"&rs("passport")&"','"&rs("full_name")&"','"&rs("product_name")&"',"&rs("cycle")&","&rs("profit")&","&rs("capital")&",'"&rs("start_date")&"',"&rs("id")&","&periods&",'"&periods_start_date&"','"&DateAdd("d",30, periods_start_date)&"',"&grand_total&","&accrual&",1,'"&now()&"')"
		rs("approval_redeem")=1
		rs("approval_redeem_uid")=request.cookies("hhp2p_cookies")("uid")
		rs("approval_redeem_date")=now()
		rs.update
	end if
	rs.close
	rs.Open "select * from creditor_right_allot where c_id="&my_id&" and status=0 order by id",conn,1,3
	do while not rs.eof
		conn.execute "update creditor_right set remaining_amount=remaining_amount+"&cdbl(rs("amount"))&" where id="&rs("cr_id")
		rs("status")=1
		rs.update
	rs.movenext
	loop
	rs.close
	set rs=nothing
end Function

if action="redeem" then
	conn.execute "update contracts set redeem=1,redeem_date='"&now()&"' where approval=1 and id="&id
elseif action="redeems" then	
	if ids<>"" then
		cid=Split(ids,",")
		for i=0 to Ubound(cid)
			conn.execute "update contracts set redeem=1,redeem_date='"&now()&"' where approval=1 and id="&cid(i)
		next
	end if
elseif action="cancel_redeem" then
	conn.execute "update contracts set redeem=0 where redeem=1 and id="&id
elseif action="cancel_redeems" then
	if ids<>"" then
		cid=Split(ids,",")
		for i=0 to Ubound(cid)
			conn.execute "update contracts set redeem=0 where redeem=1 and id="&cid(i)
		next
	end if
elseif action="approval" then	
	call approval(id)
elseif action="approvals" then	
	if ids<>"" then
		cid=Split(ids,",")
		for i=0 to Ubound(cid)
			call approval(cid(i))
		next
	end if
end if
	response.write "0|"
	response.end

'else
'response.write "非法提交!"
'end if
%>
