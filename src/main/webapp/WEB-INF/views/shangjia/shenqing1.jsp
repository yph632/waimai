<%@ page language="java" contentType="text/html; charset=UTF-8}"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商家注册</title>
</head>
<link rel="stylesheet" href="/static/css/b3/bootstrap.min.css" />
<link rel="stylesheet" href="/static/css/font-awesome.min.css" />
<link rel="stylesheet" href="/static/css/layout2.css" />
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/"><i class="fa fa-maxcdn"></i> 美餐</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-danger">
                <div class="panel-heading">商家申请</div>
                <div class="panel-body">
					<form class="form-horizontal" id="shenqingform">
  						<div class="form-group">
    						<label for="phone" class="col-sm-2 control-label">手机号：</label>
    						<div class="col-sm-3">
      							<input type="text" name="phone" class="form-control" id="phone" placeholder="请输入手机号">
    						</div>
 					 	</div>
  						<div class="form-group">
    						<label for="codeinput" class="col-sm-2 control-label">注册码：</label>
   						 	<div class="col-sm-2">
      							<input type="text" name="code" class="form-control" id="codeinput" placeholder="请输入验证的注册码">
    						</div>
    						<button type="button" id="codebtn" class="btn btn-primary col-sm-1">获取注册码</button>
  						</div>
 
  						<div class="form-group">
    						<div class="col-sm-offset-2 col-sm-5">
      							<button id="subBtn" type="button" class="btn btn-success">提交验证</button>
    						</div>
  						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="/static/js/jquery-1.11.3.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="/static/js/bootbox.min.js"></script>
<script>
	$(document).ready(function(){
		var count = 60;
		
		var $phone = $("#phone");
		var $code = $("#codeinput");
		
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
    	
    	var validateCode = function(icode){
    		icode.parent().find("span").remove();
    		var temp2 = false;
    		if(icode.val() == ''){
				icode.parent().append($('<span class=errorSpan>'+'请输入6位验证码'+'</span>'));
			}else if(icode.val().length != 6){
				icode.parent().append($('<span class=errorSpan>'+'请正确输入6位验证码'+'</span>'));
			}else{
				temp2 = true;
			}
    		return temp2;
    	};
		
        $("#codebtn").click(function(){
            var $btn = $(this);
		
          if(validatePhone($phone)){

            $.ajax({
            	url:"/api/sms/validatecode",
            	method:"post",
            	data:{"phone":$("#phone").val()},
            	success:function(result){
            		if(result == "yes"){
            			 $btn.attr("disabled","disabled");
            	            var si = setInterval(function(){
            	                count--;
            	                if(count == 0) {
            	                    $btn.removeAttr("disabled");
            	                    count = 60;
            	                    clearInterval(si);
            	                    $btn.text("发送验证码");
            	                } else {
            	                    $btn.text("重新发送("+count+"秒)");
            	                }

            	            },1000);
            		}else{
            			bootbox.alert("该手机号已经注册为商家用户了");
            		}
            	},
            	error:function(){
                    alert("服务器请求错误");
                }
            	
            });
          }

        });


        $("#subBtn").click(function(){
			
            var $btn = $(this);
           if(validateCode($code) && validatePhone($phone)){
        	 	$btn.attr("disabled", "disabled");
            	$.ajax({
               		url:"/shangjia/step1",
                	method:"post",
                	data:$("#shenqingform").serialize(),
                	success:function(result){
                    	if(result.state == "success") {
                        	window.location.href="/shangjia/step2";
                    	} else {
                    		$btn.remove("disabled");
                        	alert(result.message);
                    	}
                	},
                	beforeSend:function(){
                    	$btn.text("验证中...");
                	},
                	complete:function(){
                    	$btn.text("提交验证");
                	},
                	error:function(){
                		$btn.remove("disabled");
                    	alert("服务器请求错误");
                	}
            	});
           }


    });
	});
</script>
</body>
</html>