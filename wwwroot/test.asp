<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include file="conn.asp" -->
<%
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Server.HTMLEncode(Request.QueryString)
MM_valUsername=CStr(Request.Form("user"))
If MM_valUsername <> "" Then
  MM_fldUserAuthorization=""
  MM_redirectLoginSuccess="hy.asp"
  MM_redirectLoginFailed="erro.asp"
  MM_flag="ADODB.Recordset"
  set MM_rsUser = Server.CreateObject(MM_flag)
  MM_rsUser.ActiveConnection = MM_web_STRING
  MM_rsUser.Source = "SELECT 会员名, 密码"
  If MM_fldUserAuthorization <> "" Then MM_rsUser.Source = MM_rsUser.Source & "," & MM_fldUserAuthorization
  MM_rsUser.Source = MM_rsUser.Source & " FROM 用户名 WHERE 会员名='" & Replace(MM_valUsername,"'","''") &"' AND 密码='" & Replace(Request.Form("password"),"'","''") & "'"
  MM_rsUser.CursorType = 0
  MM_rsUser.CursorLocation = 2
  MM_rsUser.LockType = 3
  MM_rsUser.Open
  If Not MM_rsUser.EOF Or Not MM_rsUser.BOF Then 
    ' username and password match - this is a valid user
    Session("MM_Username") = MM_valUsername
    If (MM_fldUserAuthorization <> "") Then
      Session("MM_UserAuthorization") = CStr(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value)
    Else
      Session("MM_UserAuthorization") = ""
    End If
    if CStr(Request.QueryString("accessdenied")) <> "" And false Then
      MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    End If
    MM_rsUser.Close
    Response.Redirect(MM_redirectLoginSuccess)
  End If
  MM_rsUser.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
</head>

<body>
<% 
 o_number=0120120123
  set rs=server.createobject("adodb.recordset")
  sql = "Select * from contracts"
  rs.Open sql,conn,1,3
  rs.addnew
  rs("number")=o_number
  rs("cid")=cid
  rs("passport")=passport
  rs("full_name")=full_name
  rs("product_name")=product_name
  rs("cycle")=cycle
  rs("profit")=profit
  rs("capital")=capital
  rs("start_date")=start_date
  rs("add_uid")=request.cookies("hhp2p_cookies")("uid")
  rs("inputdate")=now()
  rs.update
  rs.close
  'getIdSql = "Select * from contracts where number ="&o_number
  rs.Open "Select * from contracts where number ="&o_number,conn,1,3
  if not rs.eof then 
  c_id=rs("id")
  response.write c_id
  end if 
  rs.close
%>
</body>
</html>