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
company_code=Trim(SafeRequest("company_code"))
company_name=Trim(SafeRequest("company_name"))
company_count=Trim(SafeRequest("company_count"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from companys where company_code='"&company_code&"'",conn,1,1
	if not rs.eof then
		response.write "1|company_code|分公司代码已存在"
		response.end
	end if
	rs.close
	rs.Open "select * from companys where company_name='"&company_name&"'",conn,1,1
	if not rs.eof then
		response.write "1|company_name|分公司名称已存在"
		response.end
	end if
	rs.close
	sql = "Select * from companys"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("company_code")=company_code
	rs("company_name")=company_name
	rs("company_count")=company_count
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from companys where company_code='"&company_code&"' and id<>"&id,conn,1,1
	if not rs.eof then
		response.write "1|company_code|分公司代码已存在"
		response.end
	end if
	rs.close
	rs.Open "select * from companys where company_name='"&company_name&"' and id<>"&id,conn,1,1
	if not rs.eof then
		response.write "1|company_name|分公司名称已存在"
		response.end
	end if
	rs.close
	conn.execute "update companys set company_code='"&company_code&"',company_name='"&company_name&"',company_count='"&company_count&"' where id="&id
elseif action="del" then	
	conn.execute "delete from companys where id="&id
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
