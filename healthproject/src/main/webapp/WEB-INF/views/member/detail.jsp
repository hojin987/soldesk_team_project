<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  



<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">member - detail</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>회원정보 상세</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<div class="form-group">
						<label>회원 아이디</label>
							<input class="form-control" name="member_id" value='<c:out value="${member.member_id}"/>'
								   readonly="readonly" />
					</div>
					<div class="form-group">
						<label>회원 이메일</label>
							<input class="form-control" name="member_email" value='<c:out value="${member.member_email}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 이름</label>
							<input class="form-control" name="member_name" value='<c:out value="${member.member_name}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 생년월일</label>
							<input class="form-control" name="member_birth" value='<c:out value="${member.member_birth}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 핸드폰번호</label>
							<input class="form-control" name="member_phonenumber" value='<c:out value="${member.member_phonenumber}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 등록일</label>
							<input class="form-control" name="member_register_date" value='<c:out value="${member.member_register_date}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 키</label>
							<input class="form-control" name="member_height" value='<c:out value="${member.member_height}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 몸무게</label>
							<input class="form-control" name="member_weight" value='<c:out value="${member.member_weight}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 골격근량</label>
							<input class="form-control" name="member_muscle_percent" value='<c:out value="${member.member_muscle_percent}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 체지방률</label>
							<input class="form-control" name="member_fat_percent" value='<c:out value="${member.member_fat_percent}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>회원 목표</label>
							<input class="form-control" name="member_goal" value='<c:out value="${member.member_goal}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>구매 회원권</label>
							<input class="form-control" name="ticket_number" value='<c:out value="${member.ticket_number}"/>'
								   readonly="readonly"/>
					</div>
					<sec:authorize access="isAuthenticated()" >
 					<sec:authentication property="principal" var="principal"/> 
						<c:if test="${principal.username eq member.member_id }">
							<button type="button" class="btn btn-default" id="BtnMoveModify">내 정보 수정하기</button>
							<button type="button" class="btn btn-default" id="BtnMoveModifyPassword">비밀번호 변경하기</button>
						</c:if>
					</sec:authorize>
					
					<sec:authorize access="hasAuthority('ADMIN')">
					<c:choose>
						<c:when test="${principal.username eq member.member_id}">
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-default" id="BtnMoveModify">회원 정보 수정하기</button>
						</c:otherwise>
					</c:choose>
					</sec:authorize>
					<button type="button" class="btn btn-info" id="BtnMoveHome">메인페이지</button>
					
					<form role="form" id="frmSendValue">
						<input type="hidden" name="pageNum" value="${boardPaging.pageNum }" >
						<input type="hidden" name="rowAmountPerPage" value="${boardPaging.rowAmountPerPage }" >
						<input type="hidden" name="scope" value="${boardPaging.scope }" >
						<input type="hidden" name="keyword" value="${boardPaging.keyword }" >
						<input type="hidden" name="startDate" value="${boardPaging.beginDate }" >
						<input type="hidden" name="endDate" value="${boardPaging.endDate }" >
					</form>

          </div><%-- /.panel-body --%>
            
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
//회원정보 수정-삭제 페이지로 이동
$("#BtnMoveModify").on("click", function(){
	location.href='${contextPath}/member/modify?member_id=<c:out value="${member.member_id}"/>';
})

//비밀번호 변경 페이지로 이동
$("#BtnMoveModifyPassword").on("click", function(){
	location.href='${contextPath}/member/modifyPw?member_id=<c:out value="${member.member_id}"/>';
})

//상품 목록 페이지로 이동
$("#BtnMoveHome").on("click", function(){
	location.href="${contextPath}/";
})
</script>


</script>
<%@include file="../myinclude/myfooter.jsp" %>  