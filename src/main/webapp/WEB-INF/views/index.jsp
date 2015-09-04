<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>外卖订餐，您的订餐首选</title>
    <link rel="stylesheet" href="/static/css/b3/bootstrap.css"/>
    <link rel="stylesheet" href="/static/css/font-awesome.min.css"/>
    <style type="text/css">
        .bs-name{
            text-decoration: none;
            color: #3c3c3c;
            font-size: 14px;
            font-family: "Microsoft Yahei",Arial,Helvetica,sans-serif;
        }
        .bs-name:hover{
            text-decoration: none;
        }
        .bs-info{
            margin: 8px 0px;
            font-size: 12px;
            color: #737373;
            font-family: "Microsoft Yahei",Arial,Helvetica,sans-serif;
        }
        .search-bar {
            font-family: "Microsoft Yahei",Arial,Helvetica,sans-serif;
            margin-bottom: 25px;
        }
        .search-bar .search-title {
            color: #999;
            display: inline-block;
            width: 80px;
        }
        .search-bar .search-itme {
            color: #666;
            margin: 0px 10px;
        }
        .search-bar .active {
            color: #fff;
            background-color: #e74c3c;
            padding: 4px 8px;
            border-radius: 5px;
        }
        .search-bar .search-itme:hover{
            text-decoration: none;
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
            <div class="panel panel-danger">
                <div class="panel-body">
                    <div class="search-bar">
                        <span class="search-title">餐厅分类：</span>
                        <a href="javascript:;" class="search-itme active">不限</a>
                        <c:forEach items="shopTypes" var="shopType">
                        	<a href="javascript:;" class="search-itme">${shopType}</a>
                        </c:forEach>
                        <a href="javascript:;" class="search-itme">中式</a>
                        <a href="javascript:;" class="search-itme">西式</a>
                        <a href="javascript:;" class="search-itme">烧烤</a>
                    </div>
                    <div class="search-bar" style="margin-bottom: 0px">
                        <span class="search-title">排序：</span>
                        <a href="javascript:;" class="search-itme active">默认</a>
                        <a href="javascript:;" class="search-itme">销量</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
            <c:forEach items="${requestScope.businessList}" var="business">
            <div class="col-md-3">
            <a href="/restaurant/${business.id}" class="thumbnail">
            <c:choose>
            	<c:when test="${not empty business.bsphoto}">
            	<img data-id="${business.id}" class="shopImg" src="http://7xkr3z.com1.z0.glb.clouddn.com/${business.bsphoto}-size200" alt=""/>
            	</c:when>
            	<c:otherwise>
            		<img src=""  data-src="holder.js/200x150?random=yes"/>
            	</c:otherwise>
             </c:choose>   
            </a>
            <div class="caption" >
                <a href="javascript:;" class="bs-name">${business.bsname}</a> 
               <div class="bs-info">起送价
               <c:choose>
               	<c:when test="${empty business.bspoststartprice}">
               		0元
               	</c:when>
               	<c:otherwise>
               		¥ ${business.bspoststartprice}元
               	</c:otherwise>
               </c:choose>
               <c:choose>
               	<c:when test="${empty business.bspostprice}">
               		免配送费
               	</c:when>
               	<c:otherwise>
               		配送费：  ${business.bspostprice}元
               	</c:otherwise>
               </c:choose>
            </div>
            </div>
            </div>
            </c:forEach>
            <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">狗不理包子</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">开封灌汤包</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">开封小笼包</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">南京怪味包</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">开封烩面</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">洧川烩饼</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">洧川羊肉汤</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">开封小黄鱼</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>
        <div class="col-md-3">
            <a href="#" class="thumbnail">
                <img src="" data-src="holder.js/200x150?random=yes" alt=""/>
            </a>
            <div class="caption">
                <a href="#" class="bs-name">开封翻炉烧饼</a>
                <div class="bs-info">起送：￥30　免配送费</div>
            </div>
        </div>

    </div>
    <a href="/shangjia">商家申请</a>
</div>



<script src="/static/js/jquery.1.11.1.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="/static/js/holder.min.js"></script>


<script>
	$(document).ready(function(){
		
		
	});
</script>


</body>
</html>