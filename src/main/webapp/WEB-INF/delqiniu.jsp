<%@ page language="java" contentType="text/html; charset=UTF-8}"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<h2>hello,world1</h2>
<button id="submit">点击删除</button>

<script src="/static/js/jquery-2.1.3.min.js" type="text/javascript"></script>
<script>
	$("#submit").on("click", function(){
		$.ajax({
			url:'http://rs.qiniu.com/delete/',
			type:'post',
			data:{'bmV3ZG9jczpmaW5kX21hbi50eHQ':'HTTP/1.1'}
		});
	});
</script>
</body>
</html>