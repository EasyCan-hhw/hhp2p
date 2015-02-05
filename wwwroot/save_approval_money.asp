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
approval_name=Trim(SafeRequest("approval_name"))
approval_photo=Trim(SafeRequest("approval_photo"))
approval_money_text=Trim(SafeRequest("approval_money_text"))
aid=Trim(SafeRequest("id"))

if action="add" then
	
	set rs=server.createobject("adodb.recordset")
	'rs.Open "select * from customers where passport='"&passport&"'",conn,1,1
	'if not rs.eof then
		'response.write "1|passport|身份证号已存在"
		'response.end
	'end if
	'rs.close
	sql = "Select * from request_photo"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("request_photo")=approval_photo
	rs("request_text")=approval_money_text
	rs("request_date")=now
	rs("request_name")=approval_name
	rs("approval_request")=0
	rs.update 
	response.write "0|提交"
	rs.close
	set rs=nothing
	
	response.end
	
		
elseif action="edit" then
	conn.execute "update creditor_right set full_name='"&full_name&"',passport='"&passport&"',job='"&job&"',collateral='"&collateral&"',collateral_value="&collateral_value&",creditor_right_value="&creditor_right_value&",repayment_date='"&repayment_date&"',edit_uid="&request.cookies("hhp2p_cookies")("uid")&",editdate='"&now()&"',collateral_class_id="&split(collateral_class,"|")(0)&",collateral_class_name='"&split(collateral_class,"|")(1)&"' where approval=0 and id="&id
	conn.execute "delete from upload_files where table_name='creditor_right' and cid="&id
	if property_card<>"" then
		property_cards=split(property_card,",")
		for i=0 to ubound(property_cards)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&property_cards(i)&"','property_card','creditor_right',"&id&")"
		next
	end if
	if passport_img<>"" then
		passport_imgs=split(passport_img,",")
		for i=0 to ubound(passport_imgs)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&passport_imgs(i)&"','passport_img','creditor_right',"&id&")"
		next
	end if
	if notarization<>"" then
		notarizations=split(notarization,",")
		for i=0 to ubound(notarizations)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&notarizations(i)&"','notarization','creditor_right',"&id&")"
		next
	end if
	if IOU_receipt<>"" then
		IOU_receipts=split(IOU_receipt,",")
		for i=0 to ubound(IOU_receipts)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&IOU_receipts(i)&"','IOU_receipt','creditor_right',"&id&")"
		next
	end if
	if contract<>"" then
		contracts=split(contract,",")
		for i=0 to ubound(contracts)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&contracts(i)&"','contract','creditor_right',"&id&")"
		next
	end if
	if other_evidence<>"" then
		other_evidences=split(other_evidence,",")
		for i=0 to ubound(other_evidences)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&other_evidences(i)&"','other_evidence','creditor_right',"&id&")"
		next
	end if	
	if other_other<>"" then
		other_otheres=split(other_other,",")
		for i=0 to ubound(other_otheres)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&other_otheres(i)&"','other_other','creditor_right',"&id&")"
		next
	end if	
elseif action="del" then	
	set rs=server.createobject("adodb.recordset")
	rs.Open "Select * from creditor_right where approval=0 and id="&id,conn,1,1
	if not rs.eof then
	conn.execute "delete from creditor_right where approval=0 and id="&id
	conn.execute "delete from upload_files where table_name='creditor_right' and cid="&id
	end if
	rs.close
	set rs=nothing
elseif action="approval" then	
	conn.execute "update request_photo set approval_request=1,approval_users="&request.cookies("hhp2p_cookies")("uid")&",approval_date='"&now()&"' where approval_request=0 and aid="&aid
elseif action="approvals" then	
	if ids<>"" then
		cid=Split(ids,",")
		for i=0 to Ubound(cid)
			conn.execute "update creditor_right set approval=1,approval_uid="&request.cookies("hhp2p_cookies")("uid")&",approval_date='"&now()&"',remaining_amount=creditor_right_value where approval=0 and id="&cid(i)
		next
	end if
end if
	response.write "0|"
	response.end

else
response.write "非法提交!"
end if
%>
