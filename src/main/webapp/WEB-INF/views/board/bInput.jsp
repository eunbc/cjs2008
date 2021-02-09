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
	<title>bInput.jsp</title>
	<script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
<%@ include file="/WEB-INF/views/include/Slide.jsp"%>
<div class="container">
	<form name="myform" method="post">
		<table>
			<tr>
				<td><h2>게시판 글쓰기</h2></td>
			</tr>
		</table>
		<table>
			<tr>
				<th>글쓴이</th>
				<td><input type="text" name="name" value="${snickname}"/></td>
			</tr>
			<tr>
				<th>글제목</th>
				<td><input type="text" name="title"/></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email"/></td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td><input type="text" name="homepage" value="http://"/></td>
			</tr>
			<tr>
				<th>글내용</th>
				<td><textarea rows="5" name="content" id="CKEDITOR"></textarea></td>
				<script type="text/javascript">
					CKEDITOR.replace("content", {
						uploadUrl:"${contextPath}/imageUpload",	//드래그 앤 드롭					
						filebrowserUploadUrl: "${contextPath}/imageUpload", //파일은 이 경로로 업로드
						height : 500
					});
				</script>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="글올리기"/>
					<input type="reset" value="다시쓰기"/>
					<input type="button" value="돌아가기" onclick="location.href='${contextPath}/board/bList';"/>
				</td>
			</tr>
		</table>
		<input type="hidden" name="hostip" value="<%=request.getRemoteAddr()%>"/>
		<input type="hidden" name="mid" value="${smid}"/>
	</form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>