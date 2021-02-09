<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<%@ include file="/resources/bs.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>gList.jsp</title>
    <style>
    	h2 {font-family: "배달의민족 주아"}
		#content{
			width: 700px;
			margin: 0 auto;
			border: 5px solid rgba(163, 204, 163);
			border-radius: 1em;
			padding-left: 30px;
			padding-right: 30px;
		}
    </style>
	
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
<div class="container">
	<div style="text-align:center;">
		<p><br/></p>
		<h2>방 명 록</h2>
		<button type="button" class="btn btn-outline-success" onclick="location.href='${contextPath}/h'">홈으로 돌아가기</button>
		<button type="button" class="btn btn-success" onclick="location.href='${contextPath}/guest/gInput'">방명록 작성하기</button>
	</div>
	<p><br/></p>
		<c:forEach var="vo" items="${vos}">
			<div id ="content">
				<p><br/></p>
				<div style="color:gray;">
					${curScrNo}
				</div>
				<div>
					<b>${vo.name}</b> | ${fn:substring(vo.vdate,0,16)} | ${vo.email} | ${vo.homepage} 
				</div>
				<hr/>
				<div style="text-align:right;color:gray;">
					${vo.hostip}
				</div>
				<c:set var="content" value="${fn:replace(vo.content,newLine,'<br/>')}"/>
				<div>${content}</div>
				<p><br/></p>
				<hr/>
				<div><a href="${contextPath}/guest/gUpdate?idx=${vo.idx}">수정</a>/<a href="${contextPath}/guest/gDelete?idx=${vo.idx}">삭제</a></div>
				<p><br/></p>
			</div>
				<p><br/></p>
			<c:set var="curScrNo" value="#{curScrNo-1}"/>	
		</c:forEach>
		
		<!-- 페이징 처리 시작 -->
       <div class="row">
           <div class="col-12">
			<ul class="pagination justify-content-center" style="margin:20px 0">
				<c:set var="startPageNum" value="${pag- (pag-1)%blockSize}"/>
				<c:if test="${pag != 1}">
		  			<li class="page-item"><a class="page-link" href="${contextPath}/guest/gList?pag=1">◀</a></li>
		  			<li class="page-item"><a class="page-link" href="${contextPath}/guest/gList?pag=${pag-1}">◁</a></li>
				</c:if>
				<c:if test="${pag == 1}">
		  			<li class="page-item disabled"><a class="page-link" href="${contextPath}/guest/gList?pag=1">◀</a></li>
		  			<li class="page-item disabled"><a class="page-link" href="${contextPath}/guest/gList?pag=${pag-1}">◁</a></li>
				</c:if>
				<c:forEach var="i" begin="0" end="2">
					<c:if test="${(startPageNum + i)<=totPage}">
						<c:if test="${(startPageNum + i)==pag}">
				  			<li class="page-item active"><b><a class="page-link" href="${contextPath}/guest/gList?pag=${startPageNum + i}">${startPageNum + i }</a></b></li>
						</c:if>
						<c:if test="${(startPageNum + i)!=pag}">
							<li class="page-item"><a class="page-link" href="${contextPath}/guest/gList?pag=${startPageNum + i}">${startPageNum + i }</a></li>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${pag != totPage}">
					<li class="page-item"><a class="page-link" href="${contextPath}/guest/gList?pag=${pag+1}">▷</a></li>
					<li class="page-item"><a class="page-link" href="${contextPath}/guest/gList?pag=${totPage}">▶</a></li>
				</c:if>
				<c:if test="${pag == totPage}">
					<li class="page-item disabled"><a class="page-link" href="${contextPath}/guest/gList?pag=${pag+1}">▷</a></li>
					<li class="page-item disabled"><a class="page-link" href="${contextPath}/guest/gList?pag=${totPage}">▶</a></li>
				</c:if>
			</ul>            
           </div>
       </div>
       <!-- 페이징 처리 끝 -->	
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>