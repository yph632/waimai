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
    <style type="text/css">
        dd{
            margin-bottom: 20px;
        }
    </style>
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
                    <h3 class="page-header">店铺信息</h3>
                    <div class="panel panel-red">
                        <div class="panel-heading">运营信息</div>
                        <div class="panel-body">
                            <dl class="dl-horizontal">
                                <dt>起送价格</dt>
                                
                                <c:choose>
                               	<c:when test="${empty requestScope.businessInfo.bspoststartprice}">
                               		<dd>¥ 0元</dd>
                               	</c:when>
                               	<c:otherwise>
                               		<dd>¥ ${requestScope.businessInfo.bspoststartprice}元</dd>
                               	</c:otherwise>
                               	</c:choose>
                                <dt>配送费用</dt>
                                <dd>
                                    <c:choose>
                                        <c:when test="${empty requestScope.businessInfo.bspostprice}">
                                            无配送费用
                                        </c:when>
                                        <c:otherwise>
                                            ￥${requestScope.businessInfo.bspostprice}
                                        </c:otherwise>
                                    </c:choose>
                                </dd>
                                <dt>上午营业时间</dt>
                                <dd>${requestScope.businessInfo.bsamhourstart} - ${requestScope.businessInfo.bsamhourend}</dd>
                                <dt>下午营业时间</dt>
                                <dd>${requestScope.businessInfo.bspmhourstart} - ${requestScope.businessInfo.bspmhourend}</dd>
                                <dt>商家公告</dt>
                                <dd>${requestScope.businessInfo.bscontent}</dd>
                                <dt>商家照片</dt>
                                <c:choose>
                                <c:when test="${not empty requestScope.businessInfo.bsphoto}">
                                <dd><img src="http://7xkr3z.com1.z0.glb.clouddn.com/${requestScope.businessInfo.bsphoto}-size200" alt="商家照片"/></dd>
                            	</c:when>
                            	<c:otherwise>
                            	<dd><a href="/shangjia/manage/shop/edit">照片上传，请上传照片</a></dd>
                            	</c:otherwise>
                       			</c:choose>
                            </dl>
                        </div>
                        <div class="panel-footer" style="text-align: right;">
                            <a href="/shangjia/manage/shop/edit" type="button" class="btn btn-default text-danger">
                                修改信息
                            </a>
                        </div>
                    </div>

                    <div class="panel panel-red">
                        <div class="panel-heading">商家信息</div>
                        <div class="panel-body">
                            <dl class="dl-horizontal">
                                <dt> 商家名称</dt>
                                <dd> ${sessionScope.curr_business.bsname}</dd>
                                <dt>经营品类</dt>
                                <dd>${sessionScope.curr_business.bstype}</dd>
                                <dt> 地址</dt>
                                <dd>${sessionScope.curr_business.bsaddress}</dd>
                                <dt> 负责人</dt>
                                <dd>${sessionScope.curr_business.bsman}</dd>
                                <dt> 联系电话</dt>
                                <dd>${sessionScope.curr_business.bstel}</dd>
                                <dt> 营业执照注册号</dt>
                                <dd>${sessionScope.curr_business.bscardnum}</dd>
                                <dt> 营业执照所在地</dt>
                                <dd> ${sessionScope.curr_business.bscardaddress}</dd>
                                <dt>营业执照</dt>
                                <dd><img
                                        src="http://7xkr3z.com1.z0.glb.clouddn.com/${sessionScope.curr_business.bscardphoto}-size200" alt=""/></dd>
                            </dl>
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
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
                    window.location.href="/shangjia/manage/foods/"+id+"/del";
                }
            })
        });


        var $form = $("#searchForm");
        $(".page").click(function(){
            $("#pageNo").val($(this).attr("data-page"));
            $form.submit();
        });

        $("#searchBtn").click(function(){
            $("#foodtype").val($("#typeid").val());
            $form.submit();
        });

        $(".saleLink").click(function(){
            var id = $(this).attr("rel");
            var state = $(this).attr("data-state");
            bootbox.confirm("确定要修改餐品状态?",function(result){
                if(result) {
                    window.location.href="/shangjia/manage/foods/states?s="+state+"&id="+id;
                }
            })
        });

    });
</script>

</body>
</html>