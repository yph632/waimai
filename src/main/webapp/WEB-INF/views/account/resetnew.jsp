<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/static/css/b3/bootstrap.css"/>
    <link rel="stylesheet" href="/static/css/font-awesome.min.css"/>
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
                <div class="panel-heading">忘记密码</div>
                <div class="panel-body">
                        <form method="post">
                            <div class="form-group">
                                <label>新密码</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="password" name="password" class="form-control" id="phone"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <button id="subBtn" type="submit" class="btn btn-default">重置</button>
                            </div>
                        </form>
                </div>
            </div>
        </div>
    </div>

</div>






<script src="/static/js/jquery.1.11.1.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
</body>
</html>