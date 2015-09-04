<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/static/css/b3/bootstrap.css"/>
    <link rel="stylesheet" href="/static/css/font-awesome.min.css"/>
    <style type="text/css">
        body {
            font-family: "Microsoft Yahei",Arial,Helvetica,sans-serif;
        }
        </style>
</head>
<body>

<jsp:include page="include/navbar.jsp">
    <jsp:param name="menu" value="index"/>
</jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">我的订单</div>
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
                        <c:forEach items="${requestScope.orderList}" var="order">
                            <tr>
                                <td><a href="/u/orders/${order.ordercode}">${order.ordercode}</a></td>
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
    </div>
</div>



<script src="/static/js/jquery.1.11.1.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="/static/js/holder.min.js"></script>
<script>
    $(function(){



    });
</script>
</body>
</html>