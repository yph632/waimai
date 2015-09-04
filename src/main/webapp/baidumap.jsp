<%@ page language="java" contentType="text/html; charset=UTF-8}"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>练习百度地图</title>
</head>
<style type="text/css">
	html{height:100%}  
	body{height:100%;margin:0px;padding:0px}  
	#map{height:100%}  
</style>  
	<link rel="stylesheet" href="/static/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/static/css/layout2.css" />
<body>
<div class="container udMargin">
	<input id="inputSearch" class="form-control" type="text" placeholder="请输入要查询的地址信息"/>
</div>
<div class="container">
	<div id="map" style="width:70%px;height:500px; background-color:#555;"></div>  
</div>

<div class="container">
	<div id="results"></div>
</div>

<script src="/static/js/jquery-1.11.3.min.js"></script>
<script src="http://api.map.baidu.com/api?v=1.5&ak=QClqiFmIqDdBG51icW3V5AhR"></script>
	
<script>
	$(document).ready(function(){
		var position = '焦作';
		var map = new BMap.Map("map");          // 创建地图实例  
		//var point = new BMap.Point(116.404, 39.915);  // 创建点坐标  
		map.centerAndZoom("焦作市");                 // 初始化地图，设置中心点坐标和地图级别  
		
		/////////////////控件/////////////////////////
		map.addControl(new BMap.NavigationControl());
		map.addControl(new BMap.ScaleControl());    
		map.addControl(new BMap.OverviewMapControl());    
		map.addControl(new BMap.MapTypeControl());    
		map.setCurrentCity(position); // 仅当设置城市信息时，MapTypeControl的切换功能才能可用
		
		///////////////////////////////////////////////
		//var marker = new BMap.Marker(point);        // 创建标注    
		var marker = null;
		map.addEventListener("click", function(e){  
			if(marker){
				map.removeOverlay(marker);
			}
			var point2 = new BMap.Point(e.point.lng, e.point.lat);
			marker = new BMap.Marker(point2);
			map.addOverlay(marker);                     // 将标注添加到地图中
		
			});
	

	
	$("#inputSearch").keydown(function(event){
		if(event.keyCode == 13){
			var local = new BMap.LocalSearch('焦作市',   
		            {renderOptions: {map: map,panel: "results"}});      
		local.search($(this).val());
		}
		
		});
	});
</script>

</body>
</html>