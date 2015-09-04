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
                <div class="panel-heading">购物车</div>
                <c:if test="${not empty business}">
                <div class="panel-body">

                    <div class="row">
                        <div class="col-md-3">

                            <img src="http://7xkr3z.com1.z0.glb.clouddn.com/${business.bsphoto}-size200" alt=""/>

                        </div>
                        <div class="col-md-9">
                            <h4>${business.bsname}</h4>
                        </div>
                    </div>


                </div>
                </c:if>
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
                    <c:set var="totalPrice" value="0"/>
                    <c:if test="${empty foodItems}">
                        <tr><td colspan="4">你还没有点餐！</td></tr>
                    </c:if>
                    <c:forEach items="${foodItems}" var="item">
                        <c:set var="totalPrice" value="${totalPrice + item.food.fprice * item.num}"/>
                        <tr>
                            <td>${item.food.fname}</td>
                            <td>￥${item.food.fprice}</td>
                            <td>${item.num}</td>
                            <td>${item.food.fprice * item.num}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="panel-footer" style="text-align: right">
                    <c:choose>
                        <c:when test="${not empty business.bspostprice}">
                            配送费：￥${business.bspostprice}　总计：￥${totalPrice+business.bspostprice}
                        </c:when>
                        <c:otherwise>
                            总计：￥${totalPrice}
                        </c:otherwise>
                    </c:choose>



                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">订单信息</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="orderForm">
                        <input type="hidden" name="bsid" value="${business.id}"/>
                        <input type="hidden" name="orderprice" value="${not empty business.bspostprice ? totalPrice+business.bspostprice : totalPrice}"/>
                        <div class="form-group">
                            <label class="control-label col-md-2">订餐人：</label>
                            <div class="col-md-6">
                                <input type="text" class="form-control" name="orderman"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">联系电话：</label>
                            <div class="col-md-6">
                                <input type="text" id="phone" class="form-control" name="ordertel"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">送餐地址：</label>
                            <div class="col-md-6">
                                <input type="text" class="form-control" name="orderaddress"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">给餐厅留言：</label>
                            <div class="col-md-6">
                                <textarea class="form-control" name="ordercontext"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-2">支付方式：</label>
                            <div class="col-md-6">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="orderpay" value="餐到付款" checked>
                                        餐到付款
                                    </label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="panel-footer" style="text-align: right">
                    <c:choose>
                        <c:when test="${totalPrice < business.bspoststartprice}">
                            <a href="javascript:;" class="btn btn-success " disabled>未达到最低起送价</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:;"  id="orderBtn" class="btn btn-success ">提交订单</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">手机验证</h4>
                        </div>
                        <div class="modal-body">
                            <div style="display: none" class="alert alert-danger" id="alert"></div>
                            <h5>为了便于餐厅及时与你联系，我们需要验证你的手机</h5>
                            <form class="form-inline">
                                <input type="text" id="code" class="form-control" placeholder="请输入手机验证码"/>
                                <button type="button" id="validateBtn" class="btn btn-primary">提交验证</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal -->

        </div>
    </div>
</div>



<script src="/static/js/jquery.1.11.1.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="/static/js/holder.min.js"></script>
<script>
    $(function(){

        $("#orderBtn").click(function(){
            $.post("/api/sms/user/validatecode",{"phone":$("#phone").val()},function(){
                $('#myModal').modal();
            });
        });

        $("#validateBtn").click(function(){
            $.post("/api/sms/validatecallback",{"phone":$("#phone").val(),"code":$("#code").val()},function(result){
                if(result.state == "success") {
                    $.post("/shopcar/checkout",$("#orderForm").serialize(),function(result){
                        if(result.state == "success") {
                            window.location.href="/u/orders";
                        }
                    });
                } else {
                    $("#alert").text(result.message).show();
                }
            });
        });


    });
</script>
</body>
</html>