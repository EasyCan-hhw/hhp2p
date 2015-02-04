$(document).ready( function() {




	//失去焦点控制
$("input").blur(function (){
	var id=$(this).attr("id");//根据input的id获取对应input
	if (id == "result_number") {
		
		var query = new Object();
			query.myvalue = escape($("#"+id).val());
			query.action="sele";

			$.ajax({
				url: "save_add_results.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
					//alert(data);
				  if(parseInt(data.split("|")[0])==1)
				  {
						$("#job_number_err").html(data.split("|")[2]);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
					 $("#result_number_err").html(data.split("|")[1]);
					 $("#result_name").val(""); 

				   }
				   else if(parseInt(data.split("|")[0])==4)
				   {
				   	$("#result_name").val(data.split("|")[1]);
				   	$("#result_number_err").html(" ");
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
							
				   }
				}
			});

	};
});
	//线上员工业绩添加  

	$("#add_user_result_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#result_number").val()).length == 0)
		{
			tosubmit = false
			$("#result_number_err").html("工号有误")
		}
		if($.trim($("#result_name").val()).length == 0){
			tosubmit=false;
			//$("#result_name_err").html("请填写正确的工号");
		}
		if($.trim($("#result_product").val()).length == 0){
			tosubmit=false;
			$("#result_product_err").html("请选择理财产品");
		}
		if($.trim($("#result_capital").val()).length == 0 ){
			tosubmit=false;
			$("#result_capital_err").html("请填写理财金额");
		}
		if(tosubmit){
			$("#add_user_result_submit").attr("disabled",true);
			var query = new Object();
			query.Cjob_number=escape($("#Cjob_number").val());
			query.Cjob_number=escape($("#Cjob_number").val());
			query.Cjob_number=escape($("#Cjob_number").val());

			query.action="add";
			$.ajax({
				url: "save_manage_commission.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {		
				  		alert(data.split("|")[2])
						//$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_user_result_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_user_result_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
				   	$("#add_user_result_submit").attr("disabled",true);
						alert("添加成功！");
						window.location.href="manage_commission_set.asp";
				   }
				}
			});
		}
	});





	//提成加薪添加
	$("#add_commission_manage_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#Cjob_number").val()).length == 0){
			tosubmit=false;
			$("#Cjob_number_err").html("请输入工号");
		}
		if($.trim($("#Cdate").val()).length == 0){
			tosubmit=false;
			$("#Cdate_err").html("请输入月份");
		}
		if($.trim($("#Cjixiao").val()).length == 0 && $.trim($("#Cchargehand").val()).length == 0){
			tosubmit=false;
			$("#Cjixiao_err").html("请输入一项奖金");
		}
		
		var setDate = $("#Cdate").val()
		var test = setDate.split("-")[0]+"-"+setDate.split("-")[1]
		
		if(tosubmit){
			$("#add_commission_manage_submit").attr("disabled",true);
			var query = new Object();
			query.Cjob_number=escape($("#Cjob_number").val());
			query.Cmdate=escape(test);

			if ($.trim($("#Cjixiao").val()).length == 0) {
				query.Cjixiao=escape(0);
				query.Cchargehand=escape($("#Cchargehand").val());
			}else if ($.trim($("#Cchargehand").val()).length == 0) {
				query.Cjixiao=escape($("#Cjixiao").val());
				query.Cchargehand=escape(0);
			}
			
			query.action="add";
			$.ajax({
				url: "save_manage_commission.asp",
				type:"post",
				data:query,
				async:false,
				cache:false,
				dataType:"text",
				success:function(data)
				{
				  if(parseInt(data.split("|")[0])==1)
				  {		
				  		alert(data.split("|")[2])
						//$("#"+data.split("|")[1]+"_err").html(data.split("|")[2]);
						$("#add_commission_manage_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#add_commission_manage_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
				   	$("#add_commission_manage_submit").attr("disabled",true);
						alert("添加成功！");
						window.location.href="manage_commission_set.asp";
				   }
				}
			});
		}
	});
	
	$(".commission_del").click(function(){
		if(confirm('是否确定删除？')){
	 		var id=this.id.split("_")[2];
			var query = new Object();
			query.id=id;
			query.action="del";
			$.ajax({
				url: "save_manage_commission.asp",
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
						window.location.href="manage_commission_set.asp";
				   }
				}
			});
		}
	});

	$(".commission_edit").click(function(){
	 	var id=this.id.split("_")[2];
		var tosubmit=true;
		if($.trim($("#Cjixiao_"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入信息");
		}
		if($.trim($("#Cchargehand_"+id).val()).length == 0){
			tosubmit=false;
			alert("请输入信息");
		}
		
		if(tosubmit){
			var query = new Object();
			query.id=id;
			query.Cjixiao=escape($("#Cjixiao_"+id).val());
			query.Cchargehand=escape($("#Cchargehand_"+id).val());
			query.action="edit";
			$.ajax({
				url: "save_manage_commission.asp",
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
						window.location.href="manage_commission_set.asp";
				   }
				}
			});
		}

	});



	//作息时间添加
	$("#insert_setrest_submit").click(function(){
		var tosubmit=true;
		$(".err_text").html("");
		if($.trim($("#setrest_year").val()).length == 0){
			tosubmit=false;
			$("#setrest_year_err").html("请填写年份");
		}else if ($.trim($("#setrest_year").val()).length > 4) {
			tosubmit=false
			$("#setrest_year_err").html("请填写正确的年份")
		}
		if($.trim($("#setrest_month").val()).length == 0){
			tosubmit=false;
			$("#setrest_month_err").html("请填写月份");
		}else if ($.trim($("#setrest_month").val()).length > 2) {
			tosubmit=false
			$("#setrest_month_err").html("请填写正确的月份")
		}
		if($.trim($("#start_work_hour").val()).length == 0){
			tosubmit=false;
			$("#start_work_hour_err").html("请填写时间");
		}else if ($("#start_work_hour").val() > 24 || $("#start_work_hour").val() < 0 ) {
			tosubmit=false;
			$("#start_work_hour_err").html("请填写正确的时间");
		}
		if($.trim($("#start_work_minute").val()).length == 0){
			tosubmit=false;
			$("#start_work_minute_err").html("请填写时间");
		}else if ($("#start_work_minute").val() > 60 || $("#start_work_minute").val() < 0 ) {
			tosubmit=false;
			$("#start_work_minute_err").html("请填写正确的时间");
		}
		if($.trim($("#end_work_hour").val()).length == 0){
			tosubmit=false;
			$("#end_work_hour_err").html("请填写时间");
		}else if ($("#end_work_hour").val() > 24 || $("#end_work_hour").val() < 0 ) {
			tosubmit=false;
			$("#end_work_hour_err").html("请填写正确的时间");
		}
		if($.trim($("#end_work_minute").val()).length == 0){
			tosubmit=false;
			$("#end_work_minute_err").html("请填写时间");
		}else if ($("#end_work_minute").val() > 60 || $("#end_work_minute").val() < 0 ) {
			tosubmit=false;
			$("#end_work_minute_err").html("请填写正确的时间");
		}
		if(tosubmit){
			$("#insert_setrest_submit").attr("disabled",true);
			var query = new Object();
			if ($.trim($("#setrest_month").val()).length == 1) {
				query.setrest_year=escape($("#setrest_year").val()+"-0"+$("#setrest_month").val());//年份拼写
			}else{
				query.setrest_year=escape($("#setrest_year").val()+"-"+$("#setrest_month").val());//年份拼写
			}
			query.setrest_starttime=escape($("#start_work_hour").val()*60+parseInt($("#start_work_minute").val()));//时间换算成分钟
			query.setrest_endtime=escape($("#end_work_hour").val()*60+parseInt($("#end_work_minute").val()));//时间换算成分钟
			query.setrest_cause=escape($("#setrest_cause").val());
			query.action="add";
			$.ajax({
				url: "save_setrest.asp",
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
						$("#insert_setrest_submit").attr("disabled",false);
				  }
				   else if(parseInt(data.split("|")[0])==3)
				   {
						alert(data.split("|")[1]);
						$("#insert_setrest_submit").attr("disabled",false);
				   }
				   else if(parseInt(data.split("|")[0])==2)
				   {
						alert("登录超时！");
						window.location.href="login.asp";
				   }
				   else if(parseInt(data.split("|")[0])==0)
				   {
						alert("添加成功！");
						window.location.href="manage_work_setrest.asp";
				   }
				}
			});
		}
	});



	
	 //作息时间删除
	$(".setrest_del").click(function(){

			if(confirm('是否确定删除？')){
		 		var id=this.id.split("_")[2];
				var query = new Object();
				query.sid=id;
				query.action="del";
				$.ajax({
					url: "save_setrest.asp",
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
							window.location.href="manage_work_setrest.asp";
					   }
					}
				});
			}



});

	
});