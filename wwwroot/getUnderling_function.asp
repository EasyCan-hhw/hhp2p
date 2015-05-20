<!--#include file="conn.asp"-->

<%
	'获得下级以及下下级的工号'
	function requestUnderlingjobnumber(Rjob_number)
		resultNumberList = ""
		set rs = server.createobject("adodb.recordset")
		rs.Open "select * from users where lead_user = '" & Rjob_number & "'", conn, 1, 1
		dim arrayjobnumber
		
		if not rs.eof then
			arrayLength = rs.recordcount
			redim arrayjobnumber(arrayLength)
			for index = 0 to arrayLength - 1
			    arrayjobnumber(index) = rs("job_number")
				rs.movenext
			next

			
			set rs = nothing

			for index = 0 to arrayLength - 1
				currentJobNumber = arrayjobnumber(index)
				resultNumberList = resultNumberList &"'"& currentJobNumber & "',"
				resultNumberList = resultNumberList & requestUnderlingjobnumber(currentJobNumber)
			next
		else 
			rs.close
			
		end if
		'rs.close
			
		
		requestUnderlingjobnumber = resultNumberList
	end function


	function requestCustomersCode(uid)
		set rs = server.createobject("adodb.recordset")
		rs.Open "select * from users where uid = " & uid , conn, 1, 1


		rs.close
		set rs = nothing 
	end function


	'获得下级以及下下级的UID'
	function requestUnderlingUid(uid)
		
		set rs = server.createobject("adodb.recordset")
		rs.Open "select * from users where uid = " & uid , conn, 1, 1
		if not rs.eof then 
			job_number = rs("job_number")

		else 
			job_number = 0
		end if 
		rs.close
		set rs = nothing 

		resultNumberList = ""
		set rs = server.createobject("adodb.recordset")
		rs.Open "select * from users where lead_user = '" & job_number & "'", conn, 1, 1
		dim arrayjobnumber
		
		if not rs.eof then
			arrayLength = rs.recordcount
			redim arrayjobnumber(arrayLength)
			for index = 0 to arrayLength - 1
			    arrayjobnumber(index) = rs("uid")
				rs.movenext
			next

			
			set rs = nothing

			for index = 0 to arrayLength - 1
				currentJobNumber = arrayjobnumber(index)
				resultNumberList = resultNumberList & currentJobNumber & ","
				resultNumberList = resultNumberList & requestUnderlingUid(currentJobNumber)
			next
		else 
			rs.close
			
		end if
		requestUnderlingUid = resultNumberList
	end function 


	
	
%>