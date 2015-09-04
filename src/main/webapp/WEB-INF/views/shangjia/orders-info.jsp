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
                    <h3 class="page-header">订单列表</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-red">
                        <div class="panel-heading">订单详情</div>
                        <div class="panel-body">
                            <c:if test="${not empty message}">
                                <div class="alert alert-info">${message}</div>
                            </c:if>
                            <dl class="dl-horizontal">
                                <dt>订单编号</dt>
                                <dd>${order.ordercode}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>收餐人</dt>
                                <dd>${order.orderman}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>联系电话</dt>
                                <dd>${order.ordertel}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>配送地址</dt>
                                <dd>${order.orderaddress}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>给餐厅留言</dt>
                                <dd>${empty order.ordercontent ? '无' : order.ordercontent}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>订单总价</dt>
                                <dd>￥${order.orderprice}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>支付方式</dt>
                                <dd>${order.orderpaytype}</dd>
                            </dl>
                            <dl class="dl-horizontal">
                                <dt>当前状态</dt>
                                <dd>${order.orderstate}</dd>
                            </dl>
                        </div>
                        <c:if test="${order.orderstate != '已取消' or order.orderstate != '已完成'}">
                            <div class="panel-footer" style="text-align: right">
                                <c:choose>
                                    <c:when test="${order.orderstate == '等待确认'}">
                                        <a href="/shangjia/manage/orders/${order.id}/ing" class="btn btn-outline btn-danger">确认订单</a>
                                    </c:when>
                                    <c:when test="${order.orderstate == '已确认'}">
                                        <a href="/shangjia/manage/orders/${order.id}/post" class="btn btn-outline btn-info">开始配送</a>
                                    </c:when>
                                    <c:when test="${order.orderstate == '派送中'}">
                                        <a href="/shangjia/manage/orders/${order.id}/end" class="btn btn-outline btn-success">完成订单</a>
                                    </c:when>
                                </c:choose>


                            </div>
                        </c:if>
                    </div>
                    <!-- /.panel -->

                    <div class="panel panel-default">
                        <div class="panel-heading">订单详情</div>
                        <table class="table">
                            <thead>
                            <tr>
                                <th>餐品名称</th>
                                <th>单价</th>
                                <th>数量</th>
                                <th>总价</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${orderItems}" var="item">
                                <tr>
                                    <td>${item.itemname}</td>
                                    <td>￥${item.itemprice}</td>
                                    <td>${item.itemnum}</td>
                                    <td>${item.itemprice * item.itemnum}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>


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
<script>
    $(function(){
        $("#searchBtn").click(function(){
            $("#state").val($("#stateInput").val());
            $("#ordercode").val($("#codeInput").val());
            $("#searchForm").submit();
        });
    });
</script>
</body>
</html>