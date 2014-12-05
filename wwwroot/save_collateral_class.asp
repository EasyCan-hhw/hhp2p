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
collateral_class_name=Trim(SafeRequest("collateral_class_name"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from collateral_class where collateral_class_name='"&collateral_class_name&"'",conn,1,1
	if not rs.eof then
		response.write "1|collateral_class_name|分债权分类名称已存在"
		response.end
	end if
	rs.close
	sql = "Select * from collateral_class"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("collateral_class_name")=collateral_class_name
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from collateral_class where collateral_class_name='"&collateral_class_name&"' and id<>"&id,conn,1,1
	if not rs.eof then
		response.write "1|collateral_class_name|债权分类名称已存在"
		response.end
	end if
	rs.close
	conn.execute "update collateral_class set collateral_class_name='"&collateral_class_name&"' where id="&id
elseif action="del" then	
	conn.execute "delete from collateral_class where id="&id
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
