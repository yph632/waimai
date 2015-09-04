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
<body>
<div id="map" style="width:600px;height:800px; background-color:#555;"></div>  



<script src="/static/js/jquery-1.11.3.min.js"></script>
<script src="http://api.map.baidu.com/api?v=1.5&ak=QClqiFmIqDdBG51icW3V5AhR"></script>
	
<script>
	$(document).ready(function(){
		var map = new BMap.Map("map");          // 创建地图实例  
		var point = new BMap.Point(116.404, 39.915);  // 创建点坐标  
		map.centerAndZoom(point, 15);                 // 初始化地图，设置中心点坐标和地图级别  
	});
</script>

</body>
</html>