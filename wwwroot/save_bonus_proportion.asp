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
bonus_proportion=Trim(SafeRequest("bonus_proportion"))

if action="user" then
	conn.execute "update users set bonus_proportion="&bonus_proportion/100&" where uid="&id
elseif action="jobs" then
	conn.execute "update jobs set bonus_proportion="&bonus_proportion/100&" where id="&id
elseif action="companys" then
	conn.execute "update companys set bonus_proportion="&bonus_proportion/100&" where id="&id
end if
	response.write "0|"
	response.end

'else
'response.write "非法提交!"
'end if
%>
