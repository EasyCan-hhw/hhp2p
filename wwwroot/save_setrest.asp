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
setrest_year=Trim(SafeRequest("setrest_year"))
setrest_starttime=Trim(SafeRequest("setrest_starttime"))
setrest_endtime=Trim(SafeRequest("setrest_endtime"))
setrest_cause=Trim(SafeRequest("setrest_cause"))
sid=Trim(SafeRequest("sid"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from setrest_worktime where setrest_year='"&setrest_year&"'",conn,1,1
	if not rs.eof then
		response.write "1|setrest_year|该日期已存在"
		response.end
	end if
	rs.close
	sql = "Select * from setrest_worktime"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("setrest_year")=setrest_year
	rs("start_worktime")=setrest_starttime
	rs("end_worktime")=setrest_endtime
	rs("setrest_cause")=setrest_cause
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	conn.execute "update jobs set job_name='"&job_name&"',position_id='"&position_id&"',base_pay="&base_pay&",least_money="&least_money&",month_money="&month_money&" where id="&id
elseif action="del" then
	conn.execute "delete from setrest_worktime where sid="&sid
end if
	response.write "0|"
	response.end
else
response.write "非法提交!"
end if
%>
