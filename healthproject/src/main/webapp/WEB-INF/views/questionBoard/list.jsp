<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 
https://getbootstrap.kr/
https://getbootstrap.com/
https://startbootstrap.com/
-->

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
            <h3 class="page-header">1:1문의게시판</h3>
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
                
                
<form class="form-inline" id="frmSendValue" name="frmSendValue" action="${contextPath }/questionBoard/list" method="get" >
	<div class="form-group">
		<label class="sr-only">frmSendValues</label>
		<select class="form-control" id="selectAmount" name="rowAmountPerPage">
			<option value="5" ${(pagingCreator.questionboardPaging.rowAmountPerPage == 5) ? "selected" : "" }>5개</option>
			<option value="10" ${(pagingCreator.questionboardPaging.rowAmountPerPage == 10) ? "selected" : "" }>10개</option>
			<option value="20" ${(pagingCreator.questionboardPaging.rowAmountPerPage == 20) ? "selected" : "" }>20개</option>
			<option value="50" ${(pagingCreator.questionboardPaging.rowAmountPerPage == 50) ? "selected" : "" }>50개</option>
			<option value="100" ${(pagingCreator.questionboardPaging.rowAmountPerPage == 100) ? "selected" : "" }>100개</option>
		</select>
		
		<select class="form-control" id="selectScope" name="scope">
			<option value="" ${(pagingCreator.questionboardPaging.scope == null ) ? "selected" : "" }>범위선택</option>
			<option value="T" ${(pagingCreator.questionboardPaging.scope == "T" ) ? "selected" : "" }>제목</option>
			<option value="C" ${(pagingCreator.questionboardPaging.scope == "C" ) ? "selected" : "" }>내용</option>
			<option value="W" ${(pagingCreator.questionboardPaging.scope == "W" ) ? "selected" : "" }>작성자</option>
			<option value="TC" ${(pagingCreator.questionboardPaging.scope == "TC" ) ? "selected" : "" }>제목+내용</option>
			<option value="TCW" ${(pagingCreator.questionboardPaging.scope == "TCW" ) ? "selected" : "" }>제목+내용+작성자</option>
		</select>
		
		
		<div class="input-group"><!-- 검색어 입력 -->
			<input class="form-control" id="keyword" name="keyword" type="text" 
			       placeholder="검색어를 입력하세요"
				   value='<c:out value="${pagingCreator.questionboardPaging.keyword}" />' />
			<span class="input-group-btn"><!-- 전송버튼 -->
				<button class="btn btn-warning" type="button" id="btnSearchGo"
						><i class="fa fa-search"></i>
				</button>
			</span>
		</div>
		
		<div class="input-group"><!-- 검색 초기화 버튼 -->
			<button id="btnReset" class="btn btn-info" type="button">
				<span class="glyphicon glyphicon-remove"></span>
			</button>
		</div>
	</div>

	<div class="form-group pull-right">
		<input class="form-control" id="beginDate" name="beginDate" type="date"
			   value="${pagingCreator.questionboardPaging.beginDate}" 
			   />
		<input class="form-control" id="endDate" name="endDate" type="date"
			   value="${pagingCreator.questionboardPaging.endDate}" 
			   />

		<button type="button" class="btn btn-primary mybtns" 
				id="btnIntervalSearch" >기간검색</button>
	</div> 
	
	<input type="hidden" id="pageNum" name="pageNum" value="${pagingCreator.questionboardPaging.pageNum }" >
	<input type="hidden" id="lastPageNum" name="lastPageNum" value="${pagingCreator.lastPageNum }" >
	
</form>                
<hr>     
               
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

<c:choose>
<c:when test="${not empty pagingCreator.questionboardList }">
	<c:forEach var="questionboard" items="${pagingCreator.questionboardList}">
		<c:choose>
			<c:when test="${questionboard.qdelete_flag == 'Y' }">
				<tr style="background-color: Moccasin; text-align: center">
				    <td>${questionboard.qpost_number }</td>
				    <td colspan="6"><em>작성자에 의해서 삭제된 게시글입니다.</em></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr class="moveDetail" data-qpost_number="${questionboard.qpost_number }">
					<td><c:out value="${questionboard.qpost_number }"/></td>
					<td style="text-align: left">
						<c:out value="${questionboard.qtitle }"/>
						<small>[댓글수: <strong><c:out value="${questionboard.qreply_count}"/></strong>]</small>
					</td>
					<td>${questionboard.qwriter }</td>
					<td class="center"><fmt:formatDate value="${questionboard.qregister_date }" pattern="yyyy/MM/dd HH:mm:ss"/></td>
					<td class="center"><c:out value="${questionboard.qview_count }"/></td>
				 </tr>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:when>
