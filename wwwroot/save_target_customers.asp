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
full_name=Trim(SafeRequest("full_name"))
mobile=Trim(SafeRequest("mobile"))
custome_source=Trim(SafeRequest("custome_source"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from target_customers where mobile='"&mobile&"'",conn,1,1
	if not rs.eof then
		response.write "1|mobile|手机号已存在"
		response.end
	end if
	rs.close
	sql = "Select * from target_customers"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("full_name")=full_name
	rs("mobile")=mobile
	rs("custome_source")=custome_source
	rs("add_uid")=request.cookies("hhp2p_cookies")("uid")
	rs("add_date")=now()
	rs.update
	rs.close
	set rs=nothing
elseif action="follow_up" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from target_customers where add_uid="&request.cookies("hhp2p_cookies")("uid")&" and id="&id,conn,1,1
	if not rs.eof then
		conn.execute "update target_customers set follow_up_uid="&request.cookies("hhp2p_cookies")("uid")&",follow_up_date='"&now()&"' where id="&id
	else
		response.write "1||您不是该客户的业务员，不能跟踪！"
		response.end
	end if
elseif action="transfer" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from target_customers where datediff(d,add_date,'"&now()&"')>30 and id="&id,conn,1,1
	if not rs.eof then
		conn.execute "update target_customers set add_uid="&request.cookies("hhp2p_cookies")("uid")&",add_date='"&now()&"',follow_up_uid=NULL,follow_up_date=NULL where id="&id
	else
		response.write "1||没有超过30天，不能转移客户！"
		response.end
	end if
	rs.close
	set rs=nothing
elseif action="del" then	
	conn.execute "delete from target_customers where id="&id
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
