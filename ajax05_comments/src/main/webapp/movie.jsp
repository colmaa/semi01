<%@page import="java.util.ArrayList"%>
<%@page import="test.dao.CommentsDao"%>
<%@page import="test.vo.CommentsVo"%>
<%@page import="test.vo.MovieVo"%>
<%@page import="test.dao.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	let xhr = null;
	window.onload=function(){
		commList(1);
	}
	
	function commList(pageNum){
		xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4 && xhr.status==200){
				var result = xhr.responseText;
				let commList = document.getElementById("commList");
				
				let child = commList.childNodes; // 자식노드 얻어오기
				for(let i=child.length-1;i>=0;i--){
					let c = child.item(i);
					commList.removeChild(c);
				}
				let data = JSON.parse(result);
				let comm = data.list;

				for(let i=0;i<comm.length;i++){
					let id = comm[i].id;
					let comments = comm[i].comments;
					let num = comm[i].num;
					let mnum = comm[i].mnum;
					let div = document.createElement("div");
					div.className = "comm";
					div.innerHTML = "아이디:" + id + "<br>" +
									 "내용:" + comments + "<br>" +
									 "<a href='javascript:delComm("+num+")'>삭제</a> " +
									 "<a href=''>수정</a>";
					commList.appendChild(div);
				}
				let startPage = data.startPage;
				let endPage = data.endPage;
				let pageCount = data.pageCount;
				let pageHTML = "";
				if(startPage>5){
					pageHTML += "<a href='javascript:commList("+ (startPage-1) +")'>이전</a>";
				}
				for(let i=startPage;i<=endPage;i++){
					if(i==pageNum){
						pageHTML +="<a href='javascript:commList("+ i +")'><span style='color:blue'>["+ i +"]</span></a>";
					}else{
						pageHTML +="<a href='javascript:commList("+ i +")'><span style='color:gray'>["+ i +"]</span></a>";
					}
				}
				if(endPage<pageCount){
					pageHTML +="<a href='javascript:commList("+ (endPage+1) +")'>다음</a>";
				}
				var page = document.getElementById("page");
				page.innerHTML = pageHTML;
			}
		};
		xhr.open('get','${pageContext.request.contextPath}/comm/list?mnum=${vo.mnum}&pageNum='+pageNum,true);
		xhr.send();
	}
	
	function addComm(){
		let id = document.getElementById("id").value;
		let comments = document.getElementById("comments").value;
		xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4 && xhr.status==200){
				let data = xhr.responseText;
				let json = JSON.parse(data);
				if(json.code=='success'){
					alert('글등록성공');
					commList(1);
				}else{
					alert('댓글 등록 실패');
				}
			}
		};
		xhr.open('post','${pageContext.request.contextPath}/comm/insert',true);
		xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		let param = "id=" + id + "&comments=" + comments + "&mnum=${vo.mnum}";
		xhr.send(param);
	}
	
	function delComm(num){
		xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4 && xhr.status==200){
				let data = xhr.responseText;
				let json = JSON.parse(data);
				if(json.code=='success'){
					alert('글삭제성공');
					commList(1);
				}else{
					alert('글삭제실패');
				}
			}
		};
		xhr.open('post','${pageContext.request.contextPath}/comm/del?num='+num,true);
		xhr.send();
	}
</script>
<style type="text/css">
.comm{
	width: 400px;
	height: 100px;
	border: 1px solid #ccc;
	margin-bottom: 5px;
}
</style>
</head>
<body>
<h1>movie.jsp</h1>
<div style="width:400px;height:200px;background-color:#ccc">
	<h1>${vo.title }</h1>
	<p>
		내용:${vo.content }<br>
		감독:${vo.director }<br>
	</p>
</div>
<div>
	<!-- 댓글목록이 보여질 div -->
	<div id="commList"></div>
	<!-- 페이징처리 -->
	<div id="page"></div>
	<div id="commAdd">
		아이디<br>
		<input type="text" id="id"><br>
		영화평<br>
		<textarea cols="50" rows="5" id="comments"></textarea><br>
		<input type="button" value="등록" onclick="addComm()">
	</div>
</div>
</body>
</html>