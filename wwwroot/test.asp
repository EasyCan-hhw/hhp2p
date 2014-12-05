
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="conn.asp"-->
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
</head>

<body>
  <%
    set rs=server.CreateObject("adodb.recordset")
    rs.Open "select * from work_attendance",conn,1,3
    rs.close
  %>

</body> 
</html>
