 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  



<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">member - modifyPw</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>비밀번호 변경</h4>
				</div><%-- /.panel-heading --%>
                <form role="form" method="post" name="frmModify" id="frmModify"> 
                
                <div class="panel-body">
                	<input type="hidden" name="member_id" value="${member.member_id}"/>
					<div class="form-group">
						<input class="form-control" id="current_pw" name="current_pw" placeholder="현재 비밀번호" required/>
					</div>
					<div class="form-group">
						<input class="form-control" id="new_pw" name="new_pw" placeholder="새 비밀번호" required/>
					</div>
					<div class="form-group">
						<input class="form-control" id="member_pw" name="member_pw" placeholder="새 비밀번호 확인" required/>
					</div>
					
					<button type="button" class="btn btn-default" id="btnModify" data-oper="modify">수정</button>
					<button type="button" class="btn btn-info" id="btnList" data-oper="list">취소</button>
					
		  			<sec:csrfInput/>
		  
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
var currentPassword = $("#current_password").val();
var currentPassword2 = $("#current_password2").val();
var newPassword = $("#new_password").val();
var member_pw = $("#member_pw").val();


if(operation == "modify"){ //비밀번호 변경 요청
frmModify.attr("action", "${contextPath}/member/modifyPw");			
} else if(operation == "list"){ //회원 목록 화면 요청
frmModify.attr("action","${contextPath}/member/list").attr("method","get");
frmModify.empty();
} 
 
frmModify.submit() ; //요청 전송
});

</script>
<%@include file="../myinclude/myfooter.jsp" %>  