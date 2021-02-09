<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>nList.jsp</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <%@ include file="/WEB-INF/views/include/bs.jsp" %>
  <script>
    $(document).ready(function() {
    	$(".popupSw").click(function() {
    		var popupCheck = $(this).is(":checked");
    		//if(popupCheck) popupSw = "Y";
    		//else popup = "N";
    		var popupSw = popupCheck ? "Y" : "N";
    		var idx = $(this).next().val();
    		
    		var query = {
    				idx : idx,
    				popupSw : popupSw
    		};
    		
    		$.ajax({
    			url : "${contextPath}/notify/popupCheck",
    			type : "get",
    			data : query,
    			success : function(data) {
    				if(popupSw == "Y") {
	    				alert(idx+"번 초기화면에 팝업창이 열립니다.");
    				}
    				else {
    					alert(idx+"번 초기화면에 팝업창이 닫힙니다.")
    				}
    				//location.reload();
  					$("").load("${contextPath}/notify/nList");
    			},
    			error : function(data) {
    				alert("수행 실패");
    			} 
    		}); //ajax 종료
    	});
    });
  	function nDelCheck(idx) {
  		var ans = confirm("삭제하시겠습니까?");
  		if(ans) {
  			var query = {"idx" : idx};
  			$.ajax({
  				url : "${contextPath}/notify/nDelete",
  				type : "get",
  				data : query,
  				success : function(data) {
  					//location.reload();
  					$("#notifyContent").load("${contextPath}/notify/nList #notifyContent");
  				}
  			});
  		}
  	}
  </script>

</head>
<body>
<p><br/></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td align="center" colspan=2><font size=5><b>공 지 사 항 리 스 트</b></font></td>
    </tr>
    <tr>
      <td style="width:90%;border:0px;" class="tblr">
        <button type="button" class="btn btn-secondary" onClick="location.href='${contextPath}/notify/nInput'">공지사항작성</button>
      </td>
    </tr>
  </table>
  <form name="myform" method="get">
    <div id="notifyContent">
    <ul>
      <c:set var="num" value="${curScrNo}"/>
      <c:forEach var="vo" items="${vos}">
        <li><hr>
          <span>
            <div class="container mt-3">
              <div class="d-flex justify-content-between mb-3">
                <div class="p-2">
                  <h5><b>[공지${num}.] ${vo.title}</b></h5>&nbsp; &nbsp;
                </div>
                <div class="p-2">
                  &nbsp; &nbsp;
                  <button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/notify/nUpdate?idx=${vo.idx}';">수정</button>
                  <button type="button" class="btn btn-secondary" onclick="nDelCheck(${vo.idx})">삭제</button>
                  &nbsp; / 초기화면 표시 유무 :
                  <input type="checkbox" name="popupSw" id="popupSw${num}" class="popupSw" <c:if test="${vo.popupSw eq 'Y'}"> checked </c:if> />
                  <input type="hidden" name="idx" id="idx" value="${vo.idx}" />
                </div>
              </div>
            </div>
          </span>
          <ul style="background-color:#fff5ee">
            <c:set var="content" value="${fn:replace(vo.content,newLine,'<br/>')}"/>
            <li>${content}</li><br/>
            <li>게시일 : ${vo.startDate} ~ ${vo.endDate}</li>
          </ul>
        </li>
        <c:set var="num" value="${num-1}"/>
      </c:forEach>
    </ul>
    </div>
  </form>
</div>
</body>
</html>