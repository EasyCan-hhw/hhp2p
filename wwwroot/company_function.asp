<!--#include file="conn.asp" -->


<%
 	class hahaCompany
        public parentCompany
        public branchCompany
     end class

	function requestCompany(uid)
        set requestCompany = new hahaCompany
		set rscompany=server.createobject("adodb.recordset")
		rscompany.Open "select * from users where uid ="&uid,conn,1,1
		requestCompany.parentCompany = rscompany("company_id")'一级分公司'
		requestCompany.branchCompany = rscompany("company_code")'二级分公司'
		rscompany.close
		set rscompany = nothing
	end function

	'获取job_number判断二级是否为0，为0返回一级分公司代码，不为0返回二级分公司代码,else 返回-1  (judge判断，审判)
	function requestCompanyjudge(job_number)
		set rscompany=server.createobject("adodb.recordset")
		rscompany.Open "select * from users where job_number ='"&job_number&"'",conn,1,1
		if not rscompany.eof then 
			if not rscompany("company_code")="0" then 
				requestCompanyjudge = rscompany("company_code")
			else if rscompany("company_code")="0" then 
				requestCompanyjudge = rscompany("company_id")
			else 
				
			end if 
		end if
		else
		
		end if 
		
		rscompany.close
		set rscompany = nothing
	end function


	
%>