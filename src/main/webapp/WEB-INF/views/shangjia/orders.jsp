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
                        <div class="panel-heading">订单列表</div>
                        <div class="panel-body">
                            <c:if test="${empty foodTypes}">
                                <div class="well">
                                    <form id="searchForm">
                                        <input type="hidden" id="state" name="_orderstate" value="${_orderstate}"/>
                                        <input type="hidden" name="p" value="${page.pageNo}"/>
                                        <input type="hidden" id="ordercode" name="_ordercode" value="${_ordercode}"/>
                                    </form>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <select class="form-control" id="stateInput">
                                                <option value="">所有订单</option>
                                                <option value="等待确认" ${_state == '等待确认' ? 'selected' : ''}>等待确认</option>
                                                <option value="已确认" ${_state == '已确认' ? 'selected' : ''}>已确认</option>
                                                <option value="已完成" ${_state == '已完成' ? 'selected' : ''}>已完成</option>
                                                <option value="已取消" ${_state == '已取消' ? 'selected' : ''}>已取消</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-5">
                                            <input type="text" id="codeInput" placeholder="订单编号" value="${_ordercode}" class="form-control"/>
                                        </div>
                                        <div class="col-xs-2">
                                            <button type="button" id="searchBtn" class="btn btn-outline btn-default">搜索</button>
                                        </div>
                                    </div>



                                </div>
                            </c:if>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>订单编号</th>
                                    <th>下单时间</th>
                                    <th>收餐人</th>
                                    <th>总价</th>
                                    <th>当前状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${page.items}" var="order">
                                    <tr>
                                        <td><a href="/shangjia/manage/orders/${order.ordercode}">${order.ordercode}</a></td>
                                        <td>${order.ordercreatetime}</td>
                                        <td>${order.orderman}</td>
                                        <td>${order.orderprice}</td>
                                        <td>${order.orderstate}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
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