<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>

<%
   Date now = new Date();
   pageContext.setAttribute("now", now);
%>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  
    
    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-6" style="min-width:600px">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>내 프로필</h4>
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
					    <label>나의 BMI</label>
					    <c:set var="height_in_meters" value="${member.member_height / 100.0}" />
					    <c:set var="bmi" value="${member.member_weight / (height_in_meters * height_in_meters)}" />
					    <input class="form-control" name="member_bmi" 
					           value='<c:out value="${String.format('%.2f', bmi)}"/>' readonly="readonly"/>
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
						<c:set var="today" value="${now}" />
						<c:choose>
							<c:when test="${member.ticket_number eq 'none'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="구매하신 이용권이 없습니다"/>' readonly="readonly"/></c:when>
							<c:when test="${member.ticket_end_date lt today}"><input class="form-control" 
									value='이용권이 만료되었습니다.' readonly="readonly"/></c:when>
							<c:when test="${member.ticket_number eq 'Ticket1'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="이용권 3개월"/>' readonly="readonly"/></c:when>
							<c:when test="${member.ticket_number eq 'Ticket2'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="이용권 6개월"/>' readonly="readonly"/></c:when>		
							<c:when test="${member.ticket_number eq 'Ticket3'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="이용권 12개월"/>' readonly="readonly"/></c:when>
							<c:when test="${member.ticket_number eq 'Ticket4'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="pt 10회권"/>' readonly="readonly"/></c:when>
							<c:when test="${member.ticket_number eq 'Ticket5'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="pt 20회권"/>' readonly="readonly"/></c:when>
							<c:when test="${member.ticket_number eq 'Ticket6'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="pt 30회권"/>' readonly="readonly"/></c:when>
							<c:when test="${member.ticket_number eq 'Ticket7'}"><input class="form-control" name="ticket_number" 
									value='<c:out value="이용권 3개월 + pt 10회권"/>' readonly="readonly"/></c:when>
						</c:choose>
						<li><c:out value="회원권 종료일: ${member.ticket_end_date}"/></li>
					</div>
					<sec:authorize access="isAuthenticated()" >
 					<sec:authentication property="principal" var="principal"/> 
						<c:if test="${principal.username eq member.member_id }">
							<button type="button" class="btn btn-primary btn-sm" id="BtnMoveModify">내 정보 수정하기</button>
							<button type="button" class="btn btn-primary btn-sm" id="BtnMoveModifyPassword">비밀번호 변경하기</button>
						</c:if>
					</sec:authorize>
					
					<sec:authorize access="hasAuthority('ADMIN')">
					<c:choose>
						<c:when test="${principal.username eq member.member_id}">
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-primary btn-sm" id="BtnMoveModify">회원 정보 수정하기</button>
						</c:otherwise>
					</c:choose>
					</sec:authorize>
					<button type="button" class="btn btn-warning btn-sm" id="BtnMoveHome">메인페이지</button>
					
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