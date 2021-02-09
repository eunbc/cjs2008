<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var = "contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>spring</title>
	<script>
	</script>
	<style>
		
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
<p><br></p><p><br></p>
<div class="container">
	<h1 class="text-center">아 이 디 찾 기</h1>
	<br/>
	<hr>
	<div class="text-center">
	<c:if test="${!empty foundMid}">
		<h3>찾은 ${name}님의 아이디입니다.</h3><br>
		<c:forEach var="mid" items="${foundMid}">
			${mid}<br>
		</c:forEach>
		<br/>
		<input type="button" class="btn btn-secondary" value="로그인" onclick="location.href='${contextPath}/member/mLogin'">
		<input type="button" class="btn btn-outline-secondary" value="다시찾기" onclick="location.href='${contextPath}/member/mMidSearch'">
	</c:if>
	<c:if test="${empty foundMid}">
		<h3>${name}님의 아이디가 존재하지 않습니다.</h3>
		<br/>
		<input type="button" class="btn btn-secondary" value="회원가입" onclick="location.href='${contextPath}/member/mInput'">
		<input type="button" class="btn btn-outline-secondary" value="다시찾기" onclick="location.href='${contextPath}/member/mMidSearch'">
	</c:if>
	</div>
</div>
<p><br/><p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>