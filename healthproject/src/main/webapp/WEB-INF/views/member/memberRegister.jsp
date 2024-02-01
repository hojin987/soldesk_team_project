<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../myinclude/myheader.jsp"%>

	<div class="row" style="display: flex; justify-content: center;">
		<div class="col-lg-6" style="min-width: 600px;">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>회원가입</h4>
				</div>
				<%-- /.panel-heading --%>

				<div class="panel-body">
					<form role="form" action="${contextPath}/member/memberRegister"
						method="post" name="frmBoard">
						<!-- 아이디 체크: 영문 대소문자로 시작하는 영문, 숫자 조합의 6~20자 -->
						<div class="form-group">
							<label>아이디</label> <input class="form-control" id="member_id" name="member_id"
								pattern="^[a-zA-Z][a-zA-Z0-9]{5,19}$"
								placeholder="영문 대소문자로 시작하는 영문, 숫자 조합의 6~20자">
							<li id="idCheckResult" style="list-style-type:none; color: red;"></li>
						</div>

						<!-- 비밀번호 체크: 8 ~ 20자 영문 대소문자, 숫자, 특수문자 조합(영문, 숫자 최소 한가지씩 조합) -->
						<div class="form-group">
							<label>비밀번호</label> <input type="password" class="form-control" id="member_pw" name="member_pw"
								pattern="^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~`!@#$%\^&*()-]).{8,20}$"
								placeholder="8~20자의 영문 대소문자, 숫자, 특수문자 조합">
							<li id="passwordCheck" style="display:none; color: red;"></li>
						</div>

						<!--  이메일 체크 -->
						<div class="form-group">
							<label for="member_email">이메일</label> <input class="form-control" type="email" 
								pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$"
								id="member_email" name="member_email"
								placeholder="ex: example@example.com">
							<li id="emailCheck" style="display:none; color: red;"></li>
						</div>
						
						<!-- 이름 한글만 -->
						<div class="form-group">
							<label>이름</label> <input class="form-control" name="member_name" id="member_name" 
								patter="^[가-힣]*$" placeholder="한글만 입력해주세요.">
							<li id="nameCheck" style="display:none; color: red;"></li>
						</div>

						<!-- 핸드폰 번호 체크 -->
						<div class="form-group">
							<label>연락처</label><input class="form-control" id="member_phonenumber" name="member_phonenumber"
								pattern="^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$"
								placeholder="ex: 000-0000-0000">
							<li id="phoneNumCheck" style="display:none; color: red;"></li>
						</div>

						<!-- 생일은 YYYY-MM-DD 형식 -->
						<div class="form-group">
							<label>생년월일</label> <input class="form-control" id="member_birth" name="member_birth"
								pattern="^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$"
								placeholder="YYYY-MM-DD 형식으로 입력해주세요.">
							<li id="birthCheck" style="display:none; color: red;"></li>
						</div>

						<!-- 키, 몸무게, 골격근량, 체지방률은 숫자만 -->
						<div class="form-group">
							<label>키</label> <input class="form-control" name="member_height" id="member_height" 
								patter="^[0-9]*$" placeholder="숫자만 입력해주세요.">
							<li id="heightCheck" style="display:none; color: red;"></li>
						</div>
						<div class="form-group">
							<label>몸무게</label> <input class="form-control" id="member_weight" name="member_weight"
								patter="^[0-9]*$" placeholder="숫자만 입력해주세요.">
							<li id="weightCheck" style="display:none; color: red;"></li>
						</div>
						<div class="form-group">
							<label>골격근량</label> <input class="form-control" id="member_muscle_percent" name="member_muscle_percent"
								patter="^[0-9]*$" placeholder="숫자만 입력해주세요.">
							<li id="muscleCheck" style="display:none; color: red;"></li>
						</div>
							<div class="form-group">
							<label>체지방률</label> <input class="form-control" id="member_fat_percent" name="member_fat_percent" 
								patter="^[0-9]*$" placeholder="숫자만 입력해주세요.">
							<li id="fatCheck" style="display:none; color: red;"></li>
						</div>
						
						<div class="form-group" style="display:none">
							<input name="ticket_number" value="none">
						</div>

						<div class="form-group">
							<label>목표</label> <select class="form-control" name="member_goal">
								<option value="체력개선" selected>체력개선</option>
								<option value="가슴">가슴</option>
								<option value="등">등</option>
								<option value="어깨">어깨</option>
								<option value="하체">하체</option>
							</select>
						</div>
						<div>
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }" />
						</div>
						<button type="submit" class="btn btn-primary btn-sm">등록</button>
						<button type="button" class="btn btn-warning btn-sm" data-oper="list"
							onclick="location.href='${contextPath}/noticeBoard/list'">취소
						</button>
					</form>

				</div>
				<%-- /.panel-body --%>

			</div>
			<%-- /.panel --%>
		</div>
		<%-- /.col-lg-12 --%>
	</div>
	<%-- /.row --%>

