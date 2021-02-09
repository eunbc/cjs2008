<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mIdSearch.jsp</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
<div class="container" style="padding:30px;">
  <h2>아이디 찾기</h2>
  <p>(회원가입시에 등록한 메일주소를 입력하세요.)</p>
  <form method="post" class="was-validated">
    <div class="form-group">
      <label for="email">메일주소 : </label>
      <input type="text" class="form-control" name="email" id="email" placeholder="메일주소를 입력하세요" required/>
      <div class="valid-feedback">정확한 메일주소를 입력하세요.</div>
      <div class="invalid-feedback">메일주소는 필수 입력사항입니다.</div>
    </div>
    
    <button type="submit" class="btn btn-secondary">인증하기</button>&nbsp;
    <button type="reset" class="btn btn-secondary">취소</button>&nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/';">돌아가기</button>
  </form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>