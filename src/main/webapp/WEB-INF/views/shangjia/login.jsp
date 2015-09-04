<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>店家登陆</title>
    <link rel="stylesheet" href="/static/css/b3/bootstrap.css"/>
    <link rel="stylesheet" href="/static/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="/static/css/layout2.css" />
</head>
<body>
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <a class="navbar-brand" href="/"><i class="fa fa-maxcdn"></i> 美餐</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-danger">
                <div class="panel-heading">商家登录</div>
                <div class="panel-body">
                        <form method="post" id="loginForm">

                            <c:if test="${not empty message}">
                                <div class="alert alert-info">
                                    ${message}
                                </div>
                            </c:if>



                            <div class="form-group">
                                <label>手机号码</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="text" name="phone" class="form-control" id="phone"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>密码</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="password" name="password" class="form-control" id="password"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <button id="subBtn" type="button" class="btn btn-default">登录</button>
                                <a href="/account/password/reset?url=/shangjia/login">忘记密码</a>
                            </div>
                        </form>
                </div>
            </div>
        </div>
    </div>

</div>






<script src="/static/js/jquery.1.11.1.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="/static/js/bootbox.min.js"></script>
<script src="/static/js/jquery.validate.min.js"></script>
<script>


    $(function(){
    	var $phone = $("#phone");
    	var $password = $("#password");
    	
    	
    	var validatePhone = function(phone){
    		phone.parent().find("span").remove();
    		var temp1 = false;
    		console.log(phone.val());
    		var reg = new RegExp(/^1[3|4|5|8][0-9]\d{4,8}$/);
    		if(phone.val() == ''){
				phone.parent().append($('<span class=errorSpan>'+'请输入手机号'+'</span>'));
			}else if(!reg.test(phone.val()) || phone.val().length != 11){
				phone.parent().append($('<span class=errorSpan>'+'请输入正确的手机号格式'+'</span>'));
			}else{
				temp1 = true;
			}
    		console.log(temp1 + ' validatePhone ' + phone.val().length);
    		return temp1;
    	};
    	
    	var validatePassword = function(password){
    		password.parent().find("span").empty();
    		var temp2 = false;
    		if(password.val() == ''){
				password.parent().append($('<span class=errorSpan>'+'请输入密码'+'</span>'));
			}else if(password.val().length < 6){
				password.parent().append($('<span class=errorSpan>'+'密码长度大于6'+'</span>'));
			}else{
				temp2 = true;
			}
    		return temp2;
    	};
    	
        $("#subBtn").click(function(){
        	var tempflags = false;
			var resultPhone = validatePhone($phone);
			var resultPhone = validatePassword($password);
		if(resultPhone && resultPhone){
            var $btn = $(this);
             $.ajax({
                url:"/shangjia/login",
                method:"post",
                data:$("#loginForm").serialize(),
                success:function(result){
                    if(result.state == "success") {
                        window.location.href = "/shangjia/manage/home";
                    } else {
                        bootbox.alert(result.message);
                    }
                },
                beforeSend:function(){
                    $btn.text("登录中...");
                },
                complete:function(){
                    $btn.text("登录");
                },
                error:function(){
                    bootbox.alert("请求服务器错误");
                }
            });
          }
        });

    });
</script>
</body>
</html>