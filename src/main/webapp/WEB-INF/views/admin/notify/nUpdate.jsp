<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>nUpdate.jsp</title>
	<%@ include file="/WEB-INF/views/include/bs.jsp" %>
	<script>
    function fCheck() {
    	var title = myform.title.value;
    	var content = myform.content.value;
    	var startDate = myform.startDate.value;
    	var endDate = myform.endDate.value;
    	
    	if(title == "") {
    		alert("공지사항 제목을 입력하세요");
    		myform.title.focus();
    	}
    	else if(content == "") {
    		alert("공지사항 내용을 입력하세요");
    		myform.content.focus();
    	}
    	else if(startDate == "") {
    		alert("공지사항 시작일자를 입력하세요");
    	}
    	else if(endDate == "") {
    		alert("공지사항 마지막일자를 입력하세요");
    	}
    	else {
    		if(startDate > endDate) {
    			alert("공지 종료일은 시작일보다 앞설 수 없습니다.");
    			return false;
    		} else {
		    	if(document.getElementById("popupSw").checked == true) {
		    		document.myform.popupSw.value = "Y";
		    	}
		    	else {
		    		document.myform.popupSw.value = "N";
		    	}
	    		myform.submit();
    		}
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>공지사항 작성</h2>
  <form name="myform" method="post" class="was-validated">
    <div class="form-group">
      <label for="name">글쓴이 : </label>
      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required/>
      <div class="invalid-feedback">공지사항 올리는 사람을 입력하세요.</div>
    </div>
    <div class="form-group">
      <label for="title">글제목 : </label>
      <input type="text" class="form-control" id="title" name="title" value="${vo.title}" required autofocus/>
      <div class="invalid-feedback">공지사항 글제목을 입력하세요.</div>
    </div>
    <div class="form-group">
      <label for="content">공지사항 : </label>
      <textarea rows="5" class="form-control" id="content" name="content" required>${vo.content}</textarea>
      <div class="invalid-feedback">공지사항 올리는 사람을 입력하세요.</div>
    </div>
    <div class="form-group">
      <label for="startDate">공지사항 시작날짜</label>
      <c:set var="startDate" value="${fn:substring(vo.startDate,0,10)}"/>
      <c:set var="endDate" value="${fn:substring(vo.endDate,0,10)}"/>
      <input type="date" class="form-control" id="startDate" name="startDate" value="${startDate}" required />
      <div class="invalid-feedback">공지 시작일자를 입력하세요.</div>
    </div>
    <div class="form-group">
      <label for="endDate">공지사항 종료날짜</label>
      <input type="date" class="form-control" id="endDate" name="endDate" value="${endDate}" required/>
      <div class="invalid-feedback">공지 종료일자를 입력하세요.</div>
    </div>
    <div class="form-group">
      초기화면 공지여부 : &nbsp; &nbsp;
      <input type="checkbox" id="popupSw" name="popupSw" <c:if test="${vo.popupSw=='Y'}">checked</c:if> />초기화면에 팝업창을 띄웁니다.
    </div>
    <br/>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <div>
      <button type="button" class="btn btn-secondary" onclick="fCheck()">공지사항등록</button> &nbsp;
      <button type="reset" class="btn btn-secondary">취소</button> &nbsp;
      <button type="button" class="btn btn-secondary" onclick="javascript:location.href='${contextPath}/notify/nList';">돌아가기</button>
    </div>
  </form>
</div>
</body>
</html>