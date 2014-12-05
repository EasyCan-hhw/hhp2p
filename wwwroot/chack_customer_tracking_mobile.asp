<!--#include file="config.asp" -->
<%

server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))


if Request.Servervariables("REQUEST_METHOD")="POST" then

if request.cookies("hhp2p_cookies")("uid")="" then
	response.write "2|"
	response.end
end if

mobile=Trim(SafeRequest("mobile"))

	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from target_customers where mobile='"&mobile&"'",conn,1,1
	if not rs.eof then
		response.write "1|mobile|手机号已存在"
	else
		response.write "0|"
	end if
	rs.close
	set rs=nothing
else
response.write "非法提交!"
end if
%>
