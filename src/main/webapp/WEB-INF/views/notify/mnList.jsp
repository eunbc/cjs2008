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
	    				alert(data.idx+"번 초기화면에 팝업창이 열립니다. ("+data.sw+")");
    				}
    				else {
    					alert(data.idx+"번 초기화면에 팝업창이 닫힙니다.("+data.sw+")")
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
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>

<p><br/></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td align="center" colspan=2><font size=5><b>공 지 사 항 리 스 트</b></font></td>
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
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>