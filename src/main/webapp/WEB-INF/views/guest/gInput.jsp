<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/resources/bs.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>gInput.jsp</title>
	<style>
		h2{text-align: center;}
		#content{
			width: 700px;
			margin: 0 auto;
		}
	</style>
	<script>
		function fCheck() {
			var name = myform.name.value;
			var email = myform.email.value;
			var homepage = myform.homepage.value;
			var content = myform.content.value;
			
			if(name=="") {
				alert("이름을 입력하세요");
				myform.name.focus();
			}
			else if(email=="") {
				alert("이메일을 입력하세요");
				myform.email.focus();
			}
			else if(homepage=="") {
				alert("홈페이지 주소를 입력하세요");
				myform.homepage.focus();
			}
			else if(content=="") {
				alert("내용을 입력하세요");
				myform.content.focus();
			}
			else {
				myform.submit();
			}
		}
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
<div class="container">
	<div id ="content">
		<p><br/></p>
		<h2>방명록 작성하기</h2>
		<form name="myform" method="post" action="${contextPath}/guest/gInput">
			<div class="form-group">
			    <label for="name">이름:</label>
			    <input type="text" class="form-control" name="name" maxlength="20" placeholder="이름">
			</div>
			<div class="form-group">
			    <label for="email">이메일:</label>
			    <input type="text" class="form-control" name="email" maxlength="60" placeholder="이메일">
			</div>
			<div class="form-group">
			    <label for="homepage">홈페이지:</label>
			    <input type="text" class="form-control" name="homepage" maxlength="60" placeholder="홈페이지">
			</div>
			<div class="form-group">
			    <label for="content">내용:</label>
				<textarea name="content" class="form-control" rows="5" cols="50" placeholder="내용을 입력하세요"></textarea>
			</div>
			<div style="text-align:center;">
				<button type="button" class="btn btn-success" onclick="fCheck()">작성하기</button>
				<button type="reset" class="btn btn-outline-success">다시작성</button>
				<button type="button" class="btn btn-outline-success" onclick="location.href='${contextPath}/guest/gList'">돌아가기</button>
			</div>
			<input type="hidden" name="hostip" value="<%=request.getRemoteAddr()%>"/>
		</form>
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>