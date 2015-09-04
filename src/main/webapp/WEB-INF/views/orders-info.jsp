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
                <div class="panel-heading">订单信息</div>
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
                        <dt>商家名称</dt>
                        <dd>${business.bsname}</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>商家联系电话</dt>
                        <dd>${business.bstel}</dd>
                    </dl>
                    <dl class="dl-horizontal">
                        <dt>当前状态</dt>
                        <dd>${order.orderstate}</dd>
                    </dl>
                </div>
                <c:if test="${order.orderstate == '等待确认'}">
                    <div class="panel-footer" style="text-align: right">
                        <a href="/u/orders/${requestScope.order.id}/cancel" class="btn btn-danger">取消订单</a>
                    </div>
                </c:if>
            </div>

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
                        <c:forEach items="${requestScope.orderItems}" var="item">
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