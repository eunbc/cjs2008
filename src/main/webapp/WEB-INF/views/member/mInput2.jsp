<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>jquery 테스트</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
	<script>
	$(document).ready(function() {

	    //아이디 중복확인
	    $("#mem_id").blur(function() {
	        if($('#mem_id').val()==''){
	            $('#id_check').text('아이디를 입력하세요.');
	            $('#id_check').css('color', 'red');                     
	        }
	    });
	});    
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
      <div class="form-group">
                        <label for="id">아이디</label>
                        <input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="ID">
                        <div class="eheck_font" id="id_check"></div>
                    </div>
                    

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>