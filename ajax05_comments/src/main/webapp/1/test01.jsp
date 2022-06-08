<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function getMovie(n){
		let xhr=new XMLHttpRequest();
		xhr.onreadystatechange=function(){
			if(xhr.readyState==4 && xhr.status==200){
				//alert('success');
				let result=xhr.responseText;
				//alert(result);
				document.getElementById("div1").innerHTML=result;
			}
		};
		xhr.open('get','server1.jsp?num='+n,true);
		xhr.send();
	}
</script>
</head>
<body>
<input type="button" value="현재 상영작" id="btn1" onclick="getMovie(1)">
<input type="button" value="인기 상영작" id="btn2" onclick="getMovie(2)">
<div id="div1">
</div>
</body>
</html>