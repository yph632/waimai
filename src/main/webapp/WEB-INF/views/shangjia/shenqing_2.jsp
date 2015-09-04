<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/static/css/b3/bootstrap.css"/>
    <link rel="stylesheet" href="/static/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="/static/css/layout2.css" />
    <link rel="stylesheet" href="/static/js/webuploader/webuploader.css" />
</head>
<body>

<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">

            <a class="navbar-brand" href="#"><i class="fa fa-maxcdn"></i> 美餐</a>
        </div>


    </div><!-- /.container-fluid -->
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-danger">
                <div class="panel-heading">商家申请-选择地址</div>
                <div class="panel-body">
                    <div class="form-group">
                        <label>选择地址（单击地图添加位置）</label>
                        <input type="text" class="form-control" id="address"/>
                        <div id="map" style="height: 400px;margin-top: 15px;position: relative"></div>
                        <div id="map-result" style="height: 300px;width: 300px;position: absolute;right: 40px;top: 150px;z-index: 99999;"></div>
                    </div>
                </div>
            </div>
            <div class="panel panel-danger">
                <div class="panel-heading">商家申请-基本信息</div>
                <div class="panel-body">
                    <div class="form-group">
                        <form id="regForm" action="/shangjia/step2" method="post">
                            <input type="hidden" id="lng" name="bslng"/>
                            <input type="hidden" id="lat" name="bslat"/>
                            <input type="hidden" id= 'bsphoto' name='bsphoto'/>
                            <div class="form-group">
                                <label>商家名称</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="text" class="form-control" name="bsname"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>详细地址</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="text" class="form-control " name="bsaddress"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>负责人</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="text" class="form-control" name="bsman"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>手机号码</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="text" class="form-control" name="bstel" value="${sessionScope.phoneCode}" readonly/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>餐厅分类</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <select name="bstype" id="" class="form-control">
                                            <option value=""></option>
                                            <option value="中式">中式</option>
                                            <option value="台式">台式</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>营业执照照片</label>
                                <div class="row">
                                    <div id="uploader" class="wu-example">
    								<!--用来存放文件信息-->
    									<div  class="btns">
        									<div id="picker">请点击选择要上传的文件</div>
    									<!--<div  id="thelist" class="uploader-list"></div>  -->
    										<div style="width:200px; height:200px;background-color:#888;" id="thelist" class="uploader-list"></div>
    									</div>
									</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>营业执照号码</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="text" class="form-control" name="bscardnum"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>营业执照所在地</label>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <input type="text" class="form-control" name="bscardaddress"/>
                                    </div>
                                </div>
                            </div>
                            <button id="regBtn" type="button" class="btn btn-success">申请</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/static/js/jquery.1.11.1.min.js"></script>
<script src="/static/js/b3/bootstrap.min.js"></script>
<script src="/static/js/bootbox.min.js"></script>
<script src="/static/js/jquery.validate.min.js"></script>
<script src="http://api.map.baidu.com/api?v=1.5&ak=QClqiFmIqDdBG51icW3V5AhR"></script>
<script src="/static/js/webuploader/webuploader.min.js"></script>
<script>
    $(document).ready(function(){

    	var $regForm = $("#regForm");
    	var $regBtn = $("#regBtn");
    	var $lng= $("#lng");
    	var $lat = $("#lat");
    	
    	
    	
    	$regForm.validate({
    		rules:{
    			bsphoto:{
    				required:true
    			},
    			
    			bsname:{
    				required:true
    			},
    			bsaddress:{
    				required:true
    			},
    			bsman:{
    				required:true
    			},
    			bstype:{
    				required:true
    			},
    			bscardnum:{
    				required:true
    			},
    			bscardaddress:{
    				required:true
    			}
    		},
    		messages:{
    			bsphoto:{
    				required:true
    			},
    			bsname:{
    				required:'请输入餐厅名字'
    			},
    			bsaddress:{
    				required:'请输入餐厅地址'
    			},
    			bsman:{
    				required:'请输入餐厅注册人'
    			},
    			bstype:{
    				required:'请选择餐厅类型'
    			},
    			bscardnum:{
    				required:'请填写证件号'
    			},
    			bscardaddress:{
    				required:'请输入证件号注册地址'
    			}
    		},
    		error:'span',
    		errorClass:'errorSpan',
    		errorPlacement: function(error, element){
    			console.log("lalal");
				error.appendTo(element.parent());	
			}
    	});
    	
    	
		///////百度地图//////	

        var map = new BMap.Map("map");          // 创建地图实例
        map.centerAndZoom("河南省焦作市", 15);
        map.addControl(new BMap.NavigationControl());
        map.addControl(new BMap.ScaleControl());
        map.addControl(new BMap.OverviewMapControl());
        map.addControl(new BMap.MapTypeControl());

        var marker = null;
        map.addEventListener("click", function(e){
            if(marker) {
                map.removeOverlay(marker);
            }
            console.log(e.point.lng + ", " + e.point.lat);
            var point = new BMap.Point(e.point.lng ,e.point.lat);
            marker = new BMap.Marker(point);        // 创建标注
            map.addOverlay(marker);

            //将经纬度放入隐藏域中
            $("#lng").val(e.point.lng);
            $("#lat").val(e.point.lat);

        });

        $("#address").keydown(function(event){
            if(event.keyCode == 13) {
                var local = new BMap.LocalSearch("焦作市", {
                    renderOptions: {map: map, panel: "map-result"}
                });
                local.setPageCapacity(5);
                local.search($(this).val());

                var results = local.getResults();
                event.preventDefault();
            }
        });

			//七牛上传
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
		
        $regBtn.on("click", function(){
    		if($lng.val() == '' || $lat.val() == ''){
    			bootbox.alert("请在地图上点击标注，以选择商店的位置");
    		}else if($("#bsphoto").val() == ''){
    			$regForm.submit();
				bootbox.alert("请上传照片");
			}else{
				$(this).attr("disabled", "disabled");
            	uploader.upload();
			}
    	});
    	
		
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
			$regForm.submit();
		});


    });
</script>
</body>
</html>