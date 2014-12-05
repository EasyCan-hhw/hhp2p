$(document).ready( function() {

		$("#check_all").click(function(){
			if(this.checked){
			   for (var i=0; i<$('input[name="subBox"]').length; i++)
				  $('input[name="subBox"]')[i].checked = true;
			}else{
			   for (var i=0; i<$('input[name="subBox"]').length; i++)
				  $('input[name="subBox"]')[i].checked = false;
			}
		});
		
		$("#check_all_download_csv").click(function(){
			if(this.checked){
			   for (var i=0; i<$('input[name="download_csv"]').length; i++)
				  $('input[name="download_csv"]')[i].checked = true;
			}else{
			   for (var i=0; i<$('input[name="download_csv"]').length; i++)
				  $('input[name="download_csv"]')[i].checked = false;
			}
		});
		
		$("#check_all_class").click(function(){
			if(this.checked){
			   for (var i=0; i<$('input[name="class_code"]').length; i++)
				  $('input[name="class_code"]')[i].checked = true;
			}else{
			   for (var i=0; i<$('input[name="class_code"]').length; i++)
				  $('input[name="class_code"]')[i].checked = false;
			}
		});
		
		if($('select').length>0){ 
			$('select').select2();
		} 


		$("#history_back").click(function(){
			history.back(-1);
		});
			
		$(".menu").click(function(){
			var id=this.id.split("_")[1];
			if($("#menu"+id).is(":hidden")){
				$("#menu"+id).show();
				$("#sidebar_"+id+" .icon").removeClass("icon-chevron-down");
				$("#sidebar_"+id+" .icon").addClass("icon-chevron-up");
			}else{
				$("#menu"+id).hide();
				$("#sidebar_"+id+" .icon").removeClass("icon-chevron-up");
				$("#sidebar_"+id+" .icon").addClass("icon-chevron-down");
			}
		});

	$(".upload_imgs_submit").click(function(){
		var img_file=this.id.split("-")[1]
		$(".err_text").html("");
		showUpload(this,img_file,'Upload_file',10,null);
	});


	$("#user_Invalids").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择用户！'); 
	  }else{
			$.ajax({
				url: "Invalids_user.asp",
				type:"post",
				data:"user_id="+chk_value,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				   if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("冻结用户成功！");
						window.location.href="manageuser.asp";
				   }
				}
			});
	  }

	});


	$("#user_Enables").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择用户！'); 
	  }else{
			$.ajax({
				url: "Enables_user.asp",
				type:"post",
				data:"user_id="+chk_value,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				   if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("解冻用户成功！");
						window.location.href="manageuser.asp";
				   }
				}
			});
	  }

	});
	
	$(".user_Enable").click(function(){
	  var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="Enable";
			$.ajax({
				url: "save_user.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				   if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("解冻用户成功！");
						window.location.href="manage_users.asp";
				   }
				}
			});

	});
	
	$(".user_Invalid").click(function(){
	  var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="Invalid";
			$.ajax({
				url: "save_user.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				   if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("冻结用户成功！");
						window.location.href="manage_users.asp";
				   }
				}
			});

	});





	$("#add_company_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#company_code").val()).length == 0){
			tosubmit=false;
			$("#company_code_err").html("请输入分公司代码");
		}
		if($.trim($("#company_name").val()).length == 0){
			tosubmit=false;
			$("#company_name_err").html("请输入分公司名称");
		}
		if(tosubmit){
			$("#add_company_submit").attr("disabled",true);
			var query = new Object();
			query.company_code=escape($("#company_code").val());
			query.company_name=escape($("#company_name").val());
			query.action="add";
			$.ajax({
				url: "save_company.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_company_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_company_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_companys.asp";
				   }
				}
			});
		}
	});



	$(".company_edit").click(function(){
	 	var id=this.id.split("_")[2];
		var tosubmit=true;
		if($.trim($("#company_code"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入分公司代码");
		}
		if($.trim($("#company_name"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入分公司名称");
		}
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.company_code=escape($("#company_code"+id).val());
			query.company_name=escape($("#company_name"+id).val());
			query.action="edit";
			$.ajax({
				url: "save_company.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_companys.asp";
				   }
				}
			});
		}

	});

	$(".company_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_company.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_companys.asp";
				   }
				}
			});
		}
	});


	$("#add_job_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#job_name").val()).length == 0){
			tosubmit=false;
			$("#job_name_err").html("请输入职位名称");
		}
		var quanxian ="";   
		$('input[name="quanxian"]:checked').each(function(){    
		   quanxian+=$(this).val()+",";     
		}); 
		if(tosubmit){
			$("#add_job_submit").attr("disabled",true);
			var query = new Object();
			query.job_name=escape($("#job_name").val());
			query.quanxian=quanxian;
			query.action="add";
			$.ajax({
				url: "save_job.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_job_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_job_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_jobs.asp";
				   }
				}
			});
		}
	});



	$(".job_edit").click(function(){
	 	var id=this.id.split("_")[2];
		var tosubmit=true;
		if($.trim($("#job_name"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入职位名称");
		}
		var quanxian="";
		$("input[name='quanxian"+id+"']:checked").each(function(){    
		   quanxian+=$(this).val()+",";     
		}); 
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.job_name=escape($("#job_name"+id).val());
			query.quanxian=quanxian;
			query.action="edit";
			$.ajax({
				url: "save_job.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_jobs.asp";
				   }
				}
			});
		}

	});

	$(".job_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_job.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_jobs.asp";
				   }
				}
			});
		}
	});




	$("#add_user_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#username").val()).length == 0){
			tosubmit=false;
			$("#username_err").html("请输入用户名");
		}
		if($.trim($("#job_number").val()).length == 0){
			tosubmit=false;
			$("#job_number_err").html("请输入工号");
		}
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入姓名");
		}
		if($.trim($("#company_id").val()).length == 0){
			tosubmit=false;
			$("#company_id_err").html("请选择所属分公司");
		}
		if($.trim($("#job_id").val()).length == 0){
			tosubmit=false;
			$("#job_id_err").html("请选择职位");
		}
		if($.trim($("#tel").val()).length == 0){
			tosubmit=false;
			$("#tel_err").html("请输入电话");
		}
		if($.trim($("#qq").val()).length == 0){
			tosubmit=false;
			$("#qq_err").html("请输入QQ号");
		}
		if($.trim($("#email").val()).length == 0){
			tosubmit=false;
			$("#email_err").html("请输入E-mail地址");
		}
		var quanxian ="";   
		$('input[name="quanxian"]:checked').each(function(){    
		   quanxian+=$(this).val()+",";     
		}); 
		if(tosubmit){
			$("#add_user_submit").attr("disabled",true);
			var query = new Object();
			query.username=escape($("#username").val());
			query.job_number=escape($("#job_number").val());
			query.full_name=escape($("#full_name").val());
			query.company_id=escape($("#company_id").val());
			query.job_id=escape($("#job_id").val());
			query.tel=escape($("#tel").val());
			query.qq=escape($("#qq").val());
			query.email=escape($("#email").val());
			query.quanxian=quanxian;
			query.action="add";
			$.ajax({
				url: "save_user.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_user_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_user_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_users.asp";
				   }
				}
			});
		}
	});



	$("#edit_user_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#job_number").val()).length == 0){
			tosubmit=false;
			$("#job_number_err").html("请输入工号");
		}
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入姓名");
		}
		if($.trim($("#company_id").val()).length == 0){
			tosubmit=false;
			$("#company_id_err").html("请选择所属分公司");
		}
		if($.trim($("#job_id").val()).length == 0){
			tosubmit=false;
			$("#job_id_err").html("请选择职位");
		}
		if($.trim($("#tel").val()).length == 0){
			tosubmit=false;
			$("#tel_err").html("请输入电话");
		}
		if($.trim($("#qq").val()).length == 0){
			tosubmit=false;
			$("#qq_err").html("请输入QQ号");
		}
		if($.trim($("#email").val()).length == 0){
			tosubmit=false;
			$("#email_err").html("请输入E-mail地址");
		}
		var quanxian ="";   
		$('input[name="quanxian"]:checked').each(function(){    
		   quanxian+=$(this).val()+",";     
		}); 
		if(tosubmit){
			$("#edit_user_submit").attr("disabled",true);
			var query = new Object();
			query.id=escape($("#uid").val());
			query.password=escape($("#password").val());
			query.job_number=escape($("#job_number").val());
			query.full_name=escape($("#full_name").val());
			query.company_id=escape($("#company_id").val());
			query.job_id=escape($("#job_id").val());
			query.tel=escape($("#tel").val());
			query.qq=escape($("#qq").val());
			query.email=escape($("#email").val());
			query.quanxian=quanxian;
			query.action="edit";
			$.ajax({
				url: "save_user.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#edit_user_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#edit_user_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_users.asp";
				   }
				}
			});
		}
	});


	$(".user_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_user.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_users.asp";
				   }
				}
			});
		}
	});


	$(".follow_up").click(function(){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="follow_up";
			$.ajax({
				url: "save_target_customers.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("跟进成功！");
						window.location.href="customer_tracking.asp";
				   }
				}
			});
	});




	$("#search_user_submit").click(function(){
		$("#add_search_user_form").submit();
	});



	$("#car_brand_id").change(function(){
		$("#car_series_id").empty(); 
		$("#car_model_id").empty();
		$("#car_series_id").select2({placeholder:""});
		$("#car_model_id").select2({placeholder:""});
		$.getJSON("../json/get_carmodel.asp?id="+$("#car_brand_id").val(),function(json){
		  $.each(json.results, function(i,item){
			  $("#car_series_id").append("<option value='"+item.carmodel_id+"'>"+item.carmodel_name+"</option>"); 
			});

		});

	});

	$("#car_series_id").change(function(){
		$("#car_model_id").empty();
		$("#car_model_id").select2({placeholder:""});
		$.getJSON("../json/get_carmodel.asp?id="+$("#car_series_id").val(),function(json){
		  $.each(json.results, function(i,item){
			  $("#car_model_id").append("<option value='"+item.carmodel_id+"'>"+item.carmodel_name+"</option>"); 
			});

		});

	});


	$("#add_order_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#uid").val()).length == 0){
			tosubmit=false;
			$("#uid_err").html("请选择用户手机号");
		}
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入姓名");
		}
		if($.trim($("#car_brand_id").val()).length == 0){
			tosubmit=false;
			$("#car_brand_id_err").html("请选择品牌");
		}
		if($.trim($("#car_series_id").val()).length == 0){
			tosubmit=false;
			$("#car_series_id_err").html("请选择车系");
		}
		if($.trim($("#car_model_id").val()).length == 0){
			tosubmit=false;
			$("#car_model_id_err").html("请选择车型");
		}
		if($.trim($("#service_id").val()).length == 0){
			tosubmit=false;
			$("#service_id_err").html("请选择服务项目");
		}
		if($.trim($("#service_date").val()).length == 0){
			tosubmit=false;
			$("#service_date_err").html("请选择服务日期");
		}
		if(tosubmit){
			$("#add_order_submit").attr("disabled",true);
			var query = new Object();
			query.uid=escape($("#uid").val().split("_")[0]);
			query.username=escape($("#uid").val().split("_")[1]);
			query.full_name=escape($("#full_name").val());
			query.car_brand_id=escape($("#car_brand_id").val());
			query.car_series_id=escape($("#car_series_id").val());
			query.car_model_id=escape($("#car_model_id").val());
			query.service_id=escape($("#service_id").val());
			query.service_date=escape($("#service_date").val());
			query.action="add";

			$.ajax({
				url: "save_order.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_order_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_order_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_order.asp";
				   }
				}
			});
		}
	});

	$(".order_edit").click(function(){
	 	var id=this.id.split("_")[2];
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#jiage"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入价格");
		}
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.action="edit";
			query.jiage=$.trim($("#jiage"+id).val());
			query.status=$.trim($("#status"+id).val());
			$.ajax({
				url: "save_order.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_order.asp";
				   }
				}
			});
		}
	});


	$(".order_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_order.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_order.asp";
				   }
				}
			});
		}
	});


	$(".upload_img_submit").click(function(){
		var img_file=this.id.split("-")[1]
		$(".err_text").html("");
		showUpload(this,img_file,'../Upload_img',1,null);
	});


	$("#add_admin_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#username").val()).length == 0){
			tosubmit=false;
			$("#username_err").html("请输入用户名");
		}
		if($.trim($("#password").val()).length == 0){
			tosubmit=false;
			$("#password_err").html("请输入密码");
		}
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入姓名");
		}
		if($.trim($("#job").val()).length == 0){
			tosubmit=false;
			$("#job_err").html("请输入职务");
		}
	  var quanxian ="";   
	  $('input[name="quanxian"]:checked').each(function(){    
	   quanxian+=$(this).val()+",";     
	  }); 
		if(tosubmit){
			$("#add_admin_submit").attr("disabled",true);
			var query = new Object();
			query.username=escape($("#username").val());
			query.password=escape($("#password").val());
			query.full_name=escape($("#full_name").val());
			query.job=escape($("#job").val());
			query.quanxian=quanxian;
			query.action="add";

			$.ajax({
				url: "save_admin.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_admin_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_admin_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manageadmin.asp";
				   }
				}
			});
		}
	});

	$(".admin_edit").click(function(){
	 	var id=this.id.split("_")[2];
		var tosubmit=true;
		if($.trim($("#username"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入用户名");
		}
		if($.trim($("#full_name"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入姓名");
		}
		if($.trim($("#job"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入职务");
		}
		var quanxian="";
	  $("input[name='quanxian"+id+"']:checked").each(function(){    
	   quanxian+=$(this).val()+",";     
	  }); 
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.username=escape($("#username"+id).val());
			query.password=escape($("#password"+id).val());
			query.full_name=escape($("#full_name"+id).val());
			query.job=escape($("#job"+id).val());
			query.quanxian=quanxian;
			query.action="edit";
			$.ajax({
				url: "save_admin.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manageadmin.asp";
				   }
				}
			});
		}

	});

	$(".admin_del").click(function(){
		if(confirm('是否删除?')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_admin.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manageadmin.asp";
				   }
				}
			});
		}
	});

	$("#search_order_submit").click(function(){
		$("#add_search_order_form").submit();
	});
	
	//考勤打卡添加JS
	$("#insert_daka_submit").click(function(){
		var tosubmit=true;
		var he
		$(".err_text").html("");
		if ($.trim($("#job_number").val()).length == 0) {
			tosubmit=false;
			$("#job_number_err").html("请输入工号");
		}
		if ($.trim($("#username").val()).length == 0) {

			tosubmit=false
			$("#username_err").html("请输入姓名");
		}
		if ($.trim($("#work_date").val()).length == 0) {
			tosubmit=false
			$("#work_date_err").html("请选择时间");
		}
		if ($.trim($("#start_time1").val())>=24 || $.trim($("#start_time1").val())<0) {

			tosubmit=false
			$("#star_time_err").html("输入的时钟格式不规范");
		}
		if ($.trim($("#start_time2").val())>=60 || $.trim($("#start_time2").val())<0) {
			tosubmit=false
			$("#star_time_err").html("输入的分钟格式不规范")
		}
		if ($.trim($("#end_time1").val())>=24 || $.trim($("#end_time1").val())<0) {
			tosubmit=false
			$("#end_time_err").html("输入的时钟格式不规范")
		}
		if ($.trim($("#end_time2").val())>=60 || $.trim($("#end_time2").val())<0) {
			tosubmit=false
			$("#end_time_err").html("输入的分钟格式不规范")
		}
		if (tosubmit) {
			$("#insert_daka_submit").attr("disabled",true);
			var query = new Object();
			query.job_number=escape($("#job_number").val());
			query.username=escape($("#username").val());
			query.work_date=escape($("#work_date").val());
			query.start_time=escape($("#start_time1").val()*60+parseInt($("#start_time2").val()));
			query.end_time=escape($("#end_time1").val()*60+parseInt($("#end_time2").val()));
			query.action="add";
			$.ajax({
				url: "save_daka.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
				  		alert(data.split("|")[2]);
						//$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#insert_daka_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#insert_daka_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_daka.asp";
				   }
				}
			});

		}

	});


	//考勤打卡修改js

