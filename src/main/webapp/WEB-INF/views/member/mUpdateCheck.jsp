<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mUpdateCheck.jsp</title>
	<script>
		function pwdCheck(){
			if(pwdForm.pwd.value==""){
				alert('비밀번호를 입력해주세요');
				loginForm.pwd.focus();
			}
			else{
				pwdForm.submit();
			}
		}
	</script>	
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
<%@ include file="/WEB-INF/views/include/Slide.jsp"%>
<p><br/></p>
<div class="container">

<form name="pwdForm" method="post">
	<h1 class="text-center">정 보 수 정</h1>
	<br/>
	<div class="row">
		<div class="col-3">
		</div>
		<div class="col-2 text-center">
			비밀번호 확인
		</div>
		<div class="col-3">
			<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" autofocus>
		</div>
		<div class="col-4">
		</div>
	</div>
	<br/>
	<div class="row">
		<div class="col-12 text-center">
			<input type="button" class="btn btn-outline-secondary" onclick="pwdCheck()" value="확인">
		</div>
	</div>
</form>

</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>