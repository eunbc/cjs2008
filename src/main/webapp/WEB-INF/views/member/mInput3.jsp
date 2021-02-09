<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mInput.jsp</title>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
	<script src="${contextPath}/resources/js/mInput.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/Slide.jsp" %>
<p><br/></p>
<article class="container">
    <div class="page-header">
    	<div class="col-md-6 col-md-offset-3">
        	<h3>회원가입</h3>
        </div>
    </div>
        <div class="col-sm-6 col-md-offset-3">
        	<form action="${contextPath}/member/mInput" method="post" role="form" id="usercheck" name="member">
                
            	<div class="form-group">
                	<label for="mid">아이디 <input type="button" onclick="idCheck()" class="btn btn-secondary" value="아이디 중복 체크"/></label>
                    <input type="text" class="form-control" id="mid" name="mid" placeholder="아이디">
                    <div class="eheck_font" id="id_check"></div>
                </div>
                    
                <div class="form-group">
                    <label for="pwd">비밀번호</label>
                    <input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호">
                    <div class="eheck_font" id="pw_check"></div>
                </div>
                <div class="form-group">
                    <label for="pwdRe">비밀번호 확인</label>
                    <input type="password" class="form-control" id="pwdRe" name="pwdRe" placeholder="비밀번호 확인">
                    <div class="eheck_font" id="pw2_check"></div>
                </div>
                
                <div class="form-group">
                    <label for="name">이름</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="이름">
                    <div class="eheck_font" id="name_check"></div>
                </div>

                <div class="form-group">
                    <label for="nickname">닉네임 <input type="button" onclick="nickCheck()" class="btn btn-secondary" value="닉네임 중복 체크"/></label>
                    <input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임">
                    <div class="eheck_font" id="nickname_check"></div>
                </div>

                <div class="form-group">
                    <label for="mem_gender">성별 </label>
                    <input type="checkbox" id="genderMen" name="gender" value="남">남
                    <input type="checkbox" id="genderWomen" name="gender" value="여">여
                </div>
                    
                <div class="form-group">
                    <label for="birthday">생년월일</label>
                    <input type="text" class="form-control" id="birthday" name="birthday" placeholder="ex) 19990101">
                    <div class="eheck_font" id="birth_check"></div>
                </div>
               
                <div class="form-group">
                    <label for="email">이메일 주소</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="이메일">
                    <div class="eheck_font" id="email_check"></div>
                </div>
               
                <div class="form-group">
                    <label for="homepage">홈페이지</label>
                    <input type="text" class="form-control" id="homepage" value="http://" name="homepage" placeholder="홈페이지">
                </div>

			    <div class="form-group">
			        <label for="address">주소 :</label>
					<input type="text" id="sample4_postcode" placeholder="우편번호">
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" id="sample4_extraAddress" placeholder="참고항목">
					<input type="text" id="sample4_detailAddress" placeholder="상세주소">
			    </div>			
   	               
        
                <div class="form-group">
                    <label for="tel">휴대폰 번호</label>
                    <input type="tel" class="form-control" id="tel" name="tel" placeholder="휴대폰 번호('-'없이 번호만 입력해주세요)">
                    <div class="eheck_font" id="phone_check"></div>
                </div>
                
	   		    <div class="form-group">
			        <label for="name">직업 :</label>
			        <select class="form-control" id="job" name="job">
				        <option>학생</option>
				        <option>회사원</option>
				        <option>공무원</option>
				        <option>군인</option>
				        <option>의사</option>
				        <option>법조인</option>
				        <option>세무인</option>
				        <option>자영업</option>
				        <option>기타</option>
			        </select>
			    </div>
			    
			    <div class="form-group">
			        <div class="form-check-inline">
						<label class="form-check-label">취미 :
						    <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
						    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
						</label>
					</div>
		    	</div>
		    	
		    	<!-- 사진 파일 라이브러리 넣기 -->
			    <div class="form-group">
				    <label for="photo">프로필 사진 </label>
					<input type="file" name="mFile" id="mFile" class="form-control-file border" accept=".gif, .jpg, .png"/>
				</div>
				
			    <div class="form-group">
				    <label for="photo">자기소개 </label>
					<textarea rows="5" cols="40" placeholder="자기소개를 입력하세요"></textarea>
				</div>
				
		    	<div class="form-group">
		      		<div class="form-check-inline">정보공개  &nbsp; &nbsp; 
					    <label class="form-check-label">
					   		 <input type="radio" class="form-check-input" name="userinfor" value="공개" checked/>공개
					  	</label>
					</div>
					<div class="form-check-inline">
					    <label class="form-check-label">
					   		<input type="radio" class="form-check-input" name="userinfor" value="비공개"/>비공개
					    </label>
					</div>
		    	</div>

				<div class="form-group text-center">
			        <button type="submit" class="btn btn-primary">회원가입</button> 
			    </div>
            </form>
        </div>
</article>

<p><br/></p>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>