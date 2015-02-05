<%
dim file,filename,houzui
file =Request.Form("file")

if file="" then
response.write"<script>alert('请选择要上传的文件！');window.location.href='upload.htm';</script>"
else
houzui=mid(file,InStrRev(file,"."))

if houzui=".gif" or houzui=".jpg" or houzui=".bmp" then
'允许上传的文件类型
filename=year(date) & month(date) & day(date) &Hour(time) & minute(time) & second(time) & houzui
SetobjStream = Server.CreateObject("ADODB.Stream")
objStream.Type =1
objStream.Open
objStream.LoadFromFile file
objStream.SaveToFile
Server.MapPath(filename),2
objStream.Close

//============================把文件名写入数据库，如无需要，可删除此段代码！
Set conn = Server.CreateObject("ADODB.Connection")
conn.open "DRIVER={MicrosoftAccess Driver (*.mdb)}; DBQ=" & Server.MapPath("mb.mdb")
set rs=server.CreateObject("adodb.recordset")
rs.open "select*fromimg",conn,1,2
rs.addnew
rs("name")=filename
rs.update
set rs=nothing
conn.close
set conn=nothing
//========================================

response.write"<script>alert('图片上传成功！');window.location.href='upload.htm';</script>"
else
response.write"<script>alert('不允许上传"& houzui &"的格式！');window.location.href='upload.htm';</script>"
end if
end if
%>