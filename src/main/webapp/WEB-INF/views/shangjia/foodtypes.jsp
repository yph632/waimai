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
                        <div class="panel-heading">餐品类型</div>
                        <div class="panel-body">
                            <c:if test="${not empty message}">
                                <div class="alert alert-info">${message}</div>
                            </c:if>
                            <a href="/shangjia/manage/foodtypes/new" class="btn btn-outline btn-success"><i class="fa fa-plus">添加新类型</i></a>

                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>类型名称</th>
                                        <th>显示顺序</th>
                                        <th>#</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty foodTypes}">
                                        <tr>
                                            <td colspan="3">没有数据</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach items="${foodTypes}" var="type">
                                        <tr>
                                            <td>${type.ftname}</td>
                                            <td>${type.ftindex}</td>
                                            <td>
                                                <a href="/shangjia/manage/foodtypes/edit/${type.id}">编辑</a>
                                                <a class="delLink" href="javascript:;" rel="${type.id}">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </div>
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
<script src="/static/js/bootbox.min.js"></script>
<script>
    $(function(){
        $(".delLink").click(function(){
            var id = $(this).attr("rel");
            bootbox.confirm("确定要删除吗?",function(result){
                if(result) {
                    window.location.href="/shangjia/manage/foodtypes/del/"+id;
                }
            })
        });
    });
</script>

</body>
</html>