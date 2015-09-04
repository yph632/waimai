<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        .restaurant-name{
            font-size: 18px;
        }
        .types a{
            margin: 0px 10px;
        }
        .food-name {
            font-size: 14px;
            color: #666;
        }
        .food-price {
            font-size: 14px;
            font-weight: 600;
            margin: 5px 0px;
            color: #666;
        }
        .shopcar {
            position: fixed;
            bottom:0px;
            right: 0px;
            width: 260px;
            z-index: 9999;
        }
        .types a:hover{
        	text-decoration: none;
        }
        
        .types a:active{
        	color:#f00;
        	text-decoration:none;
        }
        
        .types a:focus{
        	text-decoratioin:none;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/navbar.jsp">
    <jsp:param name="menu" value="index"/>
</jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-danger">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-2">
                            <img src="holder.js/120x95?random=yes" alt=""/>
                        </div>
                        <div class="col-md-9">
                            <h3 class="restaurant-name">开封灌汤包</h3>
                        </div>
                        <div class="col-md-1" style="text-align: center;">
                            <h2 class="text-danger" style="cursor:pointer;"><i class="fa fa-heart-o"></i></h2>
                            		收藏
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-9">
            <div class="panel panel-warning">
                <div class="panel-heading">美食分类</div>
                <div class="panel-body types">
                    <a href="#">盖浇饭(12)</a>
                    <a href="#">饮品(2)</a>
                    <a href="#">烩面(10)</a>
                    <a href="#">其他特色(12)</a>
                </div>
            </div>
            <div class="panel panel-danger">
                <div class="panel-heading">盖浇饭</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-info">
                <div class="panel-heading">烩面</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/restaurant/1" class="thumbnail">
                                <img src="" data-src="holder.js/130x110?random=yes" alt=""/>
                            </a>
                            <div class="caption">
                                <p class="food-name">排骨饭</p>
                                <h3 class="food-price">￥20/份</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="panel panel-danger">
                <div class="panel-heading" style="background-color: #e74c3c;color: #fff"><i class="fa fa-lightbulb-o"></i> 订餐必读&商家公告</div>
                <div class="panel-body">
                    <p>本餐厅9:00开始接受预订，11:00开始营业配送</p>
                </div>
            </div>

            <div class="panel panel-danger shopcar hidden">
                <div class="panel-heading" style="background-color: #e74c3c;color: #fff"><i class="fa fa-shopping-cart"></i> 购物车</div>
                <table class="table">
                    <tr><td colspan="4">
                        <a href="javascript:;">清空</a>
                    </td></tr>
                    <tr>
                        <td>酸豆角炒饭</td>
                        <td>1</td>
                        <td>￥20</td>
                        <td>X</td>
                    </tr>
                    <tr>
                        <td>酸豆角炒饭</td>
                        <td>1</td>
                        <td>￥20</td>
                        <td>X</td>
                    </tr>
                    <tr>
                        <td>酸豆角炒饭</td>
                        <td>1</td>
                        <td>￥20</td>
                        <td>X</td>
                    </tr>
                    <tr>
                        <td>酸豆角炒饭</td>
                        <td>1</td>
                        <td>￥20</td>
                        <td>X</td>
                    </tr>
                </table>

                <div class="panel-footer" style="text-align: right">
                    总计￥300元
                    <a href="javascript:;" class="btn btn-success btn-sm">去买单</a>
                </div>
            </div>
        </div>
    </div>
</div>



<script src="static/js/jquery.1.11.1.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="static/js/holder.min.js"></script>
</body>
</html>