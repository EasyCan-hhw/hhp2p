<%   
  'on   error   resume   next   
  connstr="Driver={SQL Server};Server=127.0.0.1;UID=hhp2p_admin;PWD=HHp2p_Admin;Database=hhp2p_erp"   
  set   conn=server.createobject("ADODB.CONNECTION")   
  conn.open connstr 
  
 
  If Err Then
		err.Clear
		Set Conn = Nothing
		Response.Write "数据库连接出错，请检查Conn.asp文件中的数据库参数设置。"
		Response.End
	End If
sub CloseConn()
	On Error Resume Next
	If IsObject(Conn) Then
		conn.close
		set conn=nothing
	end if
end sub

%>

