 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-6" style="min-width:600px">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>비밀번호 변경</h4>
				</div><%-- /.panel-heading --%>
                <form role="form" method="post" name="frmModify" id="frmModify"> 
                
                <div class="panel-body">
                	<input type="hidden" name="member_id" id="member_id" value="${member.member_id}"/>
					<div class="form-group">
						<input type="password" class="form-control" id="current_pw" name="current_pw" placeholder="현재 비밀번호" required/>
						<li id="pwCheckResult" style="list-style-type:none;"></li>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" id="new_pw" name="new_pw" placeholder="새 비밀번호" required/>
						<li id="passwordCheck" style="display:none; color: red;"></li>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" id="member_pw" name="member_pw" placeholder="새 비밀번호 확인" required/>
					</div>
					
					<button type="button" class="btn btn-primary btn-sm" id="btnModify" data-oper="modify">수정</button>
					<button type="button" class="btn btn-warning btn-sm" id="btnList" data-oper="list">취소</button>
					
		  			<sec:csrfInput/>
		  
          		</div><%-- /.panel-body --%>
          		</form>  
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>

<%-- Modal --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="yourModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" id="yourModal-body">메시지</div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>

<script>
//form의 수정/삭제/목록보기 버튼 클릭 에벤트 처리
var frmModify = $("#frmModify");
var csrfHeader = "${_csrf.headerName}"
var csrfToken = "${_csrf.token}"
var resultElement = $("#pwCheckResult")

//기존 비밀번호 확인 함수
$("input[name='current_pw']").on('blur', function() {
	var current_pw = $("input[name='current_pw']").val();
	var member_id = $("#member_id").val();
	
	$.ajax({
        url: '${contextPath}/member/checkPw',
        type: 'POST',
        data: {current_pw : current_pw, member_id : member_id},
        beforeSend: function(xhr) {
        	xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function(response){
            if(response == 'duplicate'){
                resultElement.text('비밀번호가 확인되었습니다.');
                resultElement.css('color', 'black');
            } else {
                resultElement.text('기존 비밀번호와 다릅니다.');
                resultElement.css('color', 'red'); 
            }
        }
    })
});

//새 비밀번호 확인 함수
function validatePassword(newPassword, confirmPassword) {

  if (newPassword == confirmPassword) {
    return true;
  } else {
	  alert("비밀번호가 일치하지 않습니다.");
	  return false;
  }
}

//버튼 클릭시 이벤트 처리
$('button').on("click", function(e){
	var newPassword = document.getElementById("new_pw").value;
	var confirmPassword = document.getElementById("member_pw").value;
	var operation = $(this).data("oper");

	if(operation == "modify"){ //비밀번호 변경 요청
		frmModify.attr("action", "${contextPath}/member/modifyPw");
		if (!validatePassword(newPassword, confirmPassword)) {
	    	e.preventDefault(); // 폼 제출을 막음
	  	} else{
	  		frmModify.submit() ; //요청 전송
	  	}
		
	} else if(operation == "list"){ //회원 목록 화면 요청
		frmModify.attr("action","${contextPath}/").attr("method","get");
		frmModify.empty();
		frmModify.submit() ; //요청 전송
	}
	
});

document.getElementById("new_pw").addEventListener("blur", function(){
	var new_pw = this.value;
	var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~`!@#$%\^&*()-]).{8,20}$/;
	
	if(regex.test(new_pw)){
		document.getElementById("passwordCheck").style.display="none";
	} else{
		document.getElementById("passwordCheck").innerText="8~20자의 영문 대소문자, 숫자, 특수문자 조합이어야 합니다.";
		document.getElementById("passwordCheck").style.display="block";
	}
})

</script>
<%@include file="../myinclude/myfooter.jsp" %>  