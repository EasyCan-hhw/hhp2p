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
	Cjob_number=Trim(SafeRequest("Cjob_number"))
	Cmdate=Trim(SafeRequest("Cmdate"))
	Cjixiao=Trim(SafeRequest("Cjixiao"))
	Cchargehand=Trim(SafeRequest("Cchargehand"))
	cid=Trim(SafeRequest("id"))
	Cjixiao=Trim(SafeRequest("Cjixiao"))
	Cchargehand=Trim(SafeRequest("Cchargehand"))

	if action="add" then
		set rs=server.createobject("adodb.recordset")
		rs.Open "select * from users where job_number="&Cjob_number&" ",conn,1,1
		if rs.eof then
			response.write "1|product_name|不存在该员工"
			response.end
		end if
		rs.close
		rs.Open "select * from Commission_manage where Cjob_number="&Cjob_number&" and Cdate='"&Cmdate&"' ",conn,1,1
		if  not rs.eof then 
		response.write "1|product_name|该员工本月奖金已添加"
			response.end
		end if 
		rs.close

		sql = "Select * from Commission_manage"
		rs.Open sql,conn,1,3
		rs.addnew
		rs("Cjob_number")=Cjob_number
		rs("Cdate")=Cmdate
		rs("Cjixiao")=Cjixiao
		rs("Cchargehand")=Cchargehand
		rs.update
		rs.close
		set rs=nothing

	elseif action="edit" then

	 	conn.execute "update Commission_manage set Cchargehand='"&Cchargehand&"',Cjixiao='"&Cjixiao&"' where cid="&cid

	elseif action="del" then

		conn.execute "delete from Commission_manage where cid="&cid

	elseif action ="sele" then
		
		set rs1=server.createobject("adodb.recordset")
		rs1.Open "select * from users where job_number='"&myvalue&"'",conn,1,1

		if rs1.eof then
			response.write "3|不存在该员工"
			response.end
		else
			response.write "4|"+rs1("full_name")
			response.end
		end if
		rs1.close
		set rs1=nothing
	end if	

	response.write "0|"
	response.end
else
	response.write "非法提交!"
end if
%>