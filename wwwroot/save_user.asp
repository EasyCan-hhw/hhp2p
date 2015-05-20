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

cookqx =  request.cookies("hhp2p_cookies")("quanxian")'得到登陆账号的权限'
splitvalue = split(cookqx,",") '得到权限object'
splitlength = ubound(splitvalue)'得到权限count'
qxBoolean = false

action=SafeRequest("action")
username=Trim(SafeRequest("username"))'用户名'
password=Trim(SafeRequest("password"))'密码'
job_number=Trim(SafeRequest("job_number"))'工号'
full_name=Trim(SafeRequest("full_name"))'姓名'
user_code=Trim(SafeRequest("user_code"))'员工状态
company_id=Trim(SafeRequest("company_id"))'公司名称id'
company_code=Trim(SafeRequest("company_porportion"))'下属公司代码  
job_id=Trim(SafeRequest("job_id"))'职位'
lead_user=Trim(SafeRequest("lead_user"))'上级'
tel=Trim(SafeRequest("tel"))'D电话'
qq=Trim(SafeRequest("qq"))'QQ'
email=Trim(SafeRequest("email"))'email'
insurance=Trim(SafeRequest("checked_insurance"))'保险'
quanxian=Trim(SafeRequest("quanxian"))'权限'
ifshow=Trim(SafeRequest("ifshow"))
entry_date=Trim(SafeRequest("entry_date"))'入职时间
'inputdate=Trim(SafeRequest("inputdate"))
census_register=Trim(SafeRequest("census_register"))'户籍'
add_gold=Trim(SafeRequest("add_gold"))'加金'
id=Trim(SafeRequest("id"))'用户登陆名'
add_meal=Trim(SafeRequest("add_meal"))'餐补'
company_name=Trim(SafeRequest("companyVal"))
if action="add" then
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from users where username='"&username&"'",conn,1,1
	if not rs.eof then
		response.write "1|username|用户名已存在"+"select * from users where username='"&username&"'"
		response.end
	end if
	rs.close
	rs.Open "select * from users where job_number='"&job_number&"'",conn,1,1
	if not rs.eof then
		response.write "1|job_number|工号已存在"
		response.end
	end if
	rs.close
	sql = "Select * from users"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("username")=username
	rs("password")=md5("123456")
	rs("full_name")=full_name
	rs("user_code")=user_code
	rs("company_id")=company_id
	rs("job_number")=job_number
	rs("job_id")=job_id
	rs("lead_user")=lead_user
	rs("tel")=tel
	rs("qq")=qq
	rs("company_code")=company_code
	rs("email")=email
	rs("add_insurance")=insurance
	rs("quanxian")=quanxian
	rs("entry_date")=entry_date
	rs("inputdate")=now()
	rs("add_meal")=add_meal
	rs.update
	rs.close
	set rs=nothing
elseif action="edit" then
	'response.write add_meal&"--"&insurance
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from users where job_number='"&job_number&"' and uid<>"&id,conn,1,1
	if not rs.eof then
		response.write "1|job_number|工号已存在"
		response.end
	end if
	rs.close
	if password<>"" then mpassword=",password='"&md5(password)&"'"
	if company_code<>"" then mcompany_code=",company_code='"&company_code&"'"
	if insurance<>"" then set_insurance=",add_insurance='"&insurance&"'"
	'response.write "update users set job_number='"&job_number&"',lead_user="&lead_user&",full_name='"&full_name&"',company_id="&company_id&",job_id="&job_id&",tel='"&tel&"',qq='"&qq&"',email='"&email&"',quanxian='"&quanxian&"'"&mpassword&", inputdate="&entry_date&", add_insurance="&insurance&" where uid="&id
 	for s=0 to splitlength 
         if splitvalue(s)="[29]" then 
         	qxBoolean = true
                  exit for 
         else 
         end if 
    next
    if qxBoolean then
    	conn.execute "update users set job_number='"&job_number&"',lead_user='"&lead_user&"',full_name='"&full_name&"',user_code="&user_code&",company_id="&company_id&",job_id="&job_id&",tel='"&tel&"',qq='"&qq&"',email='"&email&"',quanxian='"&quanxian&"'"&mpassword&""&mcompany_code&",entry_date='"&entry_date&"', inputdate='"&now()&"'"&set_insurance&",add_meal='"&add_meal&"' where uid="&id
    else 
    	conn.execute "update users set job_number='"&job_number&"',lead_user='"&lead_user&"',full_name='"&full_name&"',user_code="&user_code&",company_id="&company_id&",job_id="&job_id&",tel='"&tel&"',qq='"&qq&"',email='"&email&"'"&mpassword&""&mcompany_code&", inputdate='"&now()&"',entry_date='"&entry_date&"'"&set_insurance&",add_meal='"&add_meal&"' where uid="&id
    end if 


elseif action="Invalid" then
		conn.execute "update users set ifshow=1 where uid="&id
elseif action="Enable" then
		conn.execute "update users set ifshow=0 where uid="&id
elseif action="del" then
		conn.execute "delete from users where uid="&id
elseif action="sele" then 
	
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
