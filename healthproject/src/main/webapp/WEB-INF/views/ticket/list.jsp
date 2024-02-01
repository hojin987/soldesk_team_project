<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<style>
 th {text-align: center;}
</style>  

    <div class="row" style="display: flex; justify-content: center; ">
        <div class="col-lg-6" style="min-width:600px;">
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">정기권 목록</div>
						<div class="col-md-6" style="padding-top:8px;">
							<sec:authorize access="hasAnyAuthority('TRAINER', 'ADMIN')">
								<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">정기권 등록</button>
							</sec:authorize>
						</div>
					</div>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
<form id="frmSendValue">
</form>                
	<table class="table table-striped table-bordered table-hover" 
	       style="width:100%;text-align: center;">
	    <thead>
	        <tr>
	            <th>상품내용</th>
	            <th>가격</th>
	        </tr>
	    </thead>
	    <tbody>
			<c:forEach items="${ticketList}" var="ticket">
				<c:if test="${ticket.ticket_number ne 'none'}">
					<tr class="moveDetail" data-ticket_number="${ticket.ticket_number}">
						<td style="text-align:left;" ><c:out value="${ticket.ticket_content}"/></td>
						<td><c:out value="${ticket.ticket_price}"/></td>
					</tr>
				</c:if>
			</c:forEach>              

                    </tbody>
                </table><%-- /.table-responsive --%>

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

var frmSendValue = $("#frmSendValue") ;
var result = '<c:out value="${result}" />' ;
//alert("result.length: " + result.length)

//등록페이지 이동
$("#btnToRegister").on("click",function(){
	window.location.href = "${contextPath}/ticket/register" ;
});

//상세페이지 이동
$(".moveDetail").on("click", function(){
	var ticket_number = $(this).data("ticket_number") ;
	
	frmSendValue.append("<input type='hidden' name='ticket_number' value='" + ticket_number + "'/>")
	frmSendValue.attr("action", "${contextPath}/ticket/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="ticket_number"]').remove() ;  	
	
});



//모달 호출 함수
function runModal(result) {
	
	if (result.length == 0) {
		return ;
	
	} else if ( result == "successRemove" ) {
		var myMsg =  "게시글이 삭제되었습니다. " ;
		
	} else if ( parseInt(result) > 0 ) {
		var myMsg =  result + "번 게시글이 등록되었습니다. "
	
	} 

	
	//$(".modal-body").html(myMsg) ;
	$("#yourModal-body").html(myMsg) ;
	
	$("#yourModal").modal("show") ;
	
	myMsg = "" ;
}


$(document).ready(function(){
	runModal(result) ;
	
	window.addEventListener("popstate", function(event){
		history.pushState(null, null, location.href) ;
		
	});
	
	history.pushState(null, null, location.href) ;
	
});



</script> 

<%@include file="../myinclude/myfooter.jsp" %>    