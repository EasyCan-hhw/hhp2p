<!--#include file="config.asp" -->
<!--#include file="md5.asp" -->
<%

server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
if Request.Servervariables("REQUEST_METHOD")="POST" then



username=Trim(SafeRequest("username"))
password=md5(Trim(SafeRequest("password")))
'remember=Trim(SafeRequest("remember"))

'getcode=cstr(session("login_getcode"))
'if getcode<>cstr(trim(request("login_ycode"))) Then
'	response.write "1|login_ycode|验证码错误"
'	response.end
'else
	set rs=server.createobject("adodb.recordset")
	sql = "Select * from users where username='"&username&"' and password='"&password&"'"
	rs.Open sql,conn,1,1
	if rs.eof then
		response.write "1|username|用户名或密码错误"
	elseif rs("ifshow")=1 then
		response.write "1|username|该用户被冻结"
	else
		response.cookies("hhp2p_cookies")("uid")=rs("uid")
		response.cookies("hhp2p_cookies")("username")=rs("username")
		response.cookies("hhp2p_cookies")("quanxian")=rs("quanxian")
		response.cookies("hhp2p_cookies")("full_name")=rs("full_name")
		response.cookies("hhp2p_cookies")("job_number")=rs("job_number")
		response.cookies("hhp2p_cookies")("job_id")=rs("job_id")
		response.cookies("hhp2p_cookies")("company_id")=rs("company_id")
		response.write "0|index.asp"
	end if
	rs.close
	set rs=nothing
	response.end
'end if

else
response.write "非法提交!"
end if
%>
