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
	<title>bContent.jsp</title>
	<style>
		table {margin: 0 auto; width: 600px}
		th {background-color: pink}
		h2 {text-align: center;}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
		function updBoardCheck() {
			var pwd = myform.pwd.value;
			location.href = "${contextPath}/board/bUpdate?idx=${vo.idx}&pwd="+pwd+"&pag=${pag}&pageSize=${pageSize}";
		}
		function delBoardCheck() {
			var ans = confirm("현재 게시글을 삭제하시겠습니까?");
			if(ans) {
				var pwd = myform.pwd.value;
				location.href = "${contextPath}/board/bDelete?idx=${vo.idx}&pwd="+pwd+"&pag=${pag}&pageSize=${pageSize}";
			}
		}
		//게시글의 댓글 입력
		function reCheck() {
			var boardIdx = "${vo.idx}";
			var mid ="${smid}"
			var nickname = "${snickname}";
			var hostip = "<%=request.getRemoteAddr()%>";
			var content = contForm.content.value;
			if(content == "") {
				alert("댓글을 입력하세요!");
				contForm.content.focus();
				return false;
			}
			var query = {
					boardIdx : boardIdx,
					mid		 : mid, 
					nickname : nickname,
					hostip : hostip,
					content : content
			}
			$.ajax({
				url : "${contextPath}/board/bReplyInsert",
				type : "get",
				data : query,
				success : function(data) {
					if(data ==1) {
						//alert("댓글 입력완료"); 
						location.reload();
					}
				}
			});
		}
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
<%@ include file="/WEB-INF/views/include/Slide.jsp"%>
<div class="container">
	<h2>글 내 용 보 기</h2>
	<form name="myform">
		<table class="table">
			<tr>
				<th>글쓴이</th>
				<td>${vo.name}</td>
				<th>글쓴날짜</th>
				<td>${vo.wdate}</td>
			</tr>
			<tr>
				<th>전자우편</th>
				<td>${vo.email}</td>
				<th>접속 ip</th>
				<td>${vo.hostip}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${vo.readnum}</td>
				<th>홈페이지</th>
				<td>${vo.homepage}</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td colspan="3">${vo.title}</td>
			</tr>
			<tr>
				<th>글내용</th>
				<td colspan="3">
					${fn:replace(vo.content,newLine, "<br/>")}
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td colspan="3">
					<input type="password" name="pwd"/>
				</td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center">
					<c:if test="${smid == vo.mid}">
						<input type="button" class="btn btn-secondary" value="수정" onclick="updBoardCheck()"/> &nbsp;
						<input type="button" class="btn btn-secondary" value="삭제" onclick="delBoardCheck()"/> &nbsp;
						<input type="button" class="btn btn-secondary" value="돌아가기" onclick="location.href='${contextPath}/board/bList?pag=${pag}&pageSize=${pageSize}';"/> &nbsp;
					</c:if>
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- 댓글 출력 처리 시작 -->
<div class="container">
	<div>
		<input type="button" value="댓글보이기" id="replyView" class="btn btn-secondary">
		<input type="button" value="댓글가리기" id="replyHidden" class="btn btn-secondary">
	</div>
	<br/>
	<div id="reply">
		<table class="table table-borderless table-hover table-sm">
			<tr>
				<th>작성자</th>			
				<th>댓글내용</th>			
				<th>작성일자</th>			
				<th>접속IP</th>			
				<th>답글</th>			
			</tr>
			<c:forEach var="cVo" items="${cVos}"> 
				<tr>
					<td>${cVo.nickname}</td>
					<td>${fn:replace(cVo.content,newLine,"<br/>")}</td>
					<td>${cVo.wdate}</td>
					<td>${cVo.hostip}</td>
					<td>
						<input type="button" value="답글" id="" onclick=""/>
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<div id="replyBox${cVo.idx}"></div>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<!-- 댓글 출력 처리 끝 -->
<hr/>
<!--  댓글 입력처리 시작 -->
<div class="container">
	<form name="contForm" method="post">
		<table class="table table-sm">
			<tr>
				<td style="border:none;">
					<div class="form-group">
						<label for="content">댓 글 달 기</label> &nbsp;
						<input type="text" name="nickname" value="${snickname}" readonly/>
						<textarea rows="4" name="content" id="content" class="form-control"></textarea>
					</div>
				</td>
				<td>
					<input type="button" value="댓글달기" onclick="reCheck()"/><br/>
					<input type="button" value="돌아가기" onclick="location.href='${contextPath}/board/bList?pag=${pag}&pageSize=${pageSize}';"/>
				</td>
			</tr>
		</table>
		<input type="hidden" name="idx" value="${vo.idx}"/> <!-- 원본글의 고유번호 -->
		<input type="hidden" name="mid" value="${smid}"/> 
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="pageSize" value="${pageSize}"/>
	</form>
</div>
<!--  댓글 입력처리 시작 -->

<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>