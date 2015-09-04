<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>外卖订餐，您的订餐首选</title>
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
            width: 300px;
            z-index: 9999;
        }
        .plusFood{
        	  font-size: 1.8em;
        	  cursor:pointer;
        }
        
        .minusFood{
        	  font-size: 1.8em;
        	  cursor:pointer;
        }
        
        .delFood{
        	cursor:pointer;
        }
        
        .fa-2{
        	font-size:1.8em;
        }
        
        .dl-horizontal dt{
        	width:auto;
        }
        .dl-horizontal dd{
        	margin-left:0;
        	padding-left:8em;
        	border-bottom:2px solid #f00;
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
                    <div class="row">
                        <div class="col-md-3">
                        	<c:choose>
                        	<c:when test="${empty requestScope.business.bsphoto}">
                            <img src="holder.js/120x95?random=yes" alt=""/>
                            </c:when>
                            <c:otherwise>
                            <img src="http://7xkr3z.com1.z0.glb.clouddn.com/${requestScope.business.bsphoto}-size200" alt=""/>
                            </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-8">
                            <h3 class="restaurant-name">${requestScope.business.bsname}</h3>
                        </div>
                        <div class="col-md-1" style="text-align: center">
                            <h2 class="text-danger"><i class="fa fa-heart-o"></i></h2>
                            收藏
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-9">
            <div class="panel panel-default">
                <div class="panel-heading">美食分类</div>
                <div class="panel-body types">
                    <c:forEach items="${foodMap}" var="foodType">
                    <a href="#">${foodType.key}(${fn:length(foodType.value)})</a>
                    </c:forEach>
                </div>
            </div>
            
            <c:forEach items="${foodMap}" var="foodMap">
            <div class="panel panel-default">
            	<div class="panel-heading">${foodMap.key}</div>
            	<div class="panel-body">
            	<div class="row">
            	<c:forEach items="${foodMap.value}" var="food">
            	   <div class="col-md-3">
                       <a href="javascript:;" data-id="${food.id}" class="thumbnail food">
                          <img src="http://7xkr3z.com1.z0.glb.clouddn.com/${food.fphoto}-size130x110" alt=""/>
                       </a>
                          <div class="caption">
                           <p class="food-name">${food.fname}</p>
                            <h3 class="food-price">￥ ${food.fprice}</h3>
                         </div>
                    </div>
            	</c:forEach>
            	</div>
            	</div>
            	</div>
            </c:forEach>
        </div>
        <div class="col-md-3">
            <div class="panel panel-danger">
                <div class="panel-heading" style="background-color: #e74c3c;color: #fff"><i class="fa fa-lightbulb-o"></i> 订餐必读&商家公告</div>
                <div class="panel-body">
                    <p>${requestScope.business.bscontent}</p>
                </div>
            </div>
            <div class="panel panel-warning">
                <div class="panel-heading" style="background-color: #e74c3c;color: #fff"><i class="fa fa-lightbulb-o"></i> 商家信息</div>
                <div class="panel-body">
                    <dl class="dl-horizontal">
                       <dt>起送价格:</dt>
                       <c:choose>
                       <c:when test="${empty requestScope.business.bspoststartprice}">
                       <dd style="">¥ 0元</dd>
                       </c:when>
                       <c:otherwise>
                       <dd>¥ ${requestScope.business.bspoststartprice}元</dd>
                       </c:otherwise>
                       </c:choose>
                       <dt>配送费用:</dt>
                       <dd>
                       <c:choose>
                       <c:when test="${empty requestScope.business.bspostprice}">
                                            无配送费用
                       </c:when>
                       <c:otherwise>
                                            ￥${requestScope.business.bspostprice}
                       </c:otherwise>
                       </c:choose>
                       </dd>
                       <dt>上午营业时间:</dt>
                       <dd>${requestScope.business.bsamhourstart} - ${requestScope.business.bsamhourend}</dd>
                        <dt>下午营业时间:</dt>
                        <dd>${requestScope.business.bspmhourstart} - ${requestScope.business.bspmhourend}</dd>
                    </dl>
                    
                </div>
            </div>

            <div  class="panel panel-danger shopcar">
                <div id="panel-top" class="panel-heading" style="background-color: #e74c3c;color: #fff"><i class="fa fa-shopping-cart"></i> 购物车</div>
                <table class="table">
                   
                   <tbody id="carBody" >
                   <c:set var="totalPrice" value="0"/>
                    
                   <c:forEach items="${requestScope.foodItems}" var="foodItem">
                     <c:set var="totalPrice" value="${totalPrice + foodItem.food.fprice * foodItem.num}"/>
                     <tr>
        				<td>${foodItem.food.fname}</td>
						<td id="food-num-${foodItem.food.id}" data-id="${foodItem.food.id}">
						<i class="fa fa-plus-square plusFood"></i>${foodItem.num}<i class="fa fa-minus-square minusFood"></i>
						</td>
        				<td>￥<span id="food-price-${foodItem.food.id}">${foodItem.food.fprice * foodItem.num}</span></td>
        				<td class="delFood" data-id="${foodItem.food.id}"><a href="javascript:;"><i class="fa fa-times fa-2"></i></a></td>
    				</tr>
    				</c:forEach>
    				</tbody>
                   
                    <tfoot>
                        <tr><td colspan="4">
                            <a href="javascript:;" id="clearCar">清空</a>
                        </td></tr>
                   </tfoot>
                    
                </table>
				
                <div id="panel-foot" class="panel-footer" style="text-align: right">
                    
                    总计￥<span id="totalPrice">${pageScope.totalPrice}</span>元
                    <c:choose>
                    <c:when test="${empty requestScope.foodItems}">
                    <a href="javascript:;" class="btn btn-success btn-sm" id="pay" disabled="disabled">购物车是空的</a>
                	</c:when>
                	<c:when test="${pageScope.totalPrice < requestScope.business.bspoststartprice}">
                	<a href="javascript:;" class="btn btn-success btn-sm" id="pay" disabled="disabled">还差${requestScope.business.bspoststartprice - pageScope.totalPrice}元</a>
                	</c:when>
                	<c:otherwise>
                	<a href="javascript:;" class="btn btn-success btn-sm" id="pay">点击付款</a>
                	</c:otherwise>
                	</c:choose>
                </div>
            </div>
        </div>
    </div>
</div>



<script src="/static/js/jquery.1.11.1.min.js" charset="utf-8"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="/static/js/holder.min.js"></script>
<script src="/static/js/handlebars-v3.0.3.js"></script>
<script src="/static/js/bootbox.min.js"></script>
<script src="/static/js/js-cookie.js"></script>
<script src="/static/js/jquery.cookie.js"></script>
<script type="text/template" id="template">
    <tr>
        <td>{{fname}}</td>
		<td id="food-num-{{id}}" data-id="{{id}}">
			<i class="fa fa-plus-square plusFood"></i>1<i class="fa fa-minus-square minusFood"></i>
		</td>
        <td>￥<span id="food-price-{{id}}">{{fprice}}</span></td>
        <td class="delFood" data-id="{{id}}"><a href="javascript:;"><i class="fa fa-times fa-2"></i></a></td>
    </tr>
</script>
<script>
	$(document).ready(function(){
		var $carBody = $("#carBody");
        var $totalPrice = $("#totalPrice");
        var postPrice = ${requestScope.business.bspoststartprice};
        
        /////点击展开隐藏的购物车
        $("#panel-foot").click(function(){
        	$("#carBody").toggle();
        	event.preventDefault();
        });
        
        $("#pay").click(function(){
        	event.preventDefault();
        	window.location.href="/shopcar/checkout";
        });
        
        var $pay = $("#pay");
        //清空购物车
        $("#clearCar").on("click", function(){
        	console.log(Cookies.remove("car"));
            $carBody.html("");
            $pay.html("购物车是空的").attr("disabled","disabled");
            $totalPrice.text("0元");
        });
        
       var plusFoodByPhoto = function(foodId){
    	   $.ajax({
       			url:"/restaurant/food/add",
       			data:{
       			"bid":'${requestScope.business.id}',
       			"fid":foodId
       			},
       			success:function(result){
       				var food = result.data;					
       				if(result.state == "success" && food.fsales){
       					
          				if($("#carBody").find("#food-num-"+food.id).length > 0) {
              				var num = parseFloat($("#food-num-"+food.id).text()) +1;
               				var price = parseFloat(food.fprice) * num;
               				$("#food-num-"+food.id).html(
               						'<i class="fa fa-plus-square plusFood"></i>'
               						+num+ 
               						'<i class="fa fa-minus-square minusFood"></i>');
               				$("#food-price-"+food.id).text(price.toFixed(1));
           			 	} else {
               				var source = $("#template").html();
               				var template = Handlebars.compile(source);
               				var html = template(food);
               				$carBody.append(html);
           				}
          				var totalPrice = parseFloat($totalPrice.text())+food.fprice;
           				$totalPrice.text(totalPrice.toFixed(1));
           				if((totalPrice-postPrice) < 0 ) {
           					$pay.text("去买单").attr("disabled", "disabled");
              				$pay.text("还差"+Math.abs((totalPrice-postPrice).toFixed(1))+"元起送");
           				} else {
               				$pay.text("去买单").removeAttr("disabled");
           				}
           			}else{
           				bootbox.alert("抱歉。该产品已经临时下架");
           			}
       			},
          		error:function(){
          			bootbox.alert("网络异常，请稍后重试");
          		}
       		});
       }
       
       
       var minusFoodByAjax = function($this, foodId){
    	   $.ajax({
       		 url:"/restaurant/food",
       		 data:{
       			"bid":'${requestScope.business.id}',
       			"fid":foodId
       		},
       		success:function(result){
       			var food = result.data;					
   				if(result.state == "success"){
						var num = parseFloat($("#food-num-"+food.id).text());
          				if(num > 1) {
              				var num = parseInt($("#food-num-"+food.id).text()) -1;
               				var price = num*food.fprice;
               				//////JSON//////
               				console.log($.cookie("car"));
               				var $carJson = JSON.parse($.cookie("car"));//.replace(/\\/g, "")
               				console.log("json: " + $carJson);
               				var $shopCarItems = $carJson.shopCarItems;
               				
               				for (var i=0;i < $shopCarItems.length;i++)
               				{
               					if(parseInt($shopCarItems[i].foodId) == food.id){
               						$shopCarItems[i].num = parseInt($shopCarItems[i].num)-1 ;
               						break;
               					}
               				}
               				var cdata = {"bid":$carJson.bid,"shopCarItems":$shopCarItems};
           					var sdata = JSON.stringify(cdata).replace(/\"/g,'\\"');
           					$.cookie.raw = true;
           					$.cookie("car",'"' + sdata +'"',{expires: 0.2, path: '/' });
               				$.cookie.raw = false;
           					$("#food-num-"+food.id).html(
               					'<i class="fa fa-plus-square plusFood"></i>'
               					+num+ 
               					'<i class="fa fa-minus-square minusFood"></i>');
               					$("#food-price-"+food.id).text(price.toFixed(2));
           					} else {
           							//////JSON//////
               					console.log($.cookie("car"));
               					var $carJson = JSON.parse($.cookie("car"));//.replace(/\\/g, "")
               					console.log("json: " + $carJson);
               					var $shopCarItems = $carJson.shopCarItems;
               					console.log("bid: " + $carJson.bid);
               					console.log("shopCarItems: " + $shopCarItems);
               					var shopdata = {'foodId':null, 'num':null};
               					var $shopdatas = [];
               					for (var i=0;i < $shopCarItems.length;i++)
               					{
               						console.log(i);
               						if(parseInt($shopCarItems[i].foodId) != food.id){
               							shopdata.foodId = $shopCarItems[i].foodId;
           								shopdata.num = $shopCarItems[i].num;
           								$shopdatas[$shopdatas.length] = shopdata;
               						}
               					}
         					
               					var cdata = {"bid":$carJson.bid,"shopCarItems":$shopdatas};
           						var sdata = JSON.stringify(cdata).replace(/\"/g,'\\"');
           						$.cookie.raw = true;
           						$.cookie("car",'"' + sdata +'"',{expires: 0.2, path: '/' });
               					$.cookie.raw = false;
               					$this.parent().remove();
           				}
          				var totalPrice = parseFloat($totalPrice.text())-food.fprice;
           				$totalPrice.text(totalPrice.toFixed(1));
           				if((totalPrice-postPrice) < 0 ) {
           					$pay.text("去买单").attr("disabled","disabled");
              				$pay.text("还差"+Math.abs((totalPrice-postPrice).toFixed(1))+"元起送");
           				} else {
               					$pay.text("去买单").removeAttr("disabled");
           				}
           			}else{
           				bootbox.alert(result.message);
           			}
       			},
      			error:function(){
      			bootbox.alert("网络异常，请稍后重试");
      		}
       	 });
   
       };
       
       var plusFoodByAjax = function(foodId){
    	   $.ajax({
       			url:"/restaurant/food",
       			data:{
       			"bid":'${requestScope.business.id}',
       			"fid":foodId
       			},
       			success:function(result){
       				var food = result.data;					
       				if(result.state == "success" && food.fsales){
       					
          				if($("#carBody").find("#food-num-"+food.id).length > 0) {
              				var num = parseFloat($("#food-num-"+food.id).text()) +1;
               				var price = parseFloat(food.fprice) * num;
               				$("#food-num-"+food.id).html(
               						'<i class="fa fa-plus-square plusFood"></i>'
               						+num+ 
               						'<i class="fa fa-minus-square minusFood"></i>');
               				$("#food-price-"+food.id).text(price.toFixed(1));
               					//////JSON//////
           					var $carJson = JSON.parse($.cookie("car"));//.replace(/\\/g, "")
           					var $shopCarItems = $carJson.shopCarItems;
           					for (var i=0;i < $shopCarItems.length;i++)
           					{
           						if(parseInt($shopCarItems[i].foodId) == food.id){
       								$shopCarItems[i].num ++;
           						}
           					}
     					
           					var cdata = {"bid":$carJson.bid,"shopCarItems":$shopCarItems};
       						var sdata = JSON.stringify($carJson).replace(/\"/g,'\\"');
       						$.cookie.raw = true;
       						$.cookie("car",'"' + sdata +'"',{expires: 0.2, path: '/' });
           					$.cookie.raw = false;
           			 	} else {
           					//////JSON//////
           					var $carJson = JSON.parse($.cookie("car"));//.replace(/\\/g, "")
           					var $shopCarItems = $carJson.shopCarItems;
           					var shopdata = {'foodId':null, 'num':null};
           					$shopCarItems[$shopCarItems.length] = shopdata;
       						var sdata = JSON.stringify($carJson).replace(/\"/g,'\\"');
       						$.cookie.raw = true;
       						$.cookie("car",'"' + sdata +'"',{expires: 0.2, path: '/' });
           					$.cookie.raw = false;
               				var source = $("#template").html();
               				var template = Handlebars.compile(source);
               				var html = template(food);
               				$carBody.append(html);
           				}
          				var totalPrice = parseFloat($totalPrice.text())+food.fprice;
           				$totalPrice.text(totalPrice.toFixed(1));
           				if((totalPrice-postPrice) < 0 ) {
           					$pay.text("去买单").attr("disabled", "disabled");
              				$pay.text("还差"+Math.abs((totalPrice-postPrice).toFixed(1))+"元起送");
           				} else {
               				$pay.text("去买单").removeAttr("disabled");
           				}
           			}else{
           				bootbox.alert("抱歉。该产品已经临时下架");
           			}
       			},
          		error:function(){
          			bootbox.alert("网络异常，请稍后重试");
          		}
       		});
       }
       /////////////////////////////////////////
       
     	 //餐品被点击
        $(".food").click(function(){
            var foodId = $(this).attr("data-id");
          	//判断是否为同一家店的商品，并要求用户进行选择操作
          	var $cookies = $.cookie("car");
          	if($cookies){
            	var $carJson1 = JSON.parse($.cookie("car"));
				if($carJson1 != null && $carJson1.bid != '${requestScope.business.id}'){
					bootbox.confirm("请在其他店的订单还没付款，是否继续，清空其他店的订单",function(isok){
						if(isok){
							$.removeCookie("car");
							//清空购物车界面
							$carBody.html("");
	            			$pay.html("购物车是空的").attr("disabled","disabled");
	            			$totalPrice.text("0元");
	            			//操作结束
	            			//继续添加新订单
	                    	plusFoodByPhoto(foodId);
						}
					});
				}else{
					//继续添加新订单
                	plusFoodByPhoto(foodId);
				}
          	}else{
          		plusFoodByPhoto(foodId);
          	}
			
        });
        
     	 ////根据ajax返回的数据删除购物车的某一类商品
     	 var removeFoodItem = function($this, foodId){
     		$.ajax({
         		 url:"/restaurant/food",
         		 data:{
         			"bid":'${requestScope.business.id}',
         			"fid":foodId
         		},
         		success:function(result){
         			if(result.state == "success"){
   					var food = result.data;
   					var num = parseFloat($("#food-num-"+food.id).text());
   					///////////////js cookie/////////
   						//////JSON//////
          				console.log($.cookie("car"));
          				var $carJson = JSON.parse($.cookie("car"));//.replace(/\\/g, "")
          				console.log("json: " + $carJson);
          				var $shopCarItems = $carJson.shopCarItems;
          				console.log("bid: " + $carJson.bid);
          				console.log("shopCarItems: " + $shopCarItems);
          				var shopdata = {'foodId':null, 'num':null};
          				var $shopdatas = [];
          				if($shopCarItems.length > 1){
          					for (var i=0;i < $shopCarItems.length;i++)
          					{
          						if(parseInt($shopCarItems[i].foodId) != food.id){
          							shopdata.foodId = $shopCarItems[i].foodId;
      								shopdata.num = $shopCarItems[i].num;
      								$shopdatas[$shopdatas.length] = shopdata;
          						}
          					}
          					var cdata = {"bid":$carJson.bid,"shopCarItems":$shopdatas};
      						var sdata = JSON.stringify(cdata).replace(/\"/g,'\\"');
      						$.cookie.raw = true;
      						$.cookie("car",'"' + sdata +'"',{expires: 0.2, path: '/' });
          					$.cookie.raw = false;
          				}else if(parseInt($shopCarItems[0].foodId) == food.id){
          					console.log("000");
          					$.removeCookie("car");
          				}
   						//////////////js cookie end////////////
        				$this.parent().remove(); //删除
        				var totalPrice = parseFloat($totalPrice.text())-(num *food.fprice);
         				$totalPrice.text(totalPrice.toFixed(1));
         				if((totalPrice-postPrice) < 0 ) {
         					$pay.text("去买单").attr("disabled", "disabled");
            				$pay.text("还差"+Math.abs((totalPrice-postPrice).toFixed(1))+"元起送");
         				}else{
             				$pay.text("去买单").removeAttr("disabled");
         				}
         			}else{
         				bootbox.alert(result.message);
         			}
         		},
         		error:function(){
         			bootbox.alert("网络异常，请稍后重试");
         		}
         });
     	 }
     	 
      	//删除购物车的商品
        $(document).on("click", ".delFood" ,function(){
            var foodId = $(this).attr("data-id");
            var $this = $(this);
            event.preventDefault();
            removeFoodItem($this,foodId);
			
        });
      	
      	
      	//购物车中餐品数量加号被点击
      	$(document).on("click", ".plusFood", function(){
      		var foodId = $(this).parent().attr("data-id");
            plusFoodByAjax(foodId);
      	});
      	
      //删除购物车的商品当购物车中餐品数量减号被点击
        $(document).on("click", ".minusFood" ,function(){
        	var foodId = $(this).parent().attr("data-id");
            var $parent = $(this).parent();
            minusFoodByAjax($parent, foodId);
            
        });
      
	});
</script>

</body>
</html>