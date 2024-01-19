<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  



<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">member - modify</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>회원정보 상세</h4>
				</div><%-- /.panel-heading --%>
                <form role="form" method="post" name="frmModify" id="frmModify"> 
                
                <div class="panel-body">
					<div class="form-group">
						<label>회원 아이디</label>
							<input class="form-control" name="member_id" value='<c:out value="${member.member_id}"/>'
								   readonly="readonly" />
					</div>
					<div class="form-group">
						<label>회원 비밀번호</label>
							<input class="form-control" name="member_pw" value='<c:out value="${member.member_pw}"/>'/>
					</div>
					<div class="form-group">
						<label>회원 이메일</label>
							<input class="form-control" name="member_email" value='<c:out value="${member.member_email}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 이름</label>
							<input class="form-control" name="member_name" value='<c:out value="${member.member_name}"/>'/>
					</div>
					<div class="form-group">
						<label>회원 생년월일</label>
							<input class="form-control" name="member_birth" value='<c:out value="${member.member_birth}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 핸드폰번호</label>
							<input class="form-control" name="member_phonenumber" value='<c:out value="${member.member_phonenumber}"/>'/>
					</div>
					<div class="form-group">
						<label>회원 키</label>
							<input class="form-control" name="member_height" value='<c:out value="${member.member_height}"/>'/>
					</div>
					<div class="form-group">
						<label>회원 몸무게</label>
							<input class="form-control" name="member_weight" value='<c:out value="${member.member_weight}"/>'/>
					</div>
					<div class="form-group">
						<label>회원 골격근량</label>
							<input class="form-control" name="member_muscle_percent" value='<c:out value="${member.member_muscle_percent}"/>'/>
					</div>
					<div class="form-group">
						<label>회원 체지방률</label>
							<input class="form-control" name="member_fat_percent" value='<c:out value="${member.member_fat_percent}"/>'/>
					</div>
					<div class="form-group">
						<label>회원 목표</label>
							<input class="form-control" name="member_goal" value='<c:out value="${member.member_goal}"/>'/>
					</div>
					<div class="form-group">
						<label>구매 회원권</label>
							<input class="form-control" name="ticket_number" value='<c:out value="${member.ticket_number}"/>'
								   readonly="readonly"/>
					</div>
					<sec:csrfInput/>
					<button type="button" class="btn btn-default" id="btnModify" data-oper="modify">수정</button>
 					<button type="button" class="btn btn-info" id="btnList" data-oper="list">취소</button>
		  
		  
          </div><%-- /.panel-body --%>
          </form>  
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>

</div><%-- /#page-wrapper --%>

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
$('button').on("click", function(e){ 

var operation = $(this).data("oper");
 
if(operation == "modify"){ //회원권 정보 수정 요청
frmModify.attr("action", "${contextPath}/member/modify");
} else if(operation == "list"){ //회원권 목록 화면 요청
frmModify.attr("action","${contextPath}/member/list").attr("method","get");
frmModify.empty();
}
 
frmModify.submit() ; //요청 전송
});

</script>
<%@include file="../myinclude/myfooter.jsp" %>  