$(".daka_edit").click(function(){
		var tosubmit=true;
		var id=this.id.split("_")[2];
		$(".err_text").html("");
		if ($.trim($("#job_number"+id).val()).length == 0) {
			tosubmit=false;
			alert("请输入工号");
		}
		if ($.trim($("#username"+id).val()).length == 0) {
			tosubmit=false
			alert("请输入员工姓名");
		}
		if ($.trim($("#work_date"+id).val()).length == 0) {
			tosubmit=false
			alert("请输入打卡日期");
		}
		if ($.trim($("#start_time"+id).val()).length == 0) {
			tosubmit=false
			alert("时间不能为空");
		}
		if ($.trim($("#end_time"+id).val()).length == 0) {
			tosubmit=false
			alert("时间不能为空");
		}
		if (tosubmit) {
			
			var query = new Object();
			query.id=id;
			query.job_number=escape($("#job_number"+id).val());
			query.username=escape($("#username"+id).val());
			query.work_date=escape($("#work_date"+id).val());
			query.start_time=escape($("#start_time"+id).val());
			query.end_time=escape($("#end_time"+id).val());
			query.action="edit";
			$.ajax({
				url: "save_daka.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
				  		alert(data.split("|")[2]);
						//$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#insert_daka_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#insert_daka_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_daka.asp";
				   }
				}
			});

		}

	});
	
	
	$("#add_product_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#product_name").val()).length == 0){
			tosubmit=false;
			$("#product_name_err").html("请输入产品名称");
		}
		if($.trim($("#cycle").val()).length == 0){
			tosubmit=false;
			$("#cycle_err").html("请输入投资周期");
		}
		if($.trim($("#base").val()).length == 0){
			tosubmit=false;
			$("#base_err").html("请输入投资起点");
		}
		if($.trim($("#profit").val()).length == 0){
			tosubmit=false;
			$("#profit_err").html("请输入年化收益率");
		}
		if($.trim($("#penalty").val()).length == 0){
			tosubmit=false;
			$("#penalty_err").html("请输入赎回违约金");
		}
		if(tosubmit){
			$("#add_product_submit").attr("disabled",true);
			var query = new Object();
			query.product_name=escape($("#product_name").val());
			query.cycle=escape($("#cycle").val());
			query.base=escape($("#base").val());
			query.profit=escape($("#profit").val());
			query.penalty=escape($("#penalty").val());
			query.action="add";
			$.ajax({
				url: "save_product.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_product_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_product_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_products.asp";
				   }
				}
			});
		}
	});



	$(".product_edit").click(function(){
	 	var id=this.id.split("_")[2];
		var tosubmit=true;
		if($.trim($("#product_name"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入产品名称");
		}
		if($.trim($("#cycle"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入投资周期");
		}
		if($.trim($("#base"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入投资起点");
		}
		if($.trim($("#profit"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入年化收益率");
		}
		if($.trim($("#penalty"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入赎回违约金");
		}
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.product_name=escape($("#product_name"+id).val());
			query.cycle=escape($("#cycle"+id).val());
			query.base=escape($("#base"+id).val());
			query.profit=escape($("#profit"+id).val());
			query.penalty=escape($("#penalty"+id).val());
			query.action="edit";
			$.ajax({
				url: "save_product.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_products.asp";
				   }
				}
			});
		}

	});

	$(".product_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_product.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_products.asp";
				   }
				}
			});
		}
	});
	
	
	
	
	
	
	$("#add_custome_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入姓名");
		}
		if($.trim($("#birth_date").val()).length == 0){
			tosubmit=false;
			$("#birth_date_err").html("请选择出生日期");
		}
		if($.trim($("#passport").val()).length == 0){
			tosubmit=false;
			$("#passport_err").html("请输入身份证（护照号）");
		}
		if($.trim($("#lssue_date").val()).length == 0){
			tosubmit=false;
			$("#lssue_date_err").html("请选择签发日期");
		}
		if($.trim($("#expiry_date").val()).length == 0){
			tosubmit=false;
			$("#expiry_date_err").html("请选择失效日期");
		}
		if($.trim($("#mobile").val()).length == 0){
			tosubmit=false;
			$("#mobile_err").html("请输入联系电话");
		}
		if($.trim($("#city").val()).length == 0){
			tosubmit=false;
			$("#city_err").html("请输入工作城市");
		}
		if($.trim($("#postcodes").val()).length == 0){
			tosubmit=false;
			$("#postcodes_err").html("请输入邮政编码");
		}
		if($.trim($("#address").val()).length == 0){
			tosubmit=false;
			$("#address_err").html("请输入通讯地址");
		}
		if($.trim($("#bank_info").val()).length == 0){
			tosubmit=false;
			$("#bank_info_err").html("请输入开户行");
		}
		if($.trim($("#bank_account").val()).length == 0){
			tosubmit=false;
			$("#bank_account_err").html("请输入银行账号");
		}
		if($.trim($("#emergency_name").val()).length == 0){
			tosubmit=false;
			$("#emergency_name_err").html("请输入紧急联系人姓名");
		}
		if($.trim($("#emergency_title").val()).length == 0){
			tosubmit=false;
			$("#emergency_title_err").html("请输入紧急联系人称呼");
		}
		if($.trim($("#emergency_mobile").val()).length == 0){
			tosubmit=false;
			$("#emergency_mobile_err").html("请输入紧急联系人移动电话");
		}
		var custome_source ="";   
		$('input[name="custome_source"]:checked').each(function(){    
		   custome_source=$(this).val();     
		}); 
		if(custome_source=="other"){
			custome_source=$("#custome_source_other").val()
		}
		if(custome_source==""){
			tosubmit=false;
			$("#custome_source_err").html("请选择客户来源");
		}
		if($.trim($("#channel_name").val()).length == 0){
			tosubmit=false;
			$("#channel_name_err").html("请输入渠道名称");
		}
		if($.trim($("#recommend").val()).length == 0){
			tosubmit=false;
			$("#recommend_err").html("请输入推荐人");
		}
		if(tosubmit){
			$("#add_custome_submit").attr("disabled",true);
			var query = new Object();
			query.full_name=escape($("#full_name").val());
			query.sex=escape($("#sex").val());
			query.birth_date=escape($("#birth_date").val());
			query.passport=escape($("#passport").val());
			query.lssue_date=escape($("#lssue_date").val());
			query.expiry_date=escape($("#expiry_date").val());
			query.marital=escape($("#marital").val());
			query.mobile=escape($("#mobile").val());
			query.city=escape($("#city").val());
			query.industry=escape($("#industry").val());
			query.postcodes=escape($("#postcodes").val());
			query.email=escape($("#email").val());
			query.address=escape($("#address").val());
			query.bank_info=escape($("#bank_info").val());
			query.bank_account=escape($("#bank_account").val());
			query.notify=escape($("#notify").val());
			query.remarks=escape($("#remarks").val());
			query.emergency_name=escape($("#emergency_name").val());
			query.emergency_title=escape($("#emergency_title").val());
			query.emergency_sex=escape($("#emergency_sex").val());
			query.emergency_birth_date=escape($("#emergency_birth_date").val());
			query.emergency_passport=escape($("#emergency_passport").val());
			query.emergency_mobile=escape($("#emergency_mobile").val());
			query.emergency_tel=escape($("#emergency_tel").val());
			query.emergency_email=escape($("#emergency_email").val());
			query.emergency_address=escape($("#emergency_address").val());
			query.custome_source=custome_source;
			query.channel_name=escape($("#channel_name").val());
			query.recommend=escape($("#recommend").val());
			query.action="add";
			$.ajax({
				url: "save_customers.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_customer_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_custome_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_customers.asp";
				   }
				}
			});
		}
	});



	$("#edit_custome_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入姓名");
		}
		if($.trim($("#birth_date").val()).length == 0){
			tosubmit=false;
			$("#birth_date_err").html("请选择出生日期");
		}
		if($.trim($("#passport").val()).length == 0){
			tosubmit=false;
			$("#passport_err").html("请输入身份证（护照号）");
		}
		if($.trim($("#lssue_date").val()).length == 0){
			tosubmit=false;
			$("#lssue_date_err").html("请选择签发日期");
		}
		if($.trim($("#expiry_date").val()).length == 0){
			tosubmit=false;
			$("#expiry_date_err").html("请选择失效日期");
		}
		if($.trim($("#mobile").val()).length == 0){
			tosubmit=false;
			$("#mobile_err").html("请输入联系电话");
		}
		if($.trim($("#city").val()).length == 0){
			tosubmit=false;
			$("#city_err").html("请输入工作城市");
		}
		if($.trim($("#postcodes").val()).length == 0){
			tosubmit=false;
			$("#postcodes_err").html("请输入邮政编码");
		}
		if($.trim($("#address").val()).length == 0){
			tosubmit=false;
			$("#address_err").html("请输入通讯地址");
		}
		if($.trim($("#bank_info").val()).length == 0){
			tosubmit=false;
			$("#bank_info_err").html("请输入开户行");
		}
		if($.trim($("#bank_account").val()).length == 0){
			tosubmit=false;
			$("#bank_account_err").html("请输入银行账号");
		}
		if($.trim($("#emergency_name").val()).length == 0){
			tosubmit=false;
			$("#emergency_name_err").html("请输入紧急联系人姓名");
		}
		if($.trim($("#emergency_title").val()).length == 0){
			tosubmit=false;
			$("#emergency_title_err").html("请输入紧急联系人称呼");
		}
		if($.trim($("#emergency_mobile").val()).length == 0){
			tosubmit=false;
			$("#emergency_mobile_err").html("请输入紧急联系人移动电话");
		}
		var custome_source ="";   
		$('input[name="custome_source"]:checked').each(function(){    
		   custome_source=$(this).val();     
		}); 
		if(custome_source=="other"){
			custome_source=$("#custome_source_other").val()
		}
		if(custome_source==""){
			tosubmit=false;
			$("#custome_source_err").html("请选择客户来源");
		}
		if($.trim($("#channel_name").val()).length == 0){
			tosubmit=false;
			$("#channel_name_err").html("请输入渠道名称");
		}
		if($.trim($("#recommend").val()).length == 0){
			tosubmit=false;
			$("#recommend_err").html("请输入推荐人");
		}
		if(tosubmit){
			$("#edit_custome_submit").attr("disabled",true);
			var query = new Object();
			query.id=escape($("#id").val());
			query.full_name=escape($("#full_name").val());
			query.sex=escape($("#sex").val());
			query.birth_date=escape($("#birth_date").val());
			query.passport=escape($("#passport").val());
			query.lssue_date=escape($("#lssue_date").val());
			query.expiry_date=escape($("#expiry_date").val());
			query.marital=escape($("#marital").val());
			query.mobile=escape($("#mobile").val());
			query.city=escape($("#city").val());
			query.industry=escape($("#industry").val());
			query.postcodes=escape($("#postcodes").val());
			query.email=escape($("#email").val());
			query.address=escape($("#address").val());
			query.bank_info=escape($("#bank_info").val());
			query.bank_account=escape($("#bank_account").val());
			query.notify=escape($("#notify").val());
			query.remarks=escape($("#remarks").val());
			query.emergency_name=escape($("#emergency_name").val());
			query.emergency_title=escape($("#emergency_title").val());
			query.emergency_sex=escape($("#emergency_sex").val());
			query.emergency_birth_date=escape($("#emergency_birth_date").val());
			query.emergency_passport=escape($("#emergency_passport").val());
			query.emergency_mobile=escape($("#emergency_mobile").val());
			query.emergency_tel=escape($("#emergency_tel").val());
			query.emergency_email=escape($("#emergency_email").val());
			query.emergency_address=escape($("#emergency_address").val());
			query.custome_source=custome_source;
			query.channel_name=escape($("#channel_name").val());
			query.recommend=escape($("#recommend").val());
			query.action="edit";
			$.ajax({
				url: "save_customers.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#edit_custome_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#edit_custome_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_customers.asp";
				   }
				}
			});
		}
	});


	$(".custome_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_customers.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_customers.asp";
				   }
				}
			});
		}
	});
	
	


	$("#add_creditor_right_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入借款人姓名");
		}
		if($.trim($("#passport").val()).length == 0){
			tosubmit=false;
			$("#passport_err").html("请输入借款人身份证号");
		}
		if($.trim($("#job").val()).length == 0){
			tosubmit=false;
			$("#job_err").html("请输入借款人职业");
		}
		if($.trim($("#collateral_class").val()).length == 0){
			tosubmit=false;
			$("#collateral_class_err").html("请选择抵押物类别");
		}
		if($.trim($("#collateral").val()).length == 0){
			tosubmit=false;
			$("#collateral_err").html("请输入抵押物");
		}
		if($.trim($("#collateral_value").val()).length == 0){
			tosubmit=false;
			$("#collateral_value_err").html("请输入抵押物价值");
		}
		if($.trim($("#creditor_right_value").val()).length == 0){
			tosubmit=false;
			$("#creditor_right_value_err").html("请输入借款金额");
		}
		if($.trim($("#repayment_date").val()).length == 0){
			tosubmit=false;
			$("#repayment_date_err").html("请选择还款日期");
		}
		if($.trim($("#passport_img").val()).length == 0){
			tosubmit=false;
			$("#passport_img_err").html("请上传身份证照片");
		}
		if($.trim($("#property_card").val()).length == 0){
			tosubmit=false;
			$("#property_card_err").html("请上传房产证照片");
		}
		if($.trim($("#notarization").val()).length == 0){
			tosubmit=false;
			$("#notarization_err").html("请上传公证书照片");
		}
		if($.trim($("#IOU_receipt").val()).length == 0){
			tosubmit=false;
			$("#IOU_receipt_err").html("请上传借据、收据照片");
		}
		if($.trim($("#contract").val()).length == 0){
			tosubmit=false;
			$("#contract_err").html("请上传借款合同照片");
		}
		if($.trim($("#other_evidence").val()).length == 0){
			tosubmit=false;
			$("#other_evidence_err").html("请上传他证照片");
		}
		if(tosubmit){
			$("#add_creditor_right_submit").attr("disabled",true);
			var query = new Object();
			query.full_name=escape($("#full_name").val());
			query.passport=escape($("#passport").val());
			query.job=escape($("#job").val());
			query.collateral_class=escape($("#collateral_class").val());
			query.collateral=escape($("#collateral").val());
			query.collateral_value=escape($("#collateral_value").val());
			query.creditor_right_value=escape($("#creditor_right_value").val());
			query.repayment_date=escape($("#repayment_date").val());
			query.passport_img=escape($("#passport_img").val());
			query.property_card=escape($("#property_card").val());
			query.notarization=escape($("#notarization").val());
			query.IOU_receipt=escape($("#IOU_receipt").val());
			query.contract=escape($("#contract").val());
			query.other_evidence=escape($("#other_evidence").val());
			query.action="add";
			$.ajax({
				url: "save_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_creditor_right.asp";
				   }
				}
			});
		}
	});



	$("#edit_creditor_right_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入借款人姓名");
		}
		if($.trim($("#passport").val()).length == 0){
			tosubmit=false;
			$("#passport_err").html("请输入借款人身份证号");
		}
		if($.trim($("#job").val()).length == 0){
			tosubmit=false;
			$("#job_err").html("请输入借款人职业");
		}
		if($.trim($("#collateral_class").val()).length == 0){
			tosubmit=false;
			$("#collateral_class_err").html("请选择抵押物类别");
		}
		if($.trim($("#collateral").val()).length == 0){
			tosubmit=false;
			$("#collateral_err").html("请输入抵押物");
		}
		if($.trim($("#collateral_value").val()).length == 0){
			tosubmit=false;
			$("#collateral_value_err").html("请输入抵押物价值");
		}
		if($.trim($("#creditor_right_value").val()).length == 0){
			tosubmit=false;
			$("#creditor_right_value_err").html("请输入借款金额");
		}
		if($.trim($("#repayment_date").val()).length == 0){
			tosubmit=false;
			$("#repayment_date_err").html("请选择还款日期");
		}
		if($.trim($("#passport_img").val()).length == 0){
			tosubmit=false;
			$("#passport_img_err").html("请上传身份证照片");
		}
		if($.trim($("#property_card").val()).length == 0){
			tosubmit=false;
			$("#property_card_err").html("请上传房产证照片");
		}
		if($.trim($("#notarization").val()).length == 0){
			tosubmit=false;
			$("#notarization_err").html("请上传公证书照片");
		}
		if($.trim($("#IOU_receipt").val()).length == 0){
			tosubmit=false;
			$("#IOU_receipt_err").html("请上传借据、收据照片");
		}
		if($.trim($("#contract").val()).length == 0){
			tosubmit=false;
			$("#contract_err").html("请上传借款合同照片");
		}
		if($.trim($("#other_evidence").val()).length == 0){
			tosubmit=false;
			$("#other_evidence_err").html("请上传他证照片");
		}
		if(tosubmit){
			$("#edit_creditor_right_submit").attr("disabled",true);
			var query = new Object();
			query.id=escape($("#id").val());
			query.full_name=escape($("#full_name").val());
			query.passport=escape($("#passport").val());
			query.job=escape($("#job").val());
			query.collateral_class=escape($("#collateral_class").val());
			query.collateral=escape($("#collateral").val());
			query.collateral_value=escape($("#collateral_value").val());
			query.creditor_right_value=escape($("#creditor_right_value").val());
			query.passport_img=escape($("#passport_img").val());
			query.repayment_date=escape($("#repayment_date").val());
			query.property_card=escape($("#property_card").val());
			query.notarization=escape($("#notarization").val());
			query.IOU_receipt=escape($("#IOU_receipt").val());
			query.contract=escape($("#contract").val());
			query.other_evidence=escape($("#other_evidence").val());
			query.action="edit";
			$.ajax({
				url: "save_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#edit_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#edit_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_creditor_right.asp";
				   }
				}
			});
		}
	});


	$(".creditor_right_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[3];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_creditor_right.asp";
				   }
				}
			});
		}
	});


	$(".creditor_right_approval").click(function(){
		if(confirm('是否确定审批？')){
	 		var id=this.id.split("_")[3];
			var query = new Object();
			query.id=id;
			query.action="approval";
			$.ajax({
				url: "save_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("审批成功！");
						window.location.href="approval_creditor_right.asp";
				   }
				}
			});
		}
	});


	$("#approval_creditor_right_submit").click(function(){
		if(confirm('是否确定审批？')){
		var tosubmit=true;
		if(tosubmit){
			$("#approval_creditor_right_submit").attr("disabled",true);
			var query = new Object();
			query.id=escape($("#id").val());
			query.action="approval";
			$.ajax({
				url: "save_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("审批成功！");
						window.location.href="approval_creditor_right.asp";
				   }
				}
			});
		}
		}
	});


	$("#creditor_right_approvals").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择待审批债权！'); 
	  }else{
		  if (confirm("是否确定批量审批？")){		  
			var query = new Object();
			query.ids=""+chk_value;
			query.action="approvals";
			$.ajax({
				url: "save_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("批量审批成功！");
						window.location.href="approval_creditor_right.asp";
				   }
				}
			});
		  }
	  }

	});	


	$("#attorn_creditor_right_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#cid").val()).length == 0){
			tosubmit=false;
			$("#cid_err").html("请选择客户身份证号或姓名");
		}
		if($.trim($("#number").val()).length == 0){
			tosubmit=false;
			$("#number_err").html("请输入合同编号");
		}
		if($.trim($("#product_name").val()).length == 0){
			tosubmit=false;
			$("#product_name_err").html("请选择理财产品");
		}
		if($.trim($("#capital").val()).length == 0){
			tosubmit=false;
			$("#capital_err").html("请输入初始理财金额");
		}
		if($.trim($("#start_date").val()).length == 0){
			tosubmit=false;
			$("#start_date_err").html("请选择初始理财日期");
		}
		if(tosubmit){
			$("#attorn_creditor_right_submit").attr("disabled",true);
			var query = new Object();
			query.cid=escape($("#cid").val());
			query.number=escape($("#number").val());
			query.product_name=escape($("#product_name").val());
			query.capital=escape($("#capital").val());
			query.start_date=escape($("#start_date").val());
			query.creditor_right_amount=escape($("#creditor_right_amount").val());
			query.action="add";
			$.ajax({
				url: "save_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#attorn_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#attorn_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						var data1=data.split("|")[1];
						var data2=data1.split("/");
						for(var i=0;i<data2.length;i++){
							$("#creditor_right_detailed").append("<tr align='center' class='old_creditor_right_detailed'><td>"+data2[i].split(";")[0]+"</td><td>"+data2[i].split(";")[1]+"</td><td>"+data2[i].split(";")[2]+"</td></tr>"); 
						}
					   $("#id").val(data.split("|")[2]);
					   $("#creditor_right_detailed_div").show();
					   $("#attorn_creditor_right_submit").hide();
					   $("#confirm_attorn_creditor_right_submit").show();
					   $("#edit_attorn_creditor_right_submit").show();
				   }
				}
			});
		}
	});

	$("#edit_attorn_creditor_right_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#cid").val()).length == 0){
			tosubmit=false;
			$("#cid_err").html("请选择客户身份证号或姓名");
		}
		if($.trim($("#number").val()).length == 0){
			tosubmit=false;
			$("#number_err").html("请输入合同编号");
		}
		if($.trim($("#product_name").val()).length == 0){
			tosubmit=false;
			$("#product_name_err").html("请选择理财产品");
		}
		if($.trim($("#capital").val()).length == 0){
			tosubmit=false;
			$("#capital_err").html("请输入初始理财金额");
		}
		if($.trim($("#start_date").val()).length == 0){
			tosubmit=false;
			$("#start_date_err").html("请选择初始理财日期");
		}
		if(tosubmit){
			$("#edit_attorn_creditor_right_submit").attr("disabled",true);
			var query = new Object();
			query.cid=escape($("#cid").val());
			query.number=escape($("#number").val());
			query.product_name=escape($("#product_name").val());
			query.capital=escape($("#capital").val());
			query.start_date=escape($("#start_date").val());
			query.creditor_right_amount=escape($("#creditor_right_amount").val());
			query.id=escape($("#id").val());
			query.action="edit";
			$.ajax({
				url: "save_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#edit_attorn_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#edit_attorn_creditor_right_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
					   $(".old_creditor_right_detailed").remove();
						var data1=data.split("|")[1];
						var data2=data1.split("/");
						for(var i=0;i<data2.length;i++){
							$("#creditor_right_detailed").append("<tr align='center' class='old_creditor_right_detailed'><td>"+data2[i].split(";")[0]+"</td><td>"+data2[i].split(";")[1]+"</td><td>"+data2[i].split(";")[2]+"</td></tr>"); 
						}
					   $("#edit_attorn_creditor_right_submit").attr("disabled",false);
					   $("#creditor_right_detailed_div").show();
					   //$("#edit_attorn_creditor_right_submit").hide();
					   $("#confirm_attorn_creditor_right_submit").show();
				   }
				}
			});
		}
	});


	$(".attorn_creditor_right_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[4];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_attorn_creditor_right.asp";
				   }
				}
			});
		}
	});




	$("#confirm_attorn_creditor_right_submit").click(function(){
			alert("债权转让分配成功，请等待审批！");
			window.location.href="manage_attorn_creditor_right.asp";
	});



	$(".attorn_creditor_right_approval").click(function(){
		if(confirm('是否确定审批？')){
	 		var id=this.id.split("_")[4];
			var query = new Object();
			query.id=id;
			query.action="approval";
			$.ajax({
				url: "save_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("审批成功！");
						window.location.href="approval_attorn_creditor_right.asp";
				   }
				}
			});
		}
	});


	$("#approval_attorn_creditor_right_submit").click(function(){
		if(confirm('是否确定审批？')){
		var tosubmit=true;
		if(tosubmit){
			$("#approval_attorn_creditor_right_submit").attr("disabled",true);
			var query = new Object();
			query.id=escape($("#id").val());
			query.action="approval";
			$.ajax({
				url: "save_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("审批成功！");
						window.location.href="approval_attorn_creditor_right.asp";
				   }
				}
			});
		}
		}
	});


	$("#attorn_creditor_right_approvals").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择待审批债权转让！'); 
	  }else{
		  if (confirm("是否确定批量审批？")){		  
			var query = new Object();
			query.ids=""+chk_value;
			query.action="approvals";
			$.ajax({
				url: "save_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("批量审批成功！");
						window.location.href="approval_attorn_creditor_right.asp";
				   }
				}
			});
		  }
	  }

	});	


	$("#print_creditor_right_approvals").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择需打印的债权转让！'); 
	  }else{
		 var a = $("<a href='attorn_agreement.asp?ids="+chk_value+"' target='_blank'>print</a>").get(0);
         var e = document.createEvent('MouseEvents');
         e.initEvent( 'click', true, true );
         a.dispatchEvent(e);
	  }
	});

	$("#print_monthly_bill").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择需打印的账单！'); 
	  }else{
		 var a = $("<a href='monthly_bill.asp?ids="+chk_value+"' target='_blank'>print</a>").get(0);
         var e = document.createEvent('MouseEvents');
         e.initEvent( 'click', true, true );
         a.dispatchEvent(e);
	  }
	});

	$(".redeem_attorn_creditor_right").click(function(){
		if(confirm('是否确定提交赎回申请？')){
	 		var id=this.id.split("_")[4];
			var query = new Object();
			query.id=id;
			query.action="redeem";
			$.ajax({
				url: "save_redeem_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("赎回申请成功，等待审批！");
						window.location.href="redeem_attorn_creditor_right.asp";
				   }
				}
			});
		}
	});

	$("#redeems_attorn_creditor_right").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择需要赎回的债权转让！'); 
	  }else{
		  if (confirm("是否确定批量提交赎回申请？")){		  
			var query = new Object();
			query.ids=""+chk_value;
			query.action="redeems";
			$.ajax({
				url: "save_redeem_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("批量赎回申请成功，等待审批！");
						window.location.href="redeem_attorn_creditor_right.asp";
				   }
				}
			});
		  }
	  }

	});	




	$(".redeem_attorn_creditor_right_approval").click(function(){
		if(confirm('是否确定审批？')){
	 		var id=this.id.split("_")[5];
			var query = new Object();
			query.id=id;
			query.action="approval";
			$.ajax({
				url: "save_redeem_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("审批成功！");
						window.location.href="approval_redeem_attorn_creditor_right.asp";
				   }
				}
			});
		}
	});

	$("#redeem_attorn_creditor_right_approvals").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择待审批债权转让赎回申请！'); 
	  }else{
		  if (confirm("是否确定批量审批？")){		  
			var query = new Object();
			query.ids=""+chk_value;
			query.action="approvals";
			$.ajax({
				url: "save_redeem_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("批量审批成功！");
						window.location.href="approval_redeem_attorn_creditor_right.asp";
				   }
				}
			});
		  }
	  }

	});	


	$(".cancel_redeem").click(function(){
		if(confirm('是否确定取消该赎回申请？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="cancel_redeem";
			$.ajax({
				url: "save_redeem_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("取消赎回申请成功！");
						window.location.href="manage_redeem.asp";
				   }
				}
			});
		}
	});

	$("#cancel_redeems").click(function(){
	  var chk_value =[];    
	  $('input[name="subBox"]:checked').each(function(){    
	   chk_value.push($(this).val());    
	  }); 
	  if(chk_value.length==0){
	  	alert('请选择需取消的赎回申请！'); 
	  }else{
		  if (confirm("是否确定批量取消赎回申请？")){		  
			var query = new Object();
			query.ids=""+chk_value;
			query.action="cancel_redeems";
			$.ajax({
				url: "save_redeem_attorn_creditor_right.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("批量取消赎回申请成功！");
						window.location.href="manage_redeem.asp";
				   }
				}
			});
		  }
	  }

	});	


	$(".user_bonus_proportion").click(function(){
	 	var id=this.id.split("_")[3];
		var tosubmit=true;
		if($.trim($("#bonus_proportion"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入年化提成比例");
		}
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.bonus_proportion=$.trim($("#bonus_proportion"+id).val());
			query.action="user";
			$.ajax({
				url: "save_bonus_proportion.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("设置提成比例成功！");
						window.location.href="manage_"+query.action+"_bonus_proportion.asp";
				   }
				}
			});
		}
	});



	$(".jobs_bonus_proportion").click(function(){
	 	var id=this.id.split("_")[3];
		var tosubmit=true;
		if($.trim($("#bonus_proportion"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入年化提成比例");
		}
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.bonus_proportion=$.trim($("#bonus_proportion"+id).val());
			query.action="jobs";
			$.ajax({
				url: "save_bonus_proportion.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("设置提成比例成功！");
						window.location.href="manage_"+query.action+"_bonus_proportion.asp";
				   }
				}
			});
		}
	});


	$(".companys_bonus_proportion").click(function(){
	 	var id=this.id.split("_")[3];
		var tosubmit=true;
		if($.trim($("#bonus_proportion"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入年化提成比例");
		}
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.bonus_proportion=$.trim($("#bonus_proportion"+id).val());
			query.action="companys";
			$.ajax({
				url: "save_bonus_proportion.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("设置提成比例成功！");
						window.location.href="manage_"+query.action+"_bonus_proportion.asp";
				   }
				}
			});
		}
	});

	$(".customer_tracking_mobile").blur(function(){
		var mobile=$.trim($(".customer_tracking_mobile").val());
		var tosubmit=true;
		if($.trim($("#mobile").val()).length == 0){
			tosubmit=false;
			$("#mobile_err").html("请输入联系电话");
		}
		if(tosubmit){
			var query = new Object();
			query.mobile=mobile;
			$.ajax({
				url: "chack_customer_tracking_mobile.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						$("#mobile_err").html("");
				   }
				}
			});
		}
	});

	$("#add_target_customers_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#full_name").val()).length == 0){
			tosubmit=false;
			$("#full_name_err").html("请输入姓名");
		}
		if($.trim($("#mobile").val()).length == 0){
			tosubmit=false;
			$("#mobile_err").html("请输入联系电话");
		}
		var custome_source ="";   
		$('input[name="custome_source"]:checked').each(function(){    
		   custome_source=$(this).val();     
		}); 
		if(custome_source=="other"){
			custome_source=$("#custome_source_other").val()
		}
		if(custome_source==""){
			tosubmit=false;
			$("#custome_source_err").html("请选择客户来源");
		}
		if(tosubmit){
			$("#add_target_customers_submit").attr("disabled",true);
			var query = new Object();
			query.full_name=escape($("#full_name").val());
			query.mobile=escape($("#mobile").val());
			query.custome_source=custome_source;
			query.action="add";
			$.ajax({
				url: "save_target_customers.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_target_customers_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_target_customers_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="customer_tracking.asp";
				   }
				}
			});
		}
	});



	$(".transfer").click(function(){
	 		var id=this.id.split("_")[1];
			var query = new Object();
			query.id=id;
			query.action="transfer";
			$.ajax({
				url: "save_target_customers.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("转移成功！");
						window.location.href="customer_tracking.asp";
				   }
				}
			});
	});


	$(".del_target_customer").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[3];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_target_customers.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="customer_tracking.asp";
				   }
				}
			});
		}
	});

	$("#tc_id").change(function(){
		if($("#tc_id").val()!=""){
			var full_name=$("#tc_id").val().split("|")[0];
			var mobile=$("#tc_id").val().split("|")[1];
			var custome_source=$("#tc_id").val().split("|")[2];
			$("#full_name").val(full_name);
			$("#mobile").val(mobile);
			if(custome_source=="市场活动" || custome_source=="老客户推荐" || custome_source=="自有资源" || custome_source=="渠道"){
				$("input[name='custome_source']").val([custome_source]);
				$("#custome_source_other").val("");
			}else{
				$("input[name='custome_source']").val(["other"]);
				$("#custome_source_other").val(custome_source);
			}
		}
	});
	
	
	
	$("#add_collateral_class_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#collateral_class_name").val()).length == 0){
			tosubmit=false;
			$("#collateral_class_name_err").html("请输入债权分类名称");
		}
		if(tosubmit){
			$("#add_collateral_class_submit").attr("disabled",true);
			var query = new Object();
			query.collateral_class_name=escape($("#collateral_class_name").val());
			query.action="add";
			$.ajax({
				url: "save_collateral_class.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_collateral_class_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_collateral_class_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_collateral_class.asp";
				   }
				}
			});
		}
	});



	$(".collateral_class_edit").click(function(){
	 	var id=this.id.split("_")[3];
		var tosubmit=true;
		if($.trim($("#collateral_class_name"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入债权分类名称");
		}
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.collateral_class_name=escape($("#collateral_class_name"+id).val());
			query.action="edit";
			$.ajax({
				url: "save_collateral_class.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("修改成功！");
						window.location.href="manage_collateral_class.asp";
				   }
				}
			});
		}

	});

	$(".collateral_class_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[3];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_collateral_class.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {
						alert(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("删除成功！");
						window.location.href="manage_collateral_class.asp";
				   }
				}
			});
		}
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});

