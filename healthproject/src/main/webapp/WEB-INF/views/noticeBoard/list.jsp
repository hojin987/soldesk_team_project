<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<style>
 th {text-align: center;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Board - List</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">게시글 목록</div>
						<div class="col-md-6" style="padding-top:8px;">
							<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">새글 등록</button>
						</div>
					</div>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
                
<%--                 
<form class="form-inline" id="frmSendValue" name="frmSendValue" action="${contextPath }/myboard/list" method="get" >
	<div class="form-group">
		<label class="sr-only">frmSendValues</label>
		<select class="form-control" id="selectAmount" name="rowAmountPerPage">
			<option value="10" ${(pagingCreator.myboardPaging.rowAmountPerPage == 10) ? "selected" : "" }>10개</option>
			<option value="20" ${(pagingCreator.myboardPaging.rowAmountPerPage == 20) ? "selected" : "" }>20개</option>
			<option value="50" ${(pagingCreator.myboardPaging.rowAmountPerPage == 50) ? "selected" : "" }>50개</option>
			<option value="100" ${(pagingCreator.myboardPaging.rowAmountPerPage == 100) ? "selected" : "" }>100개</option>
		</select>
		
		<select class="form-control" id="selectScope" name="scope">
			<option value="" ${(pagingCreator.myboardPaging.scope == null ) ? "selected" : "" }>범위선택</option>
			<option value="T" ${(pagingCreator.myboardPaging.scope == "T" ) ? "selected" : "" }>제목</option>
			<option value="C" ${(pagingCreator.myboardPaging.scope == "C" ) ? "selected" : "" }>내용</option>
			<option value="W" ${(pagingCreator.myboardPaging.scope == "W" ) ? "selected" : "" }>작성자</option>
			<option value="TC" ${(pagingCreator.myboardPaging.scope == "TC" ) ? "selected" : "" }>제목+내용</option>
			<option value="TCW" ${(pagingCreator.myboardPaging.scope == "TCW" ) ? "selected" : "" }>제목+내용+작성자</option>
		</select> --%>
		
		
		<div class="input-group"><!-- 검색어 입력 -->
			<input class="form-control" id="keyword" name="keyword" type="text" 
			       placeholder="검색어를 입력하세요"
				   value='<c:out value="${pagingCreator.myboardPaging.keyword}" />' />
			<span class="input-group-btn"><!-- 전송버튼 -->
				<button class="btn btn-warning" type="button" id="btnSearchGo"
						><i class="fa fa-search"></i>
				</button>
			</span>
		</div>
		
		<!-- <div class="input-group">검색 초기화 버튼
			<button id="btnReset" class="btn btn-info" type="button">
				<span class="glyphicon glyphicon-remove"></span>
			</button>
		</div> -->
	</div>

	<%-- <div class="form-group pull-right">
		<input class="form-control" id="startDate" name="startDate" type="date"
			   value="${pagingCreator.myboardPaging.startDate}" 
			   />
		<input class="form-control" id="endDate" name="endDate" type="date"
			   value="${pagingCreator.myboardPaging.endDate}" 
			   />

		<button type="button" class="btn btn-primary mybtns" 
				id="btnIntervalSearch" >기간검색</button>
	</div>  --%>
	
	<%-- <input type="hidden" id="pageNum" name="pageNum" value="${pagingCreator.myboardPaging.pageNum }" >
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${pagingCreator.myboardPaging.rowAmountPerPage }" >
	<input type="hidden" id="lastPageNum" name="lastPageNum" value="${pagingCreator.lastPageNum }" > --%>
	
</form>                
	<table class="table table-striped table-bordered table-hover" 
	       style="width:100%;text-align: center;">
	    <thead>
	        <tr>
	            <th>글번호</th>
	            <th>제목</th>
	            <th>작성자</th>
	            <th>작성일</th>
	            <th>조회수</th>
	        </tr>
	    </thead>
	    <tbody>
			<c:forEach items="${noticeBoardList}" var="noticeBoard"><%-- 컨트롤러에서 보낸 목록객체 이름: boardList --%>
				<c:if test="${noticeBoard.ndelete_flag == 'Y'}">
					<tr style="background-color:Moccasin; text-align:center">
						<td><c:out value="${noticeBoard.npost_number}" /></td>
						<td colspan="5"><em>작성자에 의하여 삭제된 게시글입니다.</em></td>
					</tr>
				</c:if>
				<c:if test="${noticeBoard.ndelete_flag == 'N'}">
					<tr>
						<td><c:out value="${noticeBoard.npost_number}" /></td>
						<td style="text-align:left;" ><c:out value="${noticeBoard.ntitle}"/></td>
						<td><c:out value="${noticeBoard.nwriter}" /></td>
						<td><fmt:formatDate pattern="yyyy/MM/dd" value="${noticeBoard.nregister_date}" /></td>
						<td>${noticeBoard.nview_count}</td>
					</tr>
				</c:if>
			</c:forEach>              

                    </tbody>
                </table><%-- /.table-responsive --%>

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