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
work_number=Trim(SafeRequest("work_number"))
work_name=Trim(SafeRequest("work_name"))
work_type=Trim(SafeRequest("work_type"))
mwork_start_time=Trim(SafeRequest("mwork_start_time"))
mwork_end_time=Trim(SafeRequest("mwork_end_time"))
mwork_start_date=Trim(SafeRequest("mwork_start_date"))
mwork_end_date=Trim(SafeRequest("mwork_end_date"))
mwork_cause_txt=Trim(SafeRequest("mwork_cause_txt"))

if action="add" then
	set rs=server.createobject("adodb.recordset")

	
	sql = "Select * from work_application_message"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("mwork_number")=work_number
	rs("mwork_name")=work_name
	rs("mwork_type")=work_type
	rs("mwork_start_time")=mwork_start_time
	rs("mwork_end_time")=mwork_end_time
	rs("mwork_start_date")=mwork_start_date
	rs("mwork_end_date")=mwork_end_date
	rs("mwork_cause_txt")=mwork_cause_txt
	rs.update
	rs.close
	set rs=nothing

end if

	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
