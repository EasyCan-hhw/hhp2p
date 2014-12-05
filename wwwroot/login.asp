<%
if request.cookies("hhp2p_cookies")("uid")<>"" then
	response.redirect("index.asp")
end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>《行行贷》ERP系统登录</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="css/matrix-login.css" />
    <link href="css/font-awesome.css" rel="stylesheet" />
<script src="js/jquery-1.4.2.min.js"></script>
<script src="js/login.js"></script>
</head>

<body>
<div id="loginbox">
    <form id="loginform" class="form-vertical" action="" style="border-top: none;" method="post">
        <div class="control-group normal_text">
            <h3><img src="img/logo.png" alt="Logo" /></h3>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_pp"><i class="icon-user"></i></span><input type="text" name="username" id="username" placeholder="用户名" />
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_pp"><i class="icon-lock"></i></span><input type="password" name="password" id="password" placeholder="密码" />
                </div>
            </div>
        </div>
        <div class="form-actions" style="border-top: none; text-align: center;">
            <a type="submit" href="javascript:;" class="btn btn-large btn-warning" id="login_submit_submit"/>登录</a>
        </div>
    </form>
</div>

</body>
</html>