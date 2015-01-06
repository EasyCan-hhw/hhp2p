$(document).ready( function() {


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