function isEmail(str){
res = /^[0-9a-zA-Z_\-\.]+@[0-9a-zA-Z_\-]+(\.[0-9a-zA-Z_\-]+)*$/;
var re = new RegExp(res);
return !(str.match(re) == null);
}
function isusername(str){
	var res=/^[_a-zA-Z0-9\u4e00-\u9fa5]+$/;
	var re = new RegExp(res);
	return !(str.match(re) == null);
}
function onlyshu(str,str1){
	str.value=str1.replace(/\D/g,'');
}

function onlymoney(str,str1){
	str.value=str1.replace(/[^\d\.]/g,'');
}
function isNumber(s){
	var patrn=/\D/;  
	if (patrn.exec(s)) return false  
	return true  
}

function ismoney(s){
	var patrn=/[^\d\.]/g;  
	if (patrn.exec(s)) return false  
	return true  
}
function isTel(s){  
	var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;  
	if (!patrn.exec(s)) return false  
	return true  
}  

function isPostalCode(s){  
	var patrn=/^[a-zA-Z0-9\- ]{3,12}$/;  
	if (!patrn.exec(s)) return false  
	return true  
}  

function isEn(s){  
	var patrn=/^\w+|\s+$/;  
	if (!patrn.exec(s)) return false  
	return true  
}  

function is6pwd(s){  
	var patrn=/^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,}$/;  
	if (!patrn.exec(s)) return false  
	return true  
}  



function copyInfo()
{
            $('#to_local').val($('#to').val());
            $('#recipient_country_local').val($('#recipient_country').val());
            $('#recipient_province_local').val($('#recipient_province').val());
            $('#recipient_city_local').val($('#recipient_city').val());
            $('#recipient_addres_local').val($('#recipient_addres').val());

}

function delxls(xls){
			var query = new Object();
			query.xls=xls;
			$.ajax({
				url: "../delxls.asp",
				type:"post",
				data:query,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				}
			});
}

function check_all(str,str1){
	var a=document.getElementsByName(str);
	var b=document.getElementsByName(str1);
   if(a[0].checked==true){
   for (var i=0; i<b.length; i++)
      b[i].checked = true;
   }
   else if(a[0].checked==false)
   {
   for (var i=0; i<b.length; i++)
      b[i].checked = false;
   }
}