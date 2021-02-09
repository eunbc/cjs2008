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
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<script type="text/javascript">
		//댓글 보이기, 가리기
		$(document).ready(function() { //처음 로딩시에 '전체 댓글'은 출력시킨다. 댓글 보이기 버튼은 감춘다.
			$("#reply").show();
			$("#replyViewBtn").hide();
			$(".replyBoxClose").hide();

			$("#replyViewBtn").click(function() {
				$("#reply").slideDown(500); //댓글 보이기 버튼 클릭시 댓글 보임 show
				$("#replyViewBtn").hide();
				$("#replyHiddenBtn").show();
			});
			
			$("#replyHiddenBtn").click(function() {
				$("#reply").slideUp(500); //hide
				$("#replyViewBtn").show();
				$("#replyHiddenBtn").hide();
			});
			
		});
		
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
		function replyDel(idx) {
			var ans = confirm("댓글을 삭제할까요?");
			if(!ans) {
				return false;
			} 
			var query = {idx : idx}
			$.ajax({
				url : "${contextPath}/board/bReplyDelete",
				type : "get",
				data : query,
				success : function(data) {
					if(data ==1) {
						location.reload();
					}
				}
			});
		}
		function insertReply(idx, level, levelOrder) {
			var insReply = "";
			insReply += "<table style='width:90%'>";
			insReply += "<tr>";
			insReply += "<td style='border:none;width:85%; text-aling:right; padding:0px;' class='reply_cont'>";
			insReply += "<div class='form-group'>";
			insReply += "<label for='content'>답변 댓글 달기 : </label> &nbsp;";
			insReply += "<input type='text' name='nickname' size='6' value='${snickname}' readonly/>";
			insReply += "<textarea rows='3' class='form-control' id='content"+idx+"' name='content'></textarea>";
			insReply += "</div>";
			insReply += "</td>";
			insReply += "<td style='border:none;width:15%;text-align:left; padding:0px;' class='reply_cont'><br/><br/>";
			insReply += "<input type='button' value='댓글달기' onclick='replyCheck("+idx+","+level+","+levelOrder+")'/>";
			insReply += "</td>";
			insReply += "</tr>";
			insReply += "</table>";
			insReply += "<hr/>";
			
			$("#replyBoxOpenBtn"+idx).hide();
			$("#replyBoxCloseBtn"+idx).show();
			$("#replyBox"+idx).show(); 
			$("#replyBox"+idx).html(insReply); 
		}
		function closeReply(idx) {
			$("#replyBoxOpenBtn"+idx).show();
			$("#replyBoxCloseBtn"+idx).hide();
			$("#replyBox"+idx).hide();
		}

	  	// 대댓글입력처리(부모댓글에 대한 답변글입력)
	  	function replyCheck(idx,level,levelOrder) {
	  		var boardIdx = "${vo.idx}";
	  		var mid = "${smid}";
	  		var nickname = "${snickname}";
	  		var hostip = "<%=request.getRemoteAddr()%>";
	  		var content = "content"+idx;
	  		var contentVal = document.getElementById(content).value;
	  		
	  		if(contentVal == "") {
	  			alert("부모 댓글의 답변내용을 입력하세요.");
	  			$("#"+content).focus();
	  			return false;
	  		}
	  		else {
	  			var query = {
	  					boardIdx : boardIdx,
	  					mid      : mid,
	  					nickname : nickname,
	  					hostip   : hostip,
	  					content  : contentVal,
	  					level    : level,
	  					levelOrder : levelOrder
	  			}
	  			$.ajax({
	  				url   : "${contextPath}/board/bContReplyInsert",
	  				type  : "get",
	  				data  : query,
	  				success : function(data) {
	  					location.reload();
	  				}
	  			});
	  		}
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
		<input type="button" value="댓글보이기" id="replyViewBtn" class="btn btn-secondary">
		<input type="button" value="댓글가리기" id="replyHiddenBtn" class="btn btn-secondary">
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
				<c:if test="${cVo.level > 0}"> <!-- 대댓글(부모댓글의 댓글들)의 경우는 모두 들여쓰기와 배경색 변경 -->
					<tr style="background-color: yellow;text-align:left;"></tr>
				</c:if>
				<c:if test="${cVo.level == 0}"> <!-- 대댓글(부모댓글의 댓글들)의 경우는 모두 들여쓰기와 배경색 변경 -->
					<tr style="background-color: orange;text-align:left;"></tr>
				</c:if>
					<c:if test="${cVo.level > 0}"> <!-- 대댓글(부모댓글의 댓글들)의 경우는 모두 들여쓰기 -->
						<td style="text-align:left;">
							<c:forEach var="i" begin="1" end="${cVo.level}">&nbsp;&nbsp;&nbsp;</c:forEach>
								└ ${cVo.nickname}
					</c:if>
					<c:if test="${cVo.level == 0}"> <!-- 대댓글(부모댓글의 댓글들)의 경우는 모두 들여쓰기 -->
						<td style="text-align:left;">
							${cVo.nickname}
					</c:if>
					<c:if test="${smid== cVo.mid || slevel == 0}">
						<a href="javascript:replyDel(${cVo.idx})"><i class="xi-close"></i></a>
					</c:if>
					</td>
					<td>${fn:replace(cVo.content,newLine,"<br/>")}</td>
					<td>${cVo.wdate}</td>
					<td>${cVo.hostip}</td>
					<td>
						<input type="button" value="답글" id="replyBoxOpenBtn${cVo.idx}" onclick="insertReply('${cVo.idx}','${cVo.level}','${cVo.levelOrder}')"/>
						<input type="button" value="닫기" id="replyBoxCloseBtn${cVo.idx}" class="replyBoxClose" onclick="closeReply(${cVo.idx})"/>
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