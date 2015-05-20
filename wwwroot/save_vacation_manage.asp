<!--#include file="config.asp" -->
<!--#include file="md5.asp" -->
<%

server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))


if Request.Servervariables("REQUEST_METHOD")="POST" then

if request.cookies("hhp2p_cookies")("uid")="" then
	response.write "2|"
	response.end
end if

action=SafeRequest("action")
vid=Trim(SafeRequest("vid"))
vacation_date=Trim(SafeRequest("vacation_date"))
vacation_type=Trim(SafeRequest("vacation_type"))
vacation_cause=Trim(SafeRequest("vacation_cause"))
company_number=Trim(SafeRequest("company_number"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	'rs.Open "select * from vacation_manage where vacation_date='"&vacation_date&"'",conn,1,1
	'if not rs.eof then
	''	response.write "1|vacation_date| 日期已存在"
	''	response.end
	'end if 
	'rs.close
	sql = "Select * from vacation_manage"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("vacation_date")=vacation_date
	rs("vacation_type")=vacation_type
	rs("vacation_cause")=vacation_cause
	rs("company_number")=company_number
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from users where job_number='"&job_number&"' and uid<>"&id,conn,1,1
	if not rs.eof then
		response.write "1|job_number|工号已存在"
		response.end
	end if
	rs.close
	if password<>"" then password=",password='"&md5(password)&"'"
	conn.execute "update users set job_number='"&job_number&"',full_name='"&full_name&"',company_id="&company_id&",job_id="&job_id&",tel='"&tel&"',qq='"&qq&"',email='"&email&"',quanxian='"&quanxian&"'"&password&" where uid="&id
elseif action="Invalid" then
	conn.execute "update users set ifshow=1 where uid="&id
elseif action="Enable" then
	conn.execute "update users set ifshow=0 where uid="&id
elseif action="del" then	
	conn.execute "delete from vacation_manage where vid="&vid
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
