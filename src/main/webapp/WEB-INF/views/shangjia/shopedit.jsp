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
	<link rel="stylesheet" href="/static/js/timeselector/theme/jquery.timeselector.css" />
	
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
                    <h3 class="page-header">修改商铺运营信息</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-red">
                        <div class="panel-heading">修改商铺运营信息</div>
                        <div class="panel-body">

                            <form id="editShopForm" method="post">
                                <input type="hidden" name="id" value="${requestScope.businessInfo.id}"/>
                                <div class="form-group">
                                    <label>起送价格</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <input class="form-control" type="text" name="bspoststartprice" value="${requestScope.businessInfo.bspoststartprice}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>配送费用（留空表示无配送费用）</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <input class="form-control" type="text" name="bspostprice"  value="${requestScope.businessInfo.bspostprice}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>上午营业时间</label>
                                    <div class="row">
                                        <div class="col-xs-2">
                                            <input class="form-control time" type="text" name="bsamhourstart"  value="${requestScope.businessInfo.bsamhourstart}"/>-
                                        </div>
                                        <div class="col-xs-2">
                                            <input class="form-control time" type="text" name="bsamhourend"  value="${requestScope.businessInfo.bsamhourend}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>下午营业时间</label>
                                    <div class="row">
                                        <div class="col-xs-2">
                                            <input class="form-control time"  type="text" name="bspmhourstart"  value="${requestScope.businessInfo.bspmhourstart}"/>-
                                        </div>
                                        <div class="col-xs-2">
                                            <input class="form-control time" type="text" name="bspmhourend"  value="${requestScope.businessInfo.bspmhourend}"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" id="bsphoto" name="bsphoto" value="${requestScope.businessInfo.bsphoto}"/>
                                    <label>商家封面照片</label>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div id="uploader" class="wu-example">
    										<!--用来存放文件信息-->
    											<div  class="btns">
        								   			<div style="width:200px; display:inline-block;" id="picker">请点击选择要上传的文件</div>
    									   			<div style="width:200px; height:200px;background-color:#888;" id="thelist" class="uploader-list">
    									   			<c:if test="${not empty requestScope.businessInfo.bsphoto}">
    									   			<img src="http://7xkr3z.com1.z0.glb.clouddn.com/${requestScope.businessInfo.bsphoto}-size200"
                                                     alt=""/>
                                                     </c:if>
    									   			</div>
    											</div>
											</div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>商家公告</label>
                                    <div class="row">
                                        <div class="col-xs-8">
                                            <textarea name="bscontent" id="" rows="8" class="form-control">${requestScope.businessInfo.bscontent}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <button id="editBtn" type="button" class="btn btn-outline btn-success">保存</button>
                            </form>

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
<!-- jquery 验证 -->
<script src="/static/js/jquery.validate.js"></script>
<!--jquery timeselect 时间选择器  -->
<script src="/static/js/timeselector/jquery.timeselector.js"></script>

<script>
	$(document).ready(function(){
		var $editShopForm = $("#editShopForm");
		var $bsphoto = $("#bsphoto");
		var $list = $("#thelist");
		var temp = "";
		
		//加载时间选择插件
		$('.time').timeselector({'hours12':false});
		
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
		
	
		
		$("#editBtn").on("click", function(){
				 $(this).attr("disabled", "disabled");
				if(uploader.getFiles().length > 0){
					uploader.upload();
				}else{
					$.ajax({
						url:'/shangjia/manage/shop/edit',
						type:'post',
						data:$editShopForm.serialize(),
						success:function(json){
							if(json.state == 'success'){
								window.location.href="/shangjia/manage/shop";
							}else{
								$("#editBtn").removeAttr("disabled");
								alert(json.message);
							}
						},
						error:function(){
							$("#editBtn").removeAttr("disabled");
							alert("网络异常，请稍后重试");
						}
					}); 
				}
	            
		});
		
		
		
		
		// 当有文件添加进来的时候
		uploader.on( 'fileQueued', function( file ) {
			$list.html("");
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
			$("#editBtn").removeAttr("disabled");
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
			
			$bsphoto.val(response.key);
			//上传表单
			$.ajax({
				url:'/shangjia/manage/shop/edit',
				type:'post',
				data:$editShopForm.serialize(),
				success:function(json){
					if(json.state == 'success'){
						window.location.href="/shangjia/manage/shop";
					}else{
						$("#editBtn").removeAttr("disabled");
						alert(json.message);
					}
				},
				error:function(){
					$("#editBtn").removeAttr("disabled");
					alert("网络异常，请稍后重试");
				}
			});
			
		});
		
		
		
	});
</script>

</body>
</html>