<script>

var csrfHeader = "${_csrf.headerName}"
var csrfToken = "${_csrf.token}"
var resultElement = $("#idCheckResult")

//아이디 중복체크	
$(document).ready(function(){
	function checkDupplicateMemberId(){
	    var member_id = $("input[name='member_id']").val();
	    
	    $.ajax({
	        url: '${contextPath}/member/check', 
	        type: 'POST',
	        data: {member_id : member_id},
	        beforeSend: function(xhr) {
	        	xhr.setRequestHeader(csrfHeader, csrfToken);
	        },
	        success: function(response){
	            if(response == 'duplicate'){
	                resultElement.text('이미 사용 중인 아이디입니다.');
	            } else {
	                resultElement.text('사용가능합니다.');
	                resultElement.css('color', 'black'); 
	            }
	        }
	    });
	}
	
    $("input[name='member_id']").on('blur', function() {
    	var regex = /^[a-zA-Z][a-zA-Z0-9]{5,19}$/;
    	
        if(regex.test(this.value)){
        	checkDupplicateMemberId();
        } else{
        	resultElement.text('영문 대소문자로 시작하는 영문, 숫자 조합의 6~20자로 입력해주세요.')
        }
    });
    
    document.getElementById("member_pw").addEventListener("blur", function(){
    	var member_pw = this.value;
    	var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~`!@#$%\^&*()-]).{8,20}$/;
    	
    	if(regex.test(member_pw)){
    		document.getElementById("passwordCheck").style.display="none";
    	} else{
    		document.getElementById("passwordCheck").innerText="8~20자의 영문 대소문자, 숫자, 특수문자 조합이어야 합니다.";
    		document.getElementById("passwordCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_email").addEventListener("blur", function(){
    	var member_email = this.value;
    	var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    	
    	if(regex.test(member_email)){
    		document.getElementById("emailCheck").style.display="none";
    	} else{
    		document.getElementById("emailCheck").innerText="올바른 형식이 아닙니다. ex: example@example.com";
    		document.getElementById("emailCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_name").addEventListener("blur", function(){
    	var member_name = this.value;
    	var regex = /^[가-힣]*$/;
    	
    	if(regex.test(member_name)){
    		document.getElementById("nameCheck").style.display="none";
    	} else{
    		document.getElementById("nameCheck").innerText="한글만 작성해주세요.";
    		document.getElementById("nameCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_phonenumber").addEventListener("blur", function(){
    	var member_phonenumber = this.value;
    	var regex = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
    	
    	if(regex.test(member_phonenumber)){
    		document.getElementById("phoneNumCheck").style.display="none";
    	} else{
    		document.getElementById("phoneNumCheck").innerText="올바른 형식이 아닙니다. ex: 010-0000-0000";
    		document.getElementById("phoneNumCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_birth").addEventListener("blur", function(){
    	var member_birth = this.value;
    	var regex = /^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
    	
    	if(regex.test(member_birth)){
    		document.getElementById("birthCheck").style.display="none";
    	} else{
    		document.getElementById("birthCheck").innerText="YYYY-MM-DD 형식으로 입력해주세요.";
    		document.getElementById("birthCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_height").addEventListener("blur", function(){
    	var member_height = this.value;
    	var regex = /^[0-9]*$/;
    	
    	if(regex.test(member_height)){
    		document.getElementById("heightCheck").style.display="none";
    	} else{
    		document.getElementById("heightCheck").innerText="숫자만 입력해주세요";
    		document.getElementById("heightCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_weight").addEventListener("blur", function(){
    	var member_weight = this.value;
    	var regex = /^[0-9]*$/;
    	
    	if(regex.test(member_weight)){
    		document.getElementById("weightCheck").style.display="none";
    	} else{
    		document.getElementById("weightCheck").innerText="숫자만 입력해주세요";
    		document.getElementById("weightCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_muscle_percent").addEventListener("blur", function(){
    	var member_muscle_percent = this.value;
    	var regex = /^[0-9]*$/;
    	
    	if(regex.test(member_muscle_percent)){
    		document.getElementById("muscleCheck").style.display="none";
    	} else{
    		document.getElementById("muscleCheck").innerText="숫자만 입력해주세요";
    		document.getElementById("muscleCheck").style.display="block";
    	}
    })
    
    document.getElementById("member_fat_percent").addEventListener("blur", function(){
    	var member_fat_percent = this.value;
    	var regex = /^[0-9]*$/;
    	
    	if(regex.test(member_fat_percent)){
    		document.getElementById("fatCheck").style.display="none";
    	} else{
    		document.getElementById("fatCheck").innerText="숫자만 입력해주세요";
    		document.getElementById("fatCheck").style.display="block";
    	}
    })
    
    
});

</script>

<%@include file="../myinclude/myfooter.jsp"%>
