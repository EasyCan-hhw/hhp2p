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
username=Trim(SafeRequest("username"))
password=Trim(SafeRequest("password"))
job_number=Trim(SafeRequest("job_number"))
full_name=Trim(SafeRequest("full_name"))
company_id=Trim(SafeRequest("company_id"))
job_id=Trim(SafeRequest("job_id"))
tel=Trim(SafeRequest("tel"))
qq=Trim(SafeRequest("qq"))
email=Trim(SafeRequest("email"))
quanxian=Trim(SafeRequest("quanxian"))
ifshow=Trim(SafeRequest("ifshow"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from users where username='"&username&"'",conn,1,1
	if not rs.eof then
		response.write "1|username|用户名已存在"
		response.end
	end if
	rs.close
	rs.Open "select * from users where job_number='"&job_number&"'",conn,1,1
	if not rs.eof then
		response.write "1|job_number|工号已存在"
		response.end
	end if
	rs.close
	sql = "Select * from users"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("username")=username
	rs("password")=md5("123456")
	rs("full_name")=full_name
	rs("company_id")=company_id
	rs("job_id")=job_id
	rs("tel")=tel
	rs("qq")=qq
	rs("email")=email
	rs("quanxian")=quanxian
	rs("inputdate")=now()
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
	conn.execute "delete from users where uid="&id
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
