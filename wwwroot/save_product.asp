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
product_name=Trim(SafeRequest("product_name"))
cycle=Trim(SafeRequest("cycle"))
base=Trim(SafeRequest("base"))
profit=Trim(SafeRequest("profit"))
penalty=Trim(SafeRequest("penalty"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from products where product_name='"&product_name&"'",conn,1,1
	if not rs.eof then
		response.write "1|product_name|产品名称已存在"
		response.end
	end if
	rs.close
	sql = "Select * from products"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("product_name")=product_name
	rs("cycle")=cycle
	rs("base")=base
	rs("profit")=profit/100
	rs("penalty")=penalty/1000
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
