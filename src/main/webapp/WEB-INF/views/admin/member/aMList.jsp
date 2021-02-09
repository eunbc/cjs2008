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
	<title>aMList.jsp</title>
    <script>
	  function levelCheck() {
		  alert("회원 정보를 변경하시려면, '정보변경'버튼을 클릭하세요!");
	  }

    </script>
    <style>
	    table, h2 {
	      text-align:center;
	      margin: 0px auto;
	    }
	    th, td {
	      text-align : center;
	      padding : 15px;
	      border: 1px solid #ccc;
	    }
	    th {background-color: gray}
    </style>	
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>전 체 회 원 리 스 트</h2>
  <table>
    <tr>
      <th>번호</th>
      <th>아이디</th>
      <th>별명</th>
      <th>성명</th>
      <th>성별</th>
      <th>생일</th>
      <th>직업</th>
      <th>취미</th>
      <th>정보유무</th>
      <th>등급</th>
      <th>탈퇴유무</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
	    <tr>
	        <td>${curScrNo}</td>
	        <td>
	            <a href="${contextPath}/member/mContent" target="_blank">${vo.mid}</a>
	        </td>
	        <td>${vo.nickname}</td>
	        <td>${vo.name}</td>
	        <td>${vo.gender}</td>
	        <td>${fn:substring(vo.birthday,0,10)}</td>
	        <td>${vo.job}</td>
	        <td>${vo.hobby}</td>
	        <td><font color="red">${vo.userInfor}</font></td>
	        <td>
	            <form name="myform" method="post" action="${contextPath}/admin/member/updateLevel">
		            <select name="level" onchange="levelCheck()">
			            <option value="0" ${vo.level=='0'? 'selected':'' }>관리자</option>
			            <option value="1" ${vo.level=='1'? 'selected':'' }>특별회원</option>
			            <option value="2" ${vo.level=='2'? 'selected':'' }>우수회원</option>
			            <option value="3" ${vo.level=='3'? 'selected':'' }>정회원</option>
			            <option value="4" ${vo.level=='4'? 'selected':'' }>준회원</option>
		            </select>
		            <input type="submit" value="정보변경"/>
		            <input type="hidden" name="idx" value="${vo.idx}"/>
		            <input type="hidden" name="pag" value="${pag}"/>
	            </form>
	        </td>
	        <td>${vo.userDel}</td>
	    </tr>
		<c:set var="curScrNo" value="#{curScrNo-1}"/>	
    </c:forEach>
  </table>
  <br/>
		<!-- 페이징 처리 시작 -->
       <div class="row">
           <div class="col-12">
			<ul class="pagination justify-content-center" style="margin:20px 0">
				<c:set var="startPageNum" value="${pag- (pag-1)%blockSize}"/>
				<c:if test="${pag != 1}">
		  			<li class="page-item"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=1">◀</a></li>
		  			<li class="page-item"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${pag-1}">◁</a></li>
				</c:if>
				<c:if test="${pag == 1}">
		  			<li class="page-item disabled"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=1">◀</a></li>
		  			<li class="page-item disabled"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${pag-1}">◁</a></li>
				</c:if>
				<c:forEach var="i" begin="0" end="2">
					<c:if test="${(startPageNum + i)<=totPage}">
						<c:if test="${(startPageNum + i)==pag}">
				  			<li class="page-item active"><b><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${startPageNum + i}">${startPageNum + i }</a></b></li>
						</c:if>
						<c:if test="${(startPageNum + i)!=pag}">
							<li class="page-item"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${startPageNum + i}">${startPageNum + i }</a></li>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${pag != totPage}">
					<li class="page-item"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${pag+1}">▷</a></li>
					<li class="page-item"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${totPage}">▶</a></li>
				</c:if>
				<c:if test="${pag == totPage}">
					<li class="page-item disabled"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${pag+1}">▷</a></li>
					<li class="page-item disabled"><a class="page-link" href="${contextPath}/admin/member/aMList?pag=${totPage}">▶</a></li>
				</c:if>
			</ul>            
           </div>
       </div>
       <!-- 페이징 처리 끝 -->	
</div>
<p><br/></p></body>
</html>