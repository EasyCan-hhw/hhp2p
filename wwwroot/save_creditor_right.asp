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
passport=Trim(SafeRequest("passport"))
job=Trim(SafeRequest("job"))
collateral=Trim(SafeRequest("collateral"))
collateral_value=Trim(SafeRequest("collateral_value"))
creditor_right_value=Trim(SafeRequest("creditor_right_value"))
repayment_date=Trim(SafeRequest("repayment_date"))
advance_pay=Trim(SafeRequest("advance_pay"))

month_pay = Trim(SafeRequest("month_pay"))

passport_img=Trim(SafeRequest("passport_img"))
property_card=Trim(SafeRequest("property_card"))
notarization=Trim(SafeRequest("notarization"))
IOU_receipt=Trim(SafeRequest("IOU_receipt"))
contract=Trim(SafeRequest("contract"))
other_evidence=Trim(SafeRequest("other_evidence"))
other_other = Trim(SafeRequest("other_other"))
ids=Trim(SafeRequest("ids"))
collateral_class=Trim(SafeRequest("collateral_class"))

if action="add" then
	
	set rs=server.createobject("adodb.recordset")
	rs.Open "select * from customers where passport='"&passport&"'",conn,1,1
	if not rs.eof then
		response.write "1|passport|身份证号已存在"
		response.end
	end if
	rs.close
	sql = "Select * from creditor_right"
	rs.Open sql,conn,1,3
	rs.addnew
	rs("full_name")=full_name
	rs("passport")=passport
	rs("job")=job
	rs("collateral_class_id")=split(collateral_class,"|")(0)
	rs("collateral_class_name")=split(collateral_class,"|")(1)
	rs("collateral")=collateral
	rs("collateral_value")=collateral_value
	rs("creditor_right_value")=creditor_right_value
	rs("repayment_date")=repayment_date
	rs("advance_pay")=advance_pay
	rs("month_pay")=month_pay
	rs("approval_other")=0
	rs("add_uid")=request.cookies("hhp2p_cookies")("uid")
	rs("inputdate")=now()
	rs.update 
	rs.close
	'getIdSql = "Select * from contracts where number ="&o_number
	rs.Open "Select top 1 * from creditor_right order by id DESC",conn,1,3
	if not rs.eof then
	cid=rs("id")
	'response.write c_id
	end if 
	rs.close
	set rs=nothing
	if passport_img<>"" then
		
		passport_imgs=split(passport_img,",")
		for i=0 to ubound(passport_imgs)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&passport_imgs(i)&"','passport_img','creditor_right',"&cid&")"
		next
	end if
	if property_card<>"" then
		property_cards=split(property_card,",")
		for i=0 to ubound(property_cards)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&property_cards(i)&"','property_card','creditor_right',"&cid&")"
		next
	end if
	if notarization<>"" then
		notarizations=split(notarization,",")
		for i=0 to ubound(notarizations)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&notarizations(i)&"','notarization','creditor_right',"&cid&")"
		next
	end if
	if IOU_receipt<>"" then
		IOU_receipts=split(IOU_receipt,",")
		for i=0 to ubound(IOU_receipts)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&IOU_receipts(i)&"','IOU_receipt','creditor_right',"&cid&")"
		next
	end if
	if contract<>"" then
		contracts=split(contract,",")
		for i=0 to ubound(contracts)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&contracts(i)&"','contract','creditor_right',"&cid&")"
		next
	end if
	if other_evidence<>"" then
		other_evidences=split(other_evidence,",")
		for i=0 to ubound(other_evidences)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&other_evidences(i)&"','other_evidence','creditor_right',"&cid&")"
		next
	end if
	if other_other<>"" then
		other_otheres=split(other_other,",")
		for i=0 to ubound(other_otheres)
			conn.execute "insert into upload_files (filename,file_type,table_name,cid) VALUES ('"&other_otheres(i)&"','other_other','creditor_right',"&cid&")"
		next
	end if		
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
	conn.execute "update creditor_right set approval=1,approval_uid="&request.cookies("hhp2p_cookies")("uid")&",approval_date='"&now()&"',remaining_amount=creditor_right_value where approval=0 and id="&id
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
