jQuery(function($){
	
	$("#login_submit_submit").click(function(){
		var tosubmit=true;
		if($.trim($("#loginform #username").val()).length == 0){
			tosubmit=false;
			alert("请输入用户名");
		}
		else if($.trim($("#loginform #password").val()).length == 0){
			tosubmit=false;
			alert("请输入密码");
		}
		if(tosubmit){
			var query = new Object();
			query.username=escape($("#loginform #username").val());
			query.password=escape($("#loginform #password").val());
			$.ajax({
				url: "check_login.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])>0)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						window.location.href=data.split("|")[1];
				   }
				}
			});
		}
	});

});

