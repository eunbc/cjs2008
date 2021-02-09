<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<%@ include file="/WEB-INF/views/include/bs.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>popup.jsp</title>
	<script>
		function closePopup() {
			if(document.getElementById("check").value) {
				setCookie("popupYN","N",1);
				self.close();
			}
		}
		
		//쿠키 유효시간 1일 : date.setTime(date.getTime()+ (expiredays * 24 * 60 * 60 * 1000))
		//유효시간 1분 : date.setMinutes(date.getMinutes()+ expiredays)
		//setCookie(쿠키명, 쿠키값, 쿠키유효시간)
		
		function setCookie(name, value, expiredays) {
			var date = new Date();
			date.setDate(date.getDate()+expiredays);
			document.cookie = escape(name) + "=" + escape(value) + "; expires=" + date.toUTCString() + "; path=${contextPath}";
		}
		//공지사항 전체 보기
		function notifyView() {
			opener.location.href = "${contextPath}/notify/mnList";
			window.close();
		}
	</script>
</head>
<body>
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">${vo.title}</h4>
        <button type="button" class="close" onclick="window.close()">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
		${vo.content}
      </div>
	  <hr/>	
      <div>
        <p>공지사항 게시기간</p>
        <p>${vo.startDate} ~ ${vo.endDate}</p>
      </div>
	  <hr/>	
      <!-- Modal footer -->
      <div class="modal-footer">
        <input type="checkbox" id="check" onclick="closePopup();" class="form-control" />
        <font size="3"><b>오늘 더이상 보지 않기</b></font>
        <a href="javascript:notifyView()">공지사항</a>
      </div>

    </div>
  </div>
</body>
</html>