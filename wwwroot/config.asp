<%   
				Const MaxPerPage=20
   				dim totalPut   
   				dim CurrentPage
   				dim TotalPages
                 
    				if Not isempty(request("page")) then
      				currentPage=Cint(request("page"))
   				else
      				currentPage=1
   				end if 
				
Function showpage(totalnumber,maxperpage,filename,keyword)  
  				Dim n
				If totalnumber Mod maxperpage=0 Then  
					n= totalnumber \ maxperpage  
				Else
					n= totalnumber \ maxperpage+1  
				End If
				showpage_temp="<form method=""Post"" action="""&filename&"?go="&keyword&""" ><div class='fg-toolbar ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix'><div class='dataTables_paginate fg-buttonset ui-buttonset fg-buttonset-multi ui-buttonset-multi paging_full_numbers' style='margin: 0;'>"
				showpage_temp=showpage_temp&"共 "&totalnumber&" 条，每页 "&maxperpage&" 条&nbsp;&nbsp;&nbsp;&nbsp;"
				if CurrentPage=1 then
					showpage_temp=showpage_temp&"<a tabindex=""0"" class=""previous fg-button ui-button ui-state-default ui-state-disabled"">上一页</a>"
				else
					showpage_temp=showpage_temp&"<a href="""&filename&"?page=1"&keyword&""" tabindex=""0"" class=""first ui-corner-tl ui-corner-bl fg-button ui-button ui-state-default"">首页</a><a href="""&filename&"?page="&CurrentPage-1&keyword&""" tabindex=""0"" class=""previous fg-button ui-button ui-state-default"">上一页</a>"
				end if	
				if CurrentPage>3 then
					prevPage=CurrentPage-3
					if CurrentPage+3>n then
						nextPage=n
					else
						nextPage=CurrentPage+3
					end if
				else
					prevPage=1
					if CurrentPage+6>n then
						nextPage=n
					else
						nextPage=CurrentPage+6
					end if
				end if
				for i=prevPage to nextPage
					 if CurrentPage=i then showpage_temp=showpage_temp&"<span>"	
					 showpage_temp=showpage_temp&"<a "
					 if CurrentPage<>i then	showpage_temp=showpage_temp&"href="""&filename&"?page="&i&keyword&""" "
					 showpage_temp=showpage_temp&"tabindex=""0"" class=""fg-button ui-button ui-state-default"
					 if CurrentPage=i then showpage_temp=showpage_temp&" ui-state-disabled"
					 showpage_temp=showpage_temp&""" title=""第"&i&"页"">"&i&"</a>"
					 if CurrentPage=i then showpage_temp=showpage_temp&"</span>"
				next
				if CurrentPage=n then
					showpage_temp=showpage_temp&"<a tabindex=""0"" class=""next fg-button ui-button ui-state-default ui-state-disabled"">下一页</a>"
				else
					showpage_temp=showpage_temp&"<a href="""&filename&"?page="&CurrentPage+1&keyword&""" tabindex=""0"" class=""next fg-button ui-button ui-state-default"">下一页</a><a href="""&filename&"?page="&n&keyword&""" tabindex=""0"" class=""last ui-corner-tr ui-corner-br fg-button ui-button ui-state-default"">尾页</a>"
				end if
				showpage_temp=showpage_temp&"&nbsp;&nbsp;&nbsp;&nbsp;转到：<input type='text' name='page' size=2 maxlength=10  value="&currentpage&" style='width:20px;margin-bottom:0;'>页"  
				showpage_temp=showpage_temp&"&nbsp;<input type='submit' class='btn-primary' value='GO' name='cndok'>"  
				showpage_temp=showpage_temp&"</div></div></form>"
				showpage=showpage_temp
End Function  

Function SafeRequest(ParaName)  
Dim ParaValue  
ParaValue=vbsUnEscape(Request(ParaName)) 
if IsNumeric(ParaValue) = True then 
SafeRequest=ParaValue 
exit Function 
elseif isnull(ParaValue) then
	response.write "1|"&textbox&"|输入包含非法字符!"
	response.end
elseIf Instr(LCase(ParaValue),"select ") > 0 or Instr(LCase(ParaValue),"insert ") > 0 or Instr(LCase(ParaValue),"delete from") > 0 or Instr(LCase(ParaValue),"count(") > 0 or Instr(LCase(ParaValue),"drop table") > 0 or Instr(LCase(ParaValue),"update ") > 0 or Instr(LCase(ParaValue),"truncate ") > 0 or Instr(LCase(ParaValue),"asc(") > 0 or Instr(LCase(ParaValue),"mid(") > 0 or Instr(LCase(ParaValue),"char(") > 0 or Instr(LCase(ParaValue),"xp_cmdshell") > 0 or Instr(LCase(ParaValue),"exec master") > 0 or Instr(LCase(ParaValue),"net localgroup administrators") > 0  or Instr(LCase(ParaValue)," and ") > 0 or Instr(LCase(ParaValue),"net user") > 0 or Instr(LCase(ParaValue)," or ") > 0 then 
	response.write "1|"&ParaName&"|输入包含非法字符!"
	response.end
else 
SafeRequest=ParaValue 
End If 
End function 

Function vbsUnEscape(str) 
    dim i,s,c 
    s="" 
    For i=1 to Len(str) 
        c=Mid(str,i,1) 
        If Mid(str,i,2)="%u" and i<=Len(str)-5 Then 
            If IsNumeric("&H" & Mid(str,i+2,4)) Then 
                s = s & CHRW(CInt("&H" & Mid(str,i+2,4))) 
                i = i+5 
            Else 
                s = s & c 
            End If 
        ElseIf c="%" and i<=Len(str)-2 Then 
            If IsNumeric("&H" & Mid(str,i+1,2)) Then 
                s = s & CHRW(CInt("&H" & Mid(str,i+1,2))) 
                i = i+2 
            Else 
                s = s & c 
            End If 
        Else 
            s = s & c 
        End If 
    Next 
    vbsUnEscape = s 
End Function 

Function htmlspecialchars(str)
	str = Replace(str, "&", "&amp;")
	str = Replace(str, "<", "&lt;")
	str = Replace(str, ">", "&gt;")
	str = Replace(str, """", "&quot;")
	str = Replace(str, "'", "&apos;")
	str = Replace(str, ",", "&#44;")
	htmlspecialchars = str
