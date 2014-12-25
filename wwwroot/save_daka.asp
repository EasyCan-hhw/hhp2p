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
myvalue=Trim(SafeRequest("myvalue"))
job_number=Trim(SafeRequest("job_number"))
username=Trim(SafeRequest("username"))
work_date=Trim(SafeRequest("work_date"))
start_time=Trim(SafeRequest("start_time"))
end_time=Trim(SafeRequest("end_time"))
work_id=Trim(SafeRequest("work_id"))
j_number=Trim(SafeRequest("j_number"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from users where job_number='"&job_number&"'",conn,1,1
	if rs.eof then
		response.write "1|product_name|不存在该员工"
		response.end
	end if
	rs.close

	'set rs=server.createobject("adodb.recordset")
	'riqi = rs.Open "select convert(datetime,convert(char(8),@dt,120)+'1')",conn,1,1
	'rs.close
	sql = "Select * from work_attendance"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("job_number")=job_number
	rs("username")=username
	rs("work_date")=work_date
	rs("start_time")=start_time
	rs("end_time")=end_time
	rs("test")=riqi
	
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	

 conn.execute "update work_attendance set username='"&username&"',work_date='"&work_date&"',start_time="&start_time&",end_time="&end_time&" where work_id="&work_id


elseif action="del" then	

	conn.execute "delete from work_attendance where work_id="&work_id


elseif action="sele" then
	set rs1=server.createobject("adodb.recordset")
	rs1.Open "select * from users where job_number='"&myvalue&"'",conn,1,1
	if rs1.eof then
		response.write "1|product_name|不存在该员工"
		response.end
	end if
	rs1.close
	
	rs1.Open "Select * from work_attendance where job_number='"&myvalue&"'",conn,1,1
	
	response.write "0|username|"&rs1("username")&""
	rs1.close
	set rs1=nothing
end if	
	response.write "0|uname|"&name&""
	response.end
else
response.write "非法提交!"
end if
%>