<c:otherwise>
		<tr class="odd gradeX">
			<td colspan="6">등록된 게시물이 없습니다.</td>
		 </tr>
</c:otherwise>
</c:choose>                        

                        </tbody>
                    </table><%-- /.table-responsive --%>
<div style="text-align: center;">
	<ul class="pagination pagination-sm" >
		<c:if test="${pagingCreator.prev }">
			<li class="pagination-button">
				<a href="1" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>
		</c:if>
		<c:if test="${pagingCreator.prev }">
			<li class="pagination-button">
				<a href="${pagingCreator.startPagingNum - 1 }" aria-label="Previous">
					<span aria-hidden="true">이전</span>
				</a>
			</li>
		</c:if>
		<c:forEach begin="${pagingCreator.startPagingNum }" 
		           end="${pagingCreator.endPagingNum }" 
		           var="pagingNum">
			
			<li class='pagination-button ${(pagingNum == pagingCreator.questionboardPaging.pageNum) ? "active" : ""}'>
				<a href="${pagingNum }">${pagingNum }</a>
			</li>     
		</c:forEach>
		<c:if test="${pagingCreator.next }">
			<li class="pagination-button">
				<a href="${pagingCreator.endPagingNum + 1 }" aria-label="Next">
					<span aria-hidden="true">다음</span>
				</a>
			</li>
		</c:if>
		<c:if test="${pagingCreator.next }">
			<li class="pagination-button">
				<a href="${pagingCreator.lastPageNum }" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</c:if>
		
	  
	</ul>
</div>

                    
                    
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

var frmSendValue = $("#frmSendValue") ;
var result = '<c:out value="${result}" />' ;

//등록페이지 이동
$("#btnToRegister").on("click",function(){
	window.location.href = "${contextPath}/questionBoard/register" ; 

	
});

//상세페이지 이동
$(".moveDetail").on("click", function(){
	var qpost_number = $(this).data("qpost_number") ;
	
	frmSendValue.append("<input type='hidden' name='qpost_number' value='" + qpost_number + "'/>")
	frmSendValue.attr("action", "${contextPath}/questionBoard/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="qpost_number"]').remove() ;  
										
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


<%-- 페이지징 처리: 검색 목록 페이지 이동 --%>
$("li.pagination-button a").on("click", function(e){
	e.preventDefault() ;
	frmSendValue.find("input[name='pageNum']").val($(this).attr("href")) ;
	console.log(frmSendValue.find("input[name='pageNum']").val());
	frmSendValue.attr("action", "${contextPath}/questionBoard/list") ;
	frmSendValue.attr("method", "get") ;
	
	frmSendValue.submit() ;
	
});

<%--검색 관련 요소의 이벤트 처리--%>
<%--표시행수 변경 이벤트 처리--%>
$("#selectAmount").on("change", function(){
	frmSendValue.find("input[name='pageNum']").val(1) ;
	frmSendValue.submit() ;
} );


<%--키워드 검색버튼 클릭 이벤트 처리 --%>
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


<%--기간 검색버튼 클릭 이벤트 처리 --%>
$("#btnIntervalSearch").on("click", function(){
	
	var beginDate = $("#beginDate").val() ;
	var endDate = $("#endDate").val() ;
	
	if (!beginDate || beginDate == "" || !endDate || endDate == "") {
		alert("시작날짜와 끝날짜를 모두 선택하세요") ;
		return ;
	}

	frmSendValue.find("input[name='pageNum']").val(1) ;
	frmSendValue.submit() ;
	
});


<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
$("#btnReset").on("click", function(){
	$("#selectAmount").val(10) ;
	$("#selectScope").val("") ;
	$("#keyword").val("") ;
	$("#beginDate").val("") ;
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



</script>

<%@include file="../myinclude/myfooter.jsp" %>    