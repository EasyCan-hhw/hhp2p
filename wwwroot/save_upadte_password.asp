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
		inputPassword=trim(SafeRequest("inputPassword"))
		response.write "123321213213"
		response.end

		if inputPassword == "092036" then 
			response.write "0|"&inputPassword
			response.end
		else 
			response.write "not input"
			response.end
		end if 
	else
		response.write "非法提交!"

	end if 


%>