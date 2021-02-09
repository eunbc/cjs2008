<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login.jsp</title>
    <style>
    	#content{
    		width:460px;
    		margin: 0 auto;
    	}
		.btn_area {
		    margin: 30px 0 91px;
		}
		
		#btnJoin {
		    width: 100%;
		    padding: 21px 0 17px;
		    border: 0;
		    cursor: pointer;
		    color: #fff;
		    background-color: #1d2434;
		    font-size: 20px;
		    font-weight: 400;
		    font-family: Dotum,'돋움',Helvetica,sans-serif;
		}    
		#btnInput {
		    width: 100%;
		    padding: 21px 0 17px;
		    border: 0;
		    cursor: pointer;
		    color: #fff;
		    background-color: green;
		    font-size: 20px;
		    font-weight: 400;
		    font-family: Dotum,'돋움',Helvetica,sans-serif;
		}    
    </style>
	
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
<div class="container">
	<p><br/></p>    
    <!-- content-->
    <div id="content">
		<form name="myform" method="post" action="${contextPath}/member/login">
            <!-- ID -->
            <div class="form-group">
                   <label for="mid">아이디</label>
                   <input type="text" name="mid" class="form-control" id="mid" placeholder="아이디" maxlength="20" >
            </div>

            <!-- PW -->
            <div class="form-group">
                   <label for="pwd">비밀번호</label>
                   <input type="password" name="pwd" class="form-control" id="pwd" placeholder="비밀번호" maxlength="20" >
            </div>

            <!-- LOGIN BTN-->
            <div class="btn_area">
                <button type="button" id="btnJoin" onclick="fCheck()">
                    <span>로그인</span>
                </button>
            </div>
            <!-- LOGIN BTN-->
            <div class="btn_area">
                <button type="button" id="btnInput" onclick="location.href='${contextPath}/member/mInput'">
                    <span>회원가입</span>
                </button>
            </div>
		</form>
	</div>

</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>