<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Ticket - buy</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>회원권 수정-삭제</h4>
				</div><%-- /.panel-heading --%>
				<form role="form" method="post" name="frmModify" id="frmModify">                
                <div class="panel-body">
                	<input type="hidden" name="member_id" value="${principal.username}">
					<div class="form-group">
						<label>회원권 번호</label>
							<input class="form-control" name="ticket_number" value='<c:out value="${ticket.ticket_number}"/>' readonly/>
					</div>
					<div class="form-group">
						<label>회원권 내용</label>
							<input class="form-control" name="ticket_content" value='<c:out value="${ticket.ticket_content}"/>' readonly>
					</div>
					<div class="form-group">
						<label>회원권 시작 날짜</label>
							<input class="form-control" name="ticket_start_date" value='<c:out value="${ticket.ticket_start_date}"/>' readonly/>
					</div>
					<div class="form-group">
						<label>회원권 종료 날짜</label>
							<input class="form-control" name="ticket_end_date" value='<c:out value="${ticket.ticket_end_date}"/>' readonly/>
					</div>
					<div class="form-group">
						<label>PT 횟수</label>
							<input class="form-control" name="pt_count" value='<c:out value="${ticket.pt_count}"/>' readonly/>
					</div>
					<div class="form-group">
						<label>회원권 가격</label>
							<input class="form-control" name="ticket_price" value='<c:out value="${ticket.ticket_price}"/>' readonly/>
					</div>
					<sec:csrfInput/>
					<button type="button" class="btn btn-default" id="btnModify" data-oper="buy">구매하기</button>
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
 
if(operation == "buy"){ //회원권 구매
frmModify.attr("action", "${contextPath}/ticket/buy");
} else if(operation == "list"){ //회원권 목록 화면 요청
frmModify.attr("action","${contextPath}/ticket/list").attr("method","get");
frmModify.empty();
}
 
frmModify.submit() ; //요청 전송
});

</script>

<%@include file="../myinclude/myfooter.jsp" %>    