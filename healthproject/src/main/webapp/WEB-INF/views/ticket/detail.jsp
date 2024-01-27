<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  
    
    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>회원권 상세</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<div class="form-group">
						<label>정기권 내용</label>
							<input class="form-control" name="ticket_content" value='<c:out value="${ticket.ticket_content}"/>'
								   readonly="readonly" />
					</div>
					<div class="form-group">
						<label>정기권 가격</label>
							<input class="form-control" name="ticket_price" value='<c:out value="${ticket.ticket_price}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>pt횟수</label>
							<input class="form-control" name="pt_count" value='<c:out value="${ticket.pt_count}"/>'
								   readonly="readonly"/>
					</div>
						
					<button type="button" class="btn btn-primary btn-sm" id="BtnMoveModify">수정하기</button>
					<button type="button" class="btn btn-primary btn-sm" id="BtnMoveBuy">구매하기</button>
					<button type="button" class="btn btn-warning btn-sm" id="BtnMoveList">목록</button>

          </div><%-- /.panel-body --%>
            
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
//상품정보 수정-삭제 페이지로 이동
$("#BtnMoveModify").on("click", function(){
	location.href='${contextPath}/ticket/modify?ticket_number=<c:out value="${ticket.ticket_number}"/>';
})

//구매페이지 이동
$("#BtnMoveBuy").on("click", function(){
	location.href='${contextPath}/ticket/buy?ticket_number=<c:out value="${ticket.ticket_number}"/>';
});

//상품 목록 페이지로 이동
$("#BtnMoveList").on("click", function(){
	location.href="${contextPath}/ticket/list";
})


</script>

<%@include file="../myinclude/myfooter.jsp" %>    