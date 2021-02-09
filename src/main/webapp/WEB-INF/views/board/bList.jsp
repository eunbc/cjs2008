<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>bList.jsp</title>
	<style>
		#title td {background-color: skyblue; font-weight: 800;}
		table {margin: 0 auto; width: 800px;}
		tr td {padding: 7px; border-bottom: 1px gray;}
		h2 {text-align: center;}
	</style>
	<script>
		function pageSizeCheck() {
			var pageSize = pageForm.pageSize.value;
			location.href="${contextPath}/board/bList?pag=${p.pag}&pageSize="+pageSize;
		}
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
<%@ include file="/WEB-INF/views/include/Slide.jsp"%>
<div class="container">
	<h2>게 시 판 리 스 트</h2>
	<table class="table table-striped">
		<tr>
			<td colspan="4">
				<button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/board/bInput';">글올리기</button>
			</td>
			<td colspan="2" style="text-align: right">
				<form name="pageForm">
					<select name="pageSize" class="form-control" onchange="pageSizeCheck()">
						<option value="5" <c:if test="${p.pageSize=='5'}">selected</c:if>>5</option>
						<option value="10" <c:if test="${p.pageSize=='10'}">selected</c:if>>10</option>
						<option value="15" <c:if test="${p.pageSize=='15'}">selected</c:if>>15</option>
						<option value="20" <c:if test="${p.pageSize=='20'}">selected</c:if>>20</option>
					</select>
				</form>
			</td>
		</tr>
		<tr id="title">
			<td>글번호</td>
			<td>글제목</td>
			<td>작성자</td>
			<td>글쓴날짜</td>
			<td>조회수</td>
			<td>댓글수</td>
		</tr>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${curScrNo}</td>
				<td><a href="${contextPath}/board/bContent?idx=${vo.idx}&pag=${p.pag}&pageSize=${p.pageSize}">${vo.title}</a></td>
				<td>${vo.name}</td>
				<td>${vo.wdate}</td>
				<td>${vo.readnum}</td>
				<td>0</td>
			</tr>
			<c:set var="curScrNo" value="${curScrNo-1}"/>
		</c:forEach>
	</table>
	
	<!-- 페이징 처리 시작 -->
      <div class="row">
          <div class="col-12">
		<ul class="pagination justify-content-center" style="margin:20px 0">
			<c:set var="startPageNum" value="${p.pag- (p.pag-1)%(p.blockSize)}"/>
			<c:if test="${p.pag != 1}">
	  			<li class="page-item"><a class="page-link" href="${contextPath}/board/bList?pag=1&pageSize=${p.pageSize}">◀</a></li>
	  			<li class="page-item"><a class="page-link" href="${contextPath}/board/bList?pag=${p.pag-1}&pageSize=${p.pageSize}">◁</a></li>
			</c:if>
			<c:if test="${p.pag == 1}">
	  			<li class="page-item disabled"><a class="page-link" href="${contextPath}/board/bList?pag=1&pageSize=${p.pageSize}">◀</a></li>
	  			<li class="page-item disabled"><a class="page-link" href="${contextPath}/board/bList?pag=${p.pag-1}&pageSize=${p.pageSize}">◁</a></li>
			</c:if>
			<c:forEach var="i" begin="0" end="2">
				<c:if test="${(startPageNum + i)<=p.totPage}">
					<c:if test="${(startPageNum + i)==p.pag}">
			  			<li class="page-item active"><b><a class="page-link" href="${contextPath}/board/bList?pag=${startPageNum + i}&pageSize=${p.pageSize}">${startPageNum + i }</a></b></li>
					</c:if>
					<c:if test="${(startPageNum + i)!=p.pag}">
						<li class="page-item"><a class="page-link" href="${contextPath}/board/bList?pag=${startPageNum + i}&pageSize=${p.pageSize}">${startPageNum + i }</a></li>
					</c:if>
				</c:if>
			</c:forEach>
			<c:if test="${p.pag != p.totPage}">
				<li class="page-item"><a class="page-link" href="${contextPath}/board/bList?pag=${p.pag+1}&pageSize=${p.pageSize}">▷</a></li>
				<li class="page-item"><a class="page-link" href="${contextPath}/board/bList?pag=${p.totPage}&pageSize=${p.pageSize}">▶</a></li>
			</c:if>
			<c:if test="${p.pag == p.totPage}">
				<li class="page-item disabled"><a class="page-link" href="${contextPath}/board/bList?pag=${p.pag+1}&pageSize=${p.pageSize}">▷</a></li>
				<li class="page-item disabled"><a class="page-link" href="${contextPath}/board/bList?pag=${p.totPage}&pageSize=${p.pageSize}">▶</a></li>
			</c:if>
		</ul>            
          </div>
      </div>
      <!-- 페이징 처리 끝 -->		
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>