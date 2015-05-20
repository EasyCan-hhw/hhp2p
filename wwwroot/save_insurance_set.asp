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
	insurance_name=SafeRequest("insurance_name")
	insurance_money=Trim(SafeRequest("insurance_money"))
	insurance_company=Trim(SafeRequest("insurance_company"))
	id=Trim(SafeRequest("id"))

	if action="add" then
	response.write insurance_name&"-"&insurance_money&"-"&insurance_company
		set rs=server.createobject("adodb.recordset")
		sql = "Select * from insurance_set"
		rs.Open sql,conn,1,3
		rs.addnew
		rs("insurance_name")=insurance_name
		rs("insurance_money")=insurance_money
		rs("insurance_company")=insurance_company
		rs.update
		rs.close
		set rs=nothing

	elseif action="edit" then

	 	conn.execute "update insurance_set set insurance_name='"&insurance_name&"',insurance_money='"&insurance_money&"',insurance_company="&insurance_company&" where iid="&id

	elseif action="del" then

		conn.execute "delete from insurance_set where iid="&id

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