<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mLogin.jsp</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
  	  $(document).ready(function() {
  		  $("#loginBtn").click(function() {
  			  var rememberId = $("#rememberId").is(":checked");
			  if(rememberId==true) {
				  $("#rememberId").val('YES');
			  } 
			  else if(rememberId==false) {
				  $("#rememberId").val('NO');
			  } 

			  //alert('아이디 기억하기에 저장된 변수'+$("#rememberId").val()); 여기까지는 NO가 잘 넘어옴. 근데 왜 null로 들어가지?
  			  if($("#mid").val()=='') {
  				  alert("아이디를 입력하세요.");
  				  return false;
  			  }
  			  else if($("#pwd").val()=='') {
  				  alert("비밀번호를 입력하세요.");
  				  return false;
  			  } else {
  				  myform.submit(); 
  			  }
  		  });
  	  });
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
<c:if test="${not empty cmid}"> <!-- 쿠키가 비어있지 않다면 체크박스 checked 속성 줌 -->
  <c:set value="checked" var="checked"/>
</c:if>
<div class="container" style="padding:30px;">
  <h2>회원 로그인</h2>
  <p>회원 아이디와 비밀번호를 입력해 주세요</p>
  <form name="myform" method="post" class="was-validated">
    <div class="form-group">
      <label for="mid">회원 아이디 :</label>
      <input type="text" class="form-control" name="mid" id="mid" value="${cmid}" placeholder="회원 아이디를 입력하세요" required autofocus/>
      <div class="valid-feedback">정확한 아이디를 입력하세요.</div>
      <div class="invalid-feedback">회원 아이디는 필수 입력사항입니다.</div>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :</label>
      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" required/>
      <div class="valid-feedback">정확한 비밀번호를 입력하세요.</div>
      <div class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
    </div>
    <div><input type="checkbox" id="rememberId" name="rememberId" ${checked}/>아이디 기억하기</div>
    
    <button type="button" class="btn btn-secondary" id="loginBtn">인증하기</button>&nbsp;
    <button type="reset" class="btn btn-secondary">취소</button>&nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/';">돌아가기</button>&nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/member/mInput';">회원가입</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/member/mMidSearch';">아이디찾기</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/member/mPwdSearch';">비밀번호찾기</button>
  </form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>