End Function

Function Getdingdan()
	Dim y, m, d, h, mm, S, r
	Randomize
	y = right(year(Now),2)
	m = Month(Now): If m < 10 Then m = "0" & m
	d = Day(Now): If d < 10 Then d = "0" & d
	h = Hour(Now): If h < 10 Then h = "0" & h
	mm = Minute(Now): If mm < 10 Then mm = "0" & mm
	S = Second(Now): If S < 10 Then S = "0" & S
	r = 0
	r = CInt(Rnd() * 1000)
	If r < 10 Then r = "00" & r
	If r < 100 And r >= 10 Then r = "0" & r
	Getdingdan = y & m & d & h & mm & S & r
End Function

if request.cookies("hhp2p_cookies")("remember")<>"1" then Response.Cookies("hhp2p_cookies").Expires = DateAdd("h", 1, Now())

id=request("id")
if id<>"" and not IsNumeric(id) then
	response.redirect("/")
	Response.end
end if

filename=right(Request.ServerVariables("SCRIPT_NAME"),len(Request.ServerVariables("SCRIPT_NAME"))-InStrRev(Request.ServerVariables("SCRIPT_NAME"), "/"))
filename=left(filename,instr(filename,".")-1)

Function Checksum(str)
	str=(mid(str,1,1)*8)+(mid(str,2,1)*6)+(mid(str,3,1)*4)+(mid(str,4,1)*2)+(mid(str,5,1)*3)+(mid(str,6,1)*5)+(mid(str,7,1)*9)+(mid(str,8,1)*7)
	str=str mod 11
	str=11-str
	if str=10 then str=0
	if str=11 then str=5
	Checksum = str
End Function


Function getBarcode(uid)
	uid=right(uid,1)
	set rs_s=server.createobject("adodb.recordset")
	rs_s.open "Select * from user_seq where uid="&uid,conn,1,3
	if not rs_s.eof then
		result=rs_s("id")+1
		rs_s("id")=result
		rs_s.update
	end if
	rs_s.close
	set rs_s=nothing
	if len(result)<6 then
		for i=1 to 6-len(result)
			result="0"&result
		next
	end if
	result="1"&result&uid
	getBarcode="PP"&result&Checksum(result)&"BJ"
End Function


Function FromUnixTime(intTime, intTimeZone)    
'intTime=myssql的时间戳，intTimeZone=时区，中国8    
    If IsEmpty(intTime) Or Not IsNumeric(intTime) Then       
         FromUnixTime = Now()        
        Exit Function       
    End If       
    If IsEmpty(intTime) Or Not IsNumeric(intTimeZone) Then intTimeZone = 0        
     FromUnixTime = DateAdd("s", intTime, "1970-1-1 0:0:0")        
     FromUnixTime = DateAdd("h", intTimeZone, FromUnixTime)        
End Function 


Public Function ForMatDate(DateAndTime, Para) '格式化日期(日期时间,格式) 
Dim Y, M, D, H, F, S 
IF Not ISNumeric(Para) Or Not ISDate(DateAndTime) Then Exit Function  
Y = CStr(Year(DateAndTime)) 
M = CStr(Month(DateAndTime)):IF Len(M) = 1 Then M = "0" & M  
D = CStr(Day(DateAndTime)):IF Len(D) = 1 Then D = "0" & D  
H = CStr(Hour(DateAndTime)):IF Len(H) = 1 Then H = "0" & H  
F = CStr(Minute(DateAndTime)):IF Len(F) = 1 Then F = "0" & F  
S = CStr(Second(DateAndTime)):IF Len(S) = 1 Then S = "0" & S  
Select Case Para 
    Case "0" 
        ForMatDate = Y & "-" & M & "-" & D & " " & H & ":" & F & ":" & S 
    Case "1" 
        ForMatDate = Y & "-" & M & "-" & D & " " & H & ":" & F 
    Case "2" 
        ForMatDate = Y & "-" & M & "-" & D  
    Case "3" 
        ForMatDate = Y & "/" & M & "/" & D  
    Case "4" 
        ForMatDate = Y & "年" & M & "月" & D & "日"  
    Case "5"  
        ForMatDate = M & "-" & D & " " & H & ":" & F  
    Case "6"  
        ForMatDate = M & "/" & D  
    Case "7"  
        ForMatDate = M & "月" & D & "日"  
    Case "8"  
        ForMatDate = Y & "年" & M & "月"  
    Case "9"  
        ForMatDate = Y & "-" & M  
    Case "10"  
        ForMatDate = Y & "/" & M  
    Case "11"  
        ForMatDate = right(Y,2) & "-" &M & "-" & D & " " & H & ":" & F  
    Case "12"  
        ForMatDate = right(Y,2) & "-" &M & "-" & D  
    Case "13"  
        ForMatDate = M & "-" & D  
    Case Else  
        ForMatDate = DateAndTime 
End Select 
End Function



function int2chn(n) 
dim i,j,k,strlen,retval,x,y,z,str 
z=array("零","壹","貳","參","肆","伍","陸","柒","捌","玖") 
y=array("","拾","佰","仟") 
x=Array("","万","亿","万万亿") 
strlen=len(n) 
str1=n 
for i= 1 to strlen 
j=mid(str1,i,1) 
retval=retval&z(j) 
if j>0 then retval=retval&y((strlen-i) mod 4)'如果大於零，加入十進位字符 
retval=replace(retval,z(0)&z(0),z(0))'出現兩個零後只留一個 
if ((strlen-i) mod 4)=0 and right(retval,1)=z(0) then retval=left(retval,len(retval)-1)'每四位加入進階 
if ((strlen-i) mod 4)=0 then retval=retval&x(int((strlen-i)/4))'把最後的零去掉 
next 
int2chn=retval 
end function 


Function FormatSize(FileSize) 
 If FileSize<1024 then FormatSize = FileSize & " Byte" 
 If FileSize/1024 <1024 And FileSize/1024 > 1 then 
 FileSize = FileSize/1024 
 FormatSize=round(FileSize*100)/100 & " KB" 
 Elseif FileSize/(1024*1024) > 1 Then 
 FileSize = FileSize/(1024*1024) 
 FormatSize = round(FileSize*100)/100 & " MB" 
 End If 
 End function 


Function next_date(olddate,nextdate)
	if split(olddate,"-")(2)=split(nextdate,"-")(2) then
		next_date=ForMatDate(DateAdd("d", -1, nextdate),2)
	else
		next_date=nextdate
	end if
End function


%>
<!--#include file="conn.asp" -->
