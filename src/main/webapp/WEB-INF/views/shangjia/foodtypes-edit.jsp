<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商家系统-首页</title>
    <link rel="stylesheet" href="/static/css/b3/bootstrap.min.css"/>
    <link rel="stylesheet" href="/static/css/sb-admin-2.css"/>
    <link rel="stylesheet" href="/static/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="/static/css/metisMenu.css"/>

</head>
<body>

<div id="wrapper">

    <jsp:include page="../include/shangjia_navbar.jsp">
        <jsp:param name="menu" value="home"/>
    </jsp:include>
    <!-- Page Content -->
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">餐品类型列表</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-red">
                        <div class="panel-heading">编辑餐品类型</div>
                        <div class="panel-body">
                            <div class="well">
                                注意：显示顺序数字越大，显示的位置越靠前
                            </div>
                            <form method="post">
                                <input type="hidden" name="id" value="${foodType.id}"/>
                                <div class="form-group">
                                    <label>类型名称</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <input class="form-control" type="text" name="ftname" value="${foodType.ftname}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>显示顺序</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <input class="form-control" type="text" name="ftindex" value="${foodType.ftindex}"/>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn btn-outline btn-success">保存</button>
                            </form>

                        </div>
                    </div>
                    <!-- /.panel -->
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="/static/js/jquery-2.1.3.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/static/js/b3/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/static/js/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/static/js/sb-admin-2.js"></script>

</body>
</html>