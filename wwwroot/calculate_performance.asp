
<!--#include file="conn.asp" -->
<%

function performence(selectDate)

	set rsUserJob=server.createobject("adodb.recordset")
	rsUserJob.Open "select users.job_number,users.user_code, users.job_id, jobs.least_money, jobs.month_money from users inner join jobs on users.job_id = jobs.id and jobs.least_money > 0 and jobs.month_money > 0",conn,1,1
	dim performenceArray 
	redim performenceArray(rsUserJob.recordcount - 1)
	for index = 0 to rsUserJob.recordcount-1
		
		dim onePerformance
     	redim onePerformance(4)
     	onePerformance(0) = rsUserJob("job_number")
     	
	    onePerformance(1) = getSelfPerformance(rsUserJob("job_number"),rsUserJob("user_code"),selectDate) '调用方法拿到自己的业绩'
	    set rsUserList=server.createobject("adodb.recordset")
     	rsUserList.Open "select * from users where lead_user ="&rsUserJob("job_number"),conn,1,1
	     	dim jobNumberArray
	     	redim jobNumberArray(rsUserList.recordcount)
		     	if not rsUserList.eof then 
			     	for index1 = 0 to rsUserList.recordcount-1
				     	jobNumberArray(index1) = rsUserList("job_number")
				     	rsUserList.movenext
			     	next
		     	else 
		     	
		     		jobNumberArray(0)=00
		     	end if 
		     	for l=0 to Ubound(jobNumberArray)

		     		
		     	next
	     	
	     	onePerformance(2) = jobNumberArray
	    rsUserList.close
     	set rsUserList=nothing
     	onePerformance(3) = 0
     	
     	performenceArray(index)= onePerformance
     	
     	rsUserJob.movenext
   	next

	rsUserJob.close
	set rsUserJob  = nothing

	for j = 0 to Ubound(performenceArray)
		
	    oneJobNumber = performenceArray(j)(0)
		end_performance = getTotalPerformance(oneJobNumber, performenceArray)
		
		'performenceArray(j)(1) = end_performance
	next

	for j = 0 to Ubound(performenceArray)
		dim eachPerformance
		eachPerformance = performenceArray(j)
		
		strListOfSubOrdinates = ""
		subordinates = eachPerformance(2)
		for k = 0 to Ubound(subordinates)
			strListOfSubOrdinates = strListOfSubOrdinates & "," & subordinates(k)
		next
		
	next

	performence = performenceArray
	
end function

	'计算自己业绩的function'
function getSelfPerformance(jobNumber,user_code,inputdate)
	set rsPerfomanceList=server.createobject("adodb.recordset")
	rsPerfomanceList.Open "select * from contracts where job_number="&jobNumber&" and Convert(varchar,approval_date,120) like "&inputdate&"",conn,1,1
	selfPerformance = 0
	
	for index = 0 to rsPerfomanceList.recordcount - 1
		if user_code = 0 then 
		  	selfPerformance = selfPerformance +  rsPerfomanceList("capital")
		elseif user_code =1 then 
	  			cycleNumber = 360/rsPerfomanceList("cycle")
	  			yearlyPerformance  =  rsPerfomanceList("capital")/cycleNumber
	  			selfPerformance = selfPerformance + yearlyPerformance
		 else 
		 end if 

		 rsPerfomanceList.movenext
	next
	getSelfPerformance = selfPerformance
	rsPerfomanceList.close
	set rsPerfomanceList=nothing
end function

function getTotalPerformance(jobNumber, arrayOfPerformance)
	  for index = 0 to Ubound(arrayOfPerformance)
	  'response.write "All_right"
	    onePerformance = arrayOfPerformance(index)
	  	if jobNumber = onePerformance(0) then'判断当前传入的job-number是否等于该数组的job_number
	  		if onePerformance(3) = 1 then
	  		    
	  			getTotalPerformance = onePerformance(1)
	  			exit function
	  		else
	  			 subordinates = onePerformance(2)
	  			 selfPerformance = onePerformance(1)
	  			 totalPerformance = selfPerformance
	  			for subIndex = 0 to Ubound(subordinates)
	  			     subJobNumber = subordinates(subIndex)
	  			     tmpPerformance = getTotalPerformance(subJobNumber, arrayOfPerformance)
	  				totalPerformance = totalPerformance + tmpPerformance
	  			next
	  			arrayOfPerformance(index)(3) = 1
	  			arrayOfPerformance(index)(1) = totalPerformance
	  			getTotalPerformance = totalPerformance
	  			exit function
	  		end if 
	  	end if
	  next
end function

'计算提成 insert 职位id，业绩，标识0下级总业绩1自己总业绩'	
function sumSection(jobid,sumPerformence,jobBoolean) 
    resultPerformence = 0
	set rsSection=server.CreateObject("adodb.recordset")
    rsSection.Open "select bscale,special from brokerage_section where bmin <= "&sumPerformence&" and bmax > "&sumPerformence&" and job_id ="&jobid,conn,1,1
        if not rsSection.eof then 
        	if rsSection("special") = 0 then 
	            if jobBoolean = 0 then '下级总业绩(不考虑年化)
	                resultPerformence = sumPerformence*cdbl(rsSection("bscale"))
	            elseif jobBoolean = 1 then '自己总业绩（不考虑年化）'
                    resultPerformence = sumPerformence*(cdbl(0.01)+cdbl(rsSection("bscale")))
	            end if
		    elseif rsSection("special")=1 then 
	            if jobBoolean = 1 then '理财顾问提佣'
		            resultPerformence = sumPerformence*cdbl(rsSection("bscale"))
	            end if 
		    end if
        end if
      rsSection.close
      set rsSection = nothing		
      sumSection = resultPerformence
end function

'计算下级业绩'
function ordinatesPerformence(job_number,inputdate)
	sumPerformences = 0
	sumPerformences =  sumPerformences + getmySelfPerformence(job_number,inputdate)
	

	set rsSubordinates=server.CreateObject("adodb.recordset")
    rsSubordinates.Open "select * from users where lead_user ='"&job_number&"' ",conn,1,1
    
    if not rsSubordinates.eof then 
     	for r=0 to rsSubordinates.recordcount -1
	     	
	     	sumPerformences = sumPerformences +  ordinatesPerformence(rsSubordinates("job_number"),inputdate)
	     	rsSubordinates.movenext
     	next
     end if 

    rsSubordinates.close
    set rsSubordinates = nothing

    ordinatesPerformence = sumPerformences
end function

'不考虑试用期计算员工业绩'
function getmySelfPerformence(jobNumber,inputdate)

	set rsPerfomanceList=server.createobject("adodb.recordset")
	sqlQueryString = "select * from contracts where approval=1 and job_number='"&jobNumber&"' and Convert(varchar,approval_date,120) like "&inputdate&""
	
	rsPerfomanceList.Open sqlQueryString,conn,1,1
	selfPerformance = 0
	for index = 0 to rsPerfomanceList.recordcount - 1
		cycleNumber = 360/rsPerfomanceList("cycle")
		yearlyPerformance  =  rsPerfomanceList("capital")/cycleNumber
		selfPerformance = selfPerformance + yearlyPerformance
		rsPerfomanceList.movenext
	next

	getmySelfPerformence = selfPerformance
	
	exit function
	rsPerfomanceList.close
	set rsPerfomanceList=nothing
end function
%>