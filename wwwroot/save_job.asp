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
job_name=Trim(SafeRequest("job_name"))
quanxian=Trim(SafeRequest("quanxian"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from jobs where job_name='"&job_name&"'",conn,1,1
	if not rs.eof then
		response.write "1|job_name|职位名称已存在"
		response.end
	end if
	rs.close
	sql = "Select * from jobs"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("job_name")=job_name
	rs("quanxian")=quanxian
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	conn.execute "update jobs set job_name='"&job_name&"',quanxian='"&quanxian&"' where id="&id
elseif action="del" then	
	conn.execute "delete from jobs where id="&id
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>