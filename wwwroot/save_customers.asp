<!--#include file="config.asp" -->
<!--#include file="md5.asp" -->
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
sex=Trim(SafeRequest("sex"))
birth_date=Trim(SafeRequest("birth_date"))
passport=Trim(SafeRequest("passport"))
lssue_date=Trim(SafeRequest("lssue_date"))
expiry_date=Trim(SafeRequest("expiry_date"))
marital=Trim(SafeRequest("marital"))
mobile=Trim(SafeRequest("mobile"))
city=Trim(SafeRequest("city"))
industry=Trim(SafeRequest("industry"))
postcodes=Trim(SafeRequest("postcodes"))
email=Trim(SafeRequest("email"))
address=Trim(SafeRequest("address"))
bank_info=Trim(SafeRequest("bank_info"))
bank_account=Trim(SafeRequest("bank_account"))
notify=Trim(SafeRequest("notify"))
remarks=Trim(SafeRequest("remarks"))
emergency_name=Trim(SafeRequest("emergency_name"))
emergency_title=Trim(SafeRequest("emergency_title"))
emergency_sex=Trim(SafeRequest("emergency_sex"))
emergency_birth_date=Trim(SafeRequest("emergency_birth_date"))
emergency_passport=Trim(SafeRequest("emergency_passport"))
emergency_mobile=Trim(SafeRequest("emergency_mobile"))
emergency_tel=Trim(SafeRequest("emergency_tel"))
emergency_email=Trim(SafeRequest("emergency_email"))
emergency_address=Trim(SafeRequest("emergency_address"))
custome_source=Trim(SafeRequest("custome_source"))
channel_name=Trim(SafeRequest("channel_name"))
recommend=Trim(SafeRequest("recommend"))

if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from customers where passport='"&passport&"'",conn,1,1
	if not rs.eof then
		response.write "1|passport|身份证号已存在"
		response.end
	end if
	rs.close
	sql = "Select * from customers"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("full_name")=full_name
	rs("sex")=sex
	rs("birth_date")=birth_date
	rs("passport")=passport
	rs("lssue_date")=lssue_date
	rs("expiry_date")=expiry_date
	rs("marital")=marital
	rs("mobile")=mobile
	rs("city")=city
	rs("industry")=industry
	rs("postcodes")=postcodes
	rs("email")=email
	rs("address")=address
	rs("bank_info")=bank_info
	rs("bank_account")=bank_account
	rs("notify")=notify
	rs("remarks")=remarks
	rs("emergency_name")=emergency_name
	rs("emergency_title")=emergency_title
	rs("emergency_sex")=emergency_sex
	rs("emergency_birth_date")=emergency_birth_date
	rs("emergency_passport")=emergency_passport
	rs("emergency_mobile")=emergency_mobile
	rs("emergency_tel")=emergency_tel
	rs("emergency_email")=emergency_email
	rs("emergency_address")=emergency_address
	rs("custome_source")=custome_source
	rs("channel_name")=channel_name
	rs("recommend")=recommend
	rs("uid")=request.cookies("hhp2p_cookies")("uid")
	rs("inputdate")=now()
	rs("password")=md5(right(passport,6))
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	conn.execute "update customers set full_name='"&full_name&"',sex="&sex&",birth_date='"&birth_date&"',passport='"&passport&"',lssue_date='"&lssue_date&"',expiry_date='"&expiry_date&"',marital="&marital&",mobile='"&mobile&"',city='"&city&"',industry='"&industry&"',postcodes='"&postcodes&"',email='"&email&"',address='"&address&"',bank_info='"&bank_info&"',bank_account='"&bank_account&"',notify="&notify&",remarks='"&remarks&"',emergency_name='"&emergency_name&"',emergency_title='"&emergency_title&"',emergency_sex="&emergency_sex&",emergency_birth_date='"&emergency_birth_date&"',emergency_passport='"&emergency_passport&"',emergency_mobile='"&emergency_mobile&"',emergency_tel='"&emergency_tel&"',emergency_email='"&emergency_email&"',emergency_address='"&emergency_address&"',custome_source='"&custome_source&"',channel_name='"&channel_name&"',recommend='"&recommend&"' where id="&id
elseif action="del" then	
 	
 	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from contracts where cid='"&id&"'",conn,1,1
	if  rs.eof then 
	conn.execute "delete from customers where id="&id
	else 
	response.write "3|客户已有理财产品不允许删除"
	end if 
end if
	response.write "0|"
	response.end
else
response.write "非法提交!"
end if
%>
