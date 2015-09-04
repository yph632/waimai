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
                    <h3 class="page-header">餐品列表</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-red">
                        <div class="panel-heading">所有餐品</div>
                        <div class="panel-body">
                            <c:if test="${not empty message}">
                                <div class="alert alert-info">${message}</div>
                            </c:if>
                            <a href="/shangjia/manage/foods/new" class="btn btn-outline btn-success"><i class="fa fa-plus">添加新餐品</i></a>
							<!-- 设置搜索项 -->
							<form id="searchForm" class="form-inline" style="margin-top:10px;">
  								<input type="hidden" name="p" id="pageNo"/>
  								<div class="form-group">
   						 			<label for="foodName">产品名称：</label>
    								<input type="text" class="form-control" name="_fname" id="foodName" placeholder="查找产品名称">
  								</div>
  								<button type="submit" class="btn btn-default">搜索</button>
							</form>
							<!-- 搜索项设置结束 -->
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>餐品名称</th>
                                        <th>价格</th>
                                        <th>显示顺序</th>
                                        <th>餐品类型</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty page.items}">
                                        <tr>
                                            <td colspan="5">没有数据</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach items="${page.items}" var="food">
                                        <tr data-id="${food.id}" class="${food.fname} ${not food.fsales ? 'danger' : ''}">
                                            <td data-id="${food.id}">${food.fname}</td>
                                            <td>${food.fprice}</td>
                                            <td>${food.findex}</td>
                                            <td>${food.foodType.ftname}</td>
                                            <td>
                                                <a href="/shangjia/manage/foods/edit/${food.id}">编辑</a>
                                                <c:choose>
                                                    <c:when test="${food.fsales}">
                                                        <a class="nosale" href="javascript:;" rel="${food.id}" data-state="no">下架</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="dosale" href="javascript:;" rel="${food.id}" data-state="yes">上架</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a class="delLink" href="javascript:;" rel="${food.id}">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
								
								<!-- 翻页功能 -->
								<c:if test="${page.totalPages > 1}">
								<div style="float:right;"> 
									<nav>
									<ul class="pagination">
										<c:choose>
                                           <c:when test="${page.pageNo == 1}">
                                              <li class="active"><a href="javascript:;">首页</a></li>
                                              <li class="disabled"><a href="javascript:;">上一页</a></li>
                                           </c:when>
                                           <c:otherwise>
                                           	  <li><a href="javascript:;" class="page" data-page="1">首页</a></li>
                                           	  <li><a href="javascript:;" class="page" data-page="${page.pageNo - 1}">上一页</a></li>
                                           </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                        	<c:when test="${page.pageNo == page.totalPages}">
                                        	  <li class="disabled"><a href="javascript:;">上一页</a></li>
                                           	  <li class="disabled"><a href="javascript:;">尾页</a></li>
                                        	</c:when>
                                        	<c:otherwise>
                                        		<li><a href="javascript:;" class="page" data-page="${page.pageNo + 1}">下一页</a></li>
                                           	  <li><a href="javascript:;" class="page" data-page="${page.totalPages}">尾页</a></li>
                                        	</c:otherwise>
                                        </c:choose>
									</ul>
									</nav>
								</div>
								</c:if>
								<!-- 翻页功能结束 -->
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
    $(document).ready(function(){
    	var $searchForm = $("#searchForm");
    	
    	$(document).on("click", ".nosale", function(){
    		var $this = $(this);
    		//var $saleState = $this.attr("data-state");
    		var $state = null;
    		var rel = $this.attr("rel");
    		
    		bootbox.confirm("确定要修改餐品状态?",function(result){
                if(result) {
                	$.ajax({
                		url:'/shangjia/manage/foods/states',
                		type:'get',
                		data:{'id':rel,'fsales':false},
                		success:function(data){
                			if(data.state == "success"){
                				$("tr[data-id="+ rel +"]").attr("class", "danger");
                				$this.attr("class", 'dosale')
                				$this.text("上架");
                			}else{
                				bootbox.alert("状态修改失败!")
                			}	
                		},
                		error:function(){
                			bootbox.alert("网络故障，请检查网络重试");
                		}
                	});
                }
            })
    	});
    	
    	$(document).on("click", ".dosale", function(){
    		var $this = $(this);
    		//var $saleState = $this.attr("data-state");
    		var $state = null;
    		var rel = $this.attr("rel");
    		bootbox.confirm("确定要修改餐品状态?",function(result){
                if(result) {
                	$.ajax({
                		url:'/shangjia/manage/foods/states',
                		type:'get',
                		data:{'id':rel,'fsales':true},
                		success:function(data){
                			if(data.state == "success"){
                				$("tr[data-id="+ rel +"]").attr("class", "");
                				$this.attr("class", 'dosale')
                				$this.text("上架");
                			}else{
                				bootbox.alert("状态修改失败!")
                			}	
                		},
                		error:function(){
                			bootbox.alert("网络忙，请稍后重试");
                		}
                	});
                }
            });
    	});
    	
        $(".delLink").click(function(){
            var id = $(this).attr("rel");
            bootbox.confirm("确定要删除吗?",function(result){
                //if(result) {
                   // window.location.href="/shangjia/manage/foods/del/"+id;
                //}
                if(result){
                	$.ajax({
                		url:'/shangjia/manage/foods/del/',
                		type:'post',
                		data:{'id':id},
                		success:function(data){
                			if(data.state == "success"){
                				window.location.href="";
                			}else{
                				bootbox.alert(data.message);
                			}
                		},
                		error:function(){
                			bootbox.alert("与服务器连接异常，请检查网络或其他设置");
                		}
                	});
                }
            })
        });
        
        
        //翻页
        $(".page").on("click", function(){
        	$(pageNo).val($(this).attr("data-page"));
        	$searchForm.submit();
        });
    });
</script>

</body>
</html>