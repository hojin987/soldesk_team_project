<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Product - Register</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>상품 등록</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<form role="form" action="${contextPath}/product/register" method="post" name="frmBoard">
						<div class="form-group">
							<label>상품 코드</label> <input class="form-control" name="product_number">
						</div>
						<div class="form-group">
							<label>상품 내용</label> <input class="form-control" name="product_content">
						</div>
						<div class="form-group">
							<label>상품 유통기한</label> <input class="form-control" name="product_period">
						</div>
						<div class="form-group">
							<label>상품 가격</label> <input class="form-control" name="product_price">
						</div>
						<div class="form-group">
							<label>상품 재고</label> <input class="form-control" name="product_stock">
						</div>
						<sec:csrfInput/>
						
							<button type="submit" class="btn btn-primary">등록</button>
							<button type="button" class="btn btn-warning" data-oper="list"
									onclick="location.href='${contextPath}/product/list'">취소
							</button>
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


<%-- 
<script>

var frmSendValue = $("#frmSendValue") ;
var result = '<c:out value="${result}" />' ;
//alert("result.length: " + result.length)

//등록페이지 이동
$("#btnToRegister").on("click",function(){
	window.location.href = "${contextPath}/myboard/register" ; //권장
//	location.href = "${contextPath}/myboard/register" ;
//	self.location.href = "${contextPath}/myboard/register" ;
//	self.location = "${contextPath}/myboard/register" ;
	
});

//상세페이지 이동
$(".moveDetail").on("click", function(){
	var bno = $(this).data("bno") ;
	
//	window.location.href = "${contextPath}/myboard/detail?bno=" + bno ;
	
	frmSendValue.append("<input type='hidden' name='bno' value='" + bno + "'/>")
	frmSendValue.attr("action", "${contextPath}/myboard/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="bno"]').remove() ;  	//웹 브라우저 뒤로가기 후, 다른 게시물 상세 이동 시에
														//bno값이 계속 url에 추가되는 현상 해결
	
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


페이지징 처리: 검색 목록 페이지 이동
$("li.pagination-button a").on("click", function(e){
	e.preventDefault() ;
	frmSendValue.find("input[name='pageNum']").val($(this).attr("href")) ;
	console.log(frmSendValue.find("input[name='pageNum']").val());
	frmSendValue.attr("action", "${contextPath}/myboard/list") ;
	frmSendValue.attr("method", "get") ;
	
	frmSendValue.submit() ;
	
});

검색 관련 요소의 이벤트 처리
표시행수 변경 이벤트 처리
$("#selectAmount").on("change", function(){
	frmSendValue.find("input[name='pageNum']").val(1) ;
	frmSendValue.submit() ;
} );


키워드 검색버튼 클릭 이벤트 처리
$("#btnSearchGo").on("click", function() {
   
   var scope = $("#selectScope").find("option:selected").val();
   
   if(!scope || scope == '' ){
      alert("검색범위를 선택해주세요.");
      return false;
   }
   
   var keyword = $("#keyword").val() ;
   
   if(!keyword || keyword.length == 0){
      alert("검색어를 입력해주세요.");
      return ;      
   }
   
   frmSendValue.find("input[name='pageNum']").val(1);
   frmSendValue.submit();
});

$("#selectScope").on("change", function(){
	
	var keyword = $("#keyword").val() ;
	   
	if(keyword || keyword.length != 0){
		$("#pageNum").val(1) ;
		frmSendValue.submit() ;      
	}

});


기간 검색버튼 클릭 이벤트 처리
$("#btnIntervalSearch").on("click", function(){
	
	var startDate = $("#startDate").val() ;
	var endDate = $("#endDate").val() ;
	
//	alert("변환전 endDate: " + endDate);
	
	if (!startDate || startDate == "" || !endDate || endDate == "") {
		alert("시작날짜와 끝날짜를 모두 선택하세요") ;
		return ;
	}
/*	
	if (beginDate == endDate) {
		var _endDate = new Date(endDate) ;
		
		_endDate.setDate(_endDate.getDate() + 1) ; //하루 후의 날짜
		
		_endDate = _endDate.toISOString().slice(0, 10) ;

		$("#endDate").val(_endDate);
		
		endDate = $("#endDate").val() ;
		alert("변환후 endDate: " + endDate);
	}
*/	
	frmSendValue.find("input[name='pageNum']").val(1) ;
	frmSendValue.submit() ;
	
});


검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시
$("#btnReset").on("click", function(){
	$("#selectAmount").val(10) ;
	$("#selectScope").val("") ;
	$("#keyword").val("") ;
	$("#startDate").val("") ;
	$("#endDate").val("") ;
	$("#pageNum").val(1) ;
	
	frmSendValue.submit() ;

});




$(document).ready(function(){
	runModal(result) ;
	
	window.addEventListener("popstate", function(event){
		history.pushState(null, null, location.href) ;
		
	});
	
	history.pushState(null, null, location.href) ;
	
});



</script> --%>

<%@include file="../myinclude/myfooter.jsp" %>    