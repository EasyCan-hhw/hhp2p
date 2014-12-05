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
job_number=Trim(SafeRequest("job_number"))
username=Trim(SafeRequest("username"))
work_date=Trim(SafeRequest("work_date"))
start_time=Trim(SafeRequest("start_time"))
end_time=Trim(SafeRequest("end_time"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from users where job_number='"&job_number&"'",conn,1,1
	if rs.eof then
		response.write "1|product_name|不存在该员工"
		response.end
	end if
	rs.close
	sql = "Select * from work_attendance"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("job_number")=job_number
	rs("username")=username
	rs("work_date")=work_date
	rs("start_time")=start_time
	rs("end_time")=end_time
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	conn.execute "update products set product_name='"&product_name&"',cycle="&cycle&",base="&base&",profit="&profit/100&",penalty="&penalty/1000&" where id="&id
elseif action="del" then	
	conn.execute "delete from products where id="&id
end if
	response.write "0|"
	response.end
else
response.write "非法提交!"
end if
%>