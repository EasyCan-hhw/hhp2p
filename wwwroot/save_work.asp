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
work_id=Trim(SafeRequest("wid"))
work_tody=Trim(SafeRequest("work_tody"))
work_number=Trim(SafeRequest("work_number"))
work_name=Trim(SafeRequest("work_name"))
work_type=Trim(SafeRequest("work_type"))
'mwork_start_time=Trim(SafeRequest("mwork_start_time"))
'mwork_end_time=Trim(SafeRequest("mwork_end_time")) 
mwork_time_my=Trim(SafeRequest("mwork_time_my"))
mwork_start_date=Trim(SafeRequest("mwork_start_date"))
mwork_end_date=Trim(SafeRequest("mwork_end_date"))
mwork_cause_txt=Trim(SafeRequest("mwork_cause_txt"))

if action="add" then
	set rs=server.createobject("adodb.recordset")

			sql = "Select * from work_application_message"
			rs.Open sql,conn,1,3
			rs.addnew
			rs("mwork_tody")=work_tody
			rs("mwork_number")=work_number
			rs("mwork_name")=work_name
			rs("mwork_type")=work_type
			rs("mwork_time_my")=mwork_time_my
			rs("mwork_start_date")=mwork_start_date
			rs("mwork_end_date")=mwork_end_date
			rs("mwork_cause_txt")=mwork_cause_txt
			rs("approval")=0
			rs.update
			rs.close
			set rs=nothing
elseif action="approval" then	
	set rs=server.createobject("adodb.recordset")
	rs.Open "Select * from work_application_message where approval=0 and wid="&work_id,conn,1,1
	workDate=rs("mwork_time_my")
	rs.close
	set rs=nothing
	if workDate="" or workDate = "1900-01-01" or IsNull(workDate) then 

		if rs.eof then
			response.write "1|passport|不允许重复审批！"
			response.end
		else
			
			
			conn.execute "update work_application_message set approval=1,approval_uid="&request.cookies("hhp2p_cookies")("uid")&",approval_date='"&now()&"' where approval=0 and wid="&work_id
			
		end if
		
	else
		set rs=server.createobject("adodb.recordset")
			sql = "Select * from work_attendance"
			rs.Open sql,conn,1,3
				rs.addnew
				rs("job_number")=request.cookies("hhp2p_cookies")("job_number")
				rs("username")=request.cookies("hhp2p_cookies")("username")
				rs("work_date")=workDate
				rs("start_time")=540
				rs("end_time")=1050
				rs.update
				rs.close
				set rs=nothing
			conn.execute "update work_application_message set approval=1,approval_uid="&request.cookies("hhp2p_cookies")("uid")&",approval_date='"&now()&"' where approval=0 and wid="&work_id
	end if
	
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
