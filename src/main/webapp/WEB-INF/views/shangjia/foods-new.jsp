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
	<link rel="stylesheet" href="/static/js/webuploader/webuploader.css" />
	<style type="text/css">
		.progress span{
			background-color:#555;
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
                    <h3 class="page-header">添加餐品</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <!-- /.row -->
            <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-red">
                        <div class="panel-heading">添加餐品</div>
                        <div class="panel-body">
                            <c:if test="${empty foodTypes}">
                                <div class="well">
                                    注意：当前没有任何的餐品类型，请 <a href="/shangjia/manage/foodtypes/new">添加</a> 后再操作。
                                </div>
                            </c:if>
                            <c:if test="${not empty foodTypes}">
                            <div class="col-lg-12">
                            <form id="newFoodForm" action="/shangjia/manage/foods/new"  method="post">
                            	<input type="hidden" id="qiniuToken" value="${requestScope.token}"/>
                                <input type="hidden" id="fphoto" name="fphoto" />
                                <div class="form-group">
                                    <label>餐品名称</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <input class="form-control" type="text" name="fname"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>价格</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <input class="form-control" type="text" name="fprice"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>餐品类型</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <select name="ftid" class="form-control">
                                                <c:forEach items="${foodTypes}" var="type">
                                                    <option value="${type.id}">${type.ftname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>餐品照片</label>
                                    <div id="uploader" class="wu-example">
    								<!--用来存放文件信息-->
    									<div  class="btns">
        								   <div style="width:200px; display:inline-block;" id="picker">请点击选择要上传的文件</div>
    									<!--<div  id="thelist" class="uploader-list"></div>  -->
    									   <div style="width:200px; height:200px;background-color:#888;" id="thelist" class="uploader-list"></div>
    									</div>
									</div>
                                </div>
                                <div class="form-group">
                                    <label>显示顺序</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <input class="form-control" type="text" name="findex"/>
                                        </div>
                                    </div>
                                </div>
                                <button id="saveBtn" type="button" class="btn btn-outline btn-success">保存</button>
                            </form>
                            </div>
                            
                            </c:if>
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
<!-- baidu webUploader -->
<script src="/static/js/webuploader/webuploader.min.js"></script>
<!--  -->
<script src="/static/js/jquery.validate.js"></script>
<script>
	$(document).ready(function(){
		var $newFoodForm = $("#newFoodForm");
		var $fphoto = $("#fphoto");
		var $list = $("#thelist");
		var thumbnailWidth = 200;
		var thumbnailHeight = 200;
		var temp = "";
		
		var uploader = WebUploader.create({
		    // swf文件路径
		    swf: '/static/js/webuploader/Uploader.swf',
		    // 文件接收服务端。
		    server: 'http://upload.qiniu.com/',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#picker',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize: false,
		    formData:{"token":"${requestScope.token}"},
		    // 只允许选择图片文件。
		    accept: {
		        title: 'Images',
		        extensions: 'gif,jpg,jpeg,bmp,png',
		        mimeTypes: 'image/*'
		    }//,
		    //fileNumLimit:1
		});
		
		
		
		$("#saveBtn").on("click", function(){
				$(this).attr("disabled", "disabled");
	            uploader.upload();
		});
		/*$("#saveBtn").on("click", function(){
			if($fphoto.val() != ""){
				$.ajax({
					url:"http://upload.qiniu.com/",
					data:{"file":$("#photo"))}
				});
			}else{
				
			}
		});*/
		
		
		
		
		// 当有文件添加进来的时候
		uploader.on( 'fileQueued', function( file ) {
			if(temp != ""){
				uploader.removeFile(temp,true);
				$list.html("");
			}
		    var $li = $(
		            '<div style="width:200px;heigh：200px;" id="' + file.id + '" class="file-item thumbnail">' +
		                '<img>' +
		                '<div class="info">' + file.name + '</div>' +
		            '</div>'
		            ),
		        $img = $li.find('img');
		    temp = file.id;
		    // $list为容器jQuery实例
		    $list.append( $li );

		    // 创建缩略图
		    // 如果为非图片文件，可以不用调用此方法。
		    // thumbnailWidth x thumbnailHeight 为 100 x 100
		    uploader.makeThumb( file, function( error, src ) {
		        if ( error ) {
		            $img.replaceWith('<span>不能预览</span>');
		            return;
		        }

		        $img.attr( 'src', src );
		    }, 200, 200 );
		});
		
		
		// 文件上传过程中创建进度条实时显示。
		uploader.on( 'uploadProgress', function( file, percentage ) {
		    var $li = $( '#'+file.id ),
		        $percent = $li.find('.progress span');

		    // 避免重复创建
		    if ( !$percent.length ) {
		        $percent = $('<p class="progress"><span></span></p>')
		                .appendTo( $li )
		                .find('span');
		    }

		    $percent.css( 'width', percentage * 100 + '%' );
		});

		// 文件上传成功，给item添加成功class, 用样式标记上传成功。
		uploader.on( 'uploadSuccess', function( file ) {
		    $( '#'+file.id ).addClass('upload-state-done');
		});

		// 文件上传失败，显示上传出错。
		uploader.on( 'uploadError', function( file ) {
			$(this).remove("disabled");
		    var $li = $( '#'+file.id ),
		        $error = $li.find('div.error');

		    // 避免重复创建
		    if ( !$error.length ) {
		        $error = $('<div class="error"></div>').appendTo( $li );
		    }

		    $error.text('上传失败');
		});

		// 完成上传完了，成功或者失败，先删除进度条。
		uploader.on( 'uploadComplete', function( file ) {
		    $( '#'+file.id ).find('.progress').remove();
		});
		
		//接受服务器返回的值
		uploader.on('uploadSuccess', function(file, response){
			
			$fphoto.val(response.key);
			//上传表单
			//$newFoodForm.submit();
		});
		
		
		
	});
</script>

</body>
</html>