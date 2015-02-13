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
b_id=Trim(SafeRequest("b_id"))
b_min=Trim(SafeRequest("b_min"))
b_max=Trim(SafeRequest("b_max"))
b_ladder=Trim(SafeRequest("b_ladder"))
b_bscale=Trim(SafeRequest("b_bscale"))
special=Trim(SafeRequest("special"))
bid=Trim(SafeRequest("id"))


if action="add" then
	set rs=server.createobject("adodb.recordset")
	'rs.Open "select * from users where job_number='"&job_number&"'",conn,1,1
	'if rs.eof then
	''	response.write "1|product_name|不存在该员工"
	''	response.end
	'end if
	'rs.close

	'set rs=server.createobject("adodb.recordset")
	'riqi = rs.Open "select convert(datetime,convert(char(8),@dt,120)+'1')",conn,1,1
	'rs.close
	sql = "Select * from brokerage_section"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("job_id")=b_id
	rs("special")=special
	rs("bmin")=b_min
	rs("bmax")=b_max
	rs("bscale")=b_bscale/100
	rs("ladder")=b_ladder
	
	
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then


 conn.execute "update brokerage_section set bmin='"&b_min&"',bmax='"&b_max&"',bscale="&b_bscale/100&" where bid="&bid


elseif action="del" then	

	conn.execute "delete from brokerage_section where bid="&bid



end if	
	response.write "0|"
	response.end
else
response.write "非法提交!"
end if
%>