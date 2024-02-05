<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>s

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<style>
 th {text-align: center;}
 body {
    background-color: #f0f0f0;
}
 strong {color: #000}
     .table {
        border-collapse: separate;
        border-spacing: 0;
        border: 2px solid #ddd;
    }
.table {
    table-layout: fixed;
    width: 100%;
    overflow: auto;
}

.table th:nth-child(1),
.table td:nth-child(1) {
    width: 5%;
    text-align: center;
}

.table th:nth-child(2),
.table td:nth-child(2) {
    width: 60%;
}

.table th:nth-child(3),
.table td:nth-child(3){
    width: 8%;
    text-align: center;
}
.table th:nth-child(4),
.table td:nth-child(4){
    width: 15%;
    text-align: center;
}
.table th:nth-child(5),
.table td:nth-child(5) {
    width: 9%;
    text-align: center;
}

.table th, .table td {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.table-bordered th, .table-bordered td {
    border: none !important;
}


</style> 
  
    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-8">
        
            <div class="panel panel-default">
                <div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">자유게시판</div>
						<div class="col-md-6" style="padding-top:8px;">
							<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">글쓰기</button>
						</div>
					</div>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
                
                
<form class="form-inline" id="frmSendValue" name="frmSendValue" action="${contextPath }/freeBoard/list" method="get" >
	<div class="form-group">
		<label class="sr-only">frmSendValues</label>
		<select class="form-control" id="selectAmount" name="rowAmountPerPage">
			<option value="5" ${(pagingCreator.freeboardPaging.rowAmountPerPage == 5) ? "selected" : "" }>5개</option>
			<option value="10" ${(pagingCreator.freeboardPaging.rowAmountPerPage == 10) ? "selected" : "" }>10개</option>
			<option value="20" ${(pagingCreator.freeboardPaging.rowAmountPerPage == 20) ? "selected" : "" }>20개</option>
			<option value="50" ${(pagingCreator.freeboardPaging.rowAmountPerPage == 50) ? "selected" : "" }>50개</option>
			<option value="100" ${(pagingCreator.freeboardPaging.rowAmountPerPage == 100) ? "selected" : "" }>100개</option>
		</select>	
		
		<!-- 달력버튼 -->
<button id="btnCalendar" class="btn btn-primary btn-sm" type="button">
    <span class="glyphicon glyphicon-calendar"></span>
</button>

<!-- 기간 검색 필드 -->
<div class="form-group pull-right" id="dateSearch" style="display: none;">
    <input class="form-control" id="beginDate" name="beginDate" type="date"
           value="${pagingCreator.freeboardPaging.beginDate}" />
    <input class="form-control" id="endDate" name="endDate" type="date"
           value="${pagingCreator.freeboardPaging.endDate}" />
    <button type="button" class="btn btn-primary mybtns btn-sm" 
            id="btnIntervalSearch">기간검색</button>
</div>	
				
	</div>

	

	
	<input type="hidden" id="pageNum" name="pageNum" value="${pagingCreator.freeboardPaging.pageNum }" ><%-- 
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${pagingCreator.freeboardPaging.rowAmountPerPage }" > --%>
	<input type="hidden" id="lastPageNum" name="lastPageNum" value="${pagingCreator.lastPageNum }" >
	
</form>                
<hr>     
<table class="table table-striped table-bordered table-hover">
    <thead>
        <tr style="background-color: #f2f2f2;">
            <th style="color: #5a5a5a;">번호</th>
            <th style="color: #5a5a5a;">제목</th>
            <th style="color: #5a5a5a;">작성자</th>
            <th style="color: #5a5a5a;">작성일</th>
            <th style="color: #5a5a5a;">조회수</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="post" items="${top3Posts}">
            <tr class="moveDetail" data-fpost_number="${post.fpost_number }" style="background-color: #FFFFE0;"> 
                <td><c:out value="${post.fpost_number }"/></td>
                <td style="text-align: left">
                    <c:out value="${post.ftitle }"/>
                    <small>[댓글수: <strong><c:out value="${post.freply_count}"/></strong>]</small>
                </td>
                <td>${post.fwriter }</td>
                <td class="center"><fmt:formatDate value="${post.fregister_date }" pattern="yyyy/MM/dd"/></td>
                <td class="center"><c:out value="${post.fview_count }"/></td>
            </tr>
        </c:forEach>
    </tbody>        
                      <tbody>

<c:choose>
<c:when test="${not empty pagingCreator.freeboardList }">
	<c:forEach var="freeboard" items="${pagingCreator.freeboardList}">
		<c:choose>
			<c:when test="${freeboard.fdelete_flag == 'Y' }">
				<tr style="background-color: Moccasin; text-align: center">
				    <td>${freeboard.fpost_number }</td>
				    <td colspan="3"><em>블라인드처리 된 게시글입니다.</em></td>
				    <td>
				    <sec:authorize access="hasAuthority('ADMIN')">
				    	<button type="button" class="btn btn-primary btn-xs" onclick="deletePost(${freeboard.fpost_number})">삭제</button>
					</sec:authorize>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr class="moveDetail" data-fpost_number="${freeboard.fpost_number }">
					<td><c:out value="${freeboard.fpost_number }"/></td><%-- 
					<td style="text-align: left"><a href="${contextPath }/freeBoard/detail?fpost_number=${freeboard.fpost_number}" ><c:out value="${freeboard.ftitle }"/></a></td> --%>
					<td style="text-align: left">
						<c:out value="${freeboard.ftitle }"/>
						<small>[댓글수: <strong><c:out value="${freeboard.freply_count}"/></strong>]</small>
					</td>
					<td>${freeboard.fwriter }</td>
					<td class="center"><fmt:formatDate value="${freeboard.fregister_date }" pattern="yyyy/MM/dd"/></td>
					<td class="center"><c:out value="${freeboard.fview_count }"/></td>
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
                    
<form class="form-inline" id="frmSendValue" name="frmSendValue" action="${contextPath }/freeBoard/list" method="get" style="center" >
	<div class="form-group">
		<label class="sr-only">frmSendValues</label>
		
		<select class="form-control" id="selectScope" name="scope">
 			<option value="TC" ${(pagingCreator.freeboardPaging.scope == "TC" ) ? "selected" : "" }>제목+내용</option>
			<option value="T" ${(pagingCreator.freeboardPaging.scope == "T" ) ? "selected" : "" }>제목</option>
			<option value="C" ${(pagingCreator.freeboardPaging.scope == "C" ) ? "selected" : "" }>내용</option>
			<option value="W" ${(pagingCreator.freeboardPaging.scope == "W" ) ? "selected" : "" }>작성자</option>
		</select>
		
		
		<div class="input-group"><!-- 검색어 입력 -->
			<input class="form-control" id="keyword" name="keyword" type="text" 
			       placeholder="검색어를 입력하세요"
				   value='<c:out value="${pagingCreator.freeboardPaging.keyword}" />' />
			<span class="input-group-btn"><!-- 전송버튼 -->
				<button class="btn btn-primary btn-sm" type="button" id="btnSearchGo"
						><i class="fa fa-search"></i>
				</button>
			</span>
		</div>
	</div>
	
	<input type="hidden" id="pageNum" name="pageNum" value="${pagingCreator.freeboardPaging.pageNum }" ><%-- 
	<input type="hidden" id="rowAmountPerPage" name="rowAmountPerPage" value="${pagingCreator.freeboardPaging.rowAmountPerPage }" > --%>
	<input type="hidden" id="lastPageNum" name="lastPageNum" value="${pagingCreator.lastPageNum }" >
	
</form>       
                    
                    
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
			
			<li class='pagination-button ${(pagingNum == pagingCreator.freeboardPaging.pageNum) ? "active" : ""}'>
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
	window.location.href = "${contextPath}/freeBoard/register" ; 

	
});

//상세페이지 이동
$(".moveDetail").on("click", function(){
	var fpost_number = $(this).data("fpost_number") ;
	
	frmSendValue.append("<input type='hidden' name='fpost_number' value='" + fpost_number + "'/>")
	frmSendValue.attr("action", "${contextPath}/freeBoard/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="fpost_number"]').remove() ;  
										
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

<%-- 페이징 처리: 검색 목록 페이지 이동 --%>
$("li.pagination-button a").on("click", function(e){
	e.preventDefault() ;
	frmSendValue.find("input[name='pageNum']").val($(this).attr("href")) ;
	console.log(frmSendValue.find("input[name='pageNum']").val());
	frmSendValue.attr("action", "${contextPath}/freeBoard/list") ;
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

<%-- 기간검색 숨기기 --%>
document.addEventListener('DOMContentLoaded', function() {
    var btnCalendar = document.getElementById('btnCalendar');
    var dateSearch = document.getElementById('dateSearch');

    btnCalendar.addEventListener('click', function() {
        // 기간 검색 필드 표시
        dateSearch.style.display = 'block';

        // 달력 버튼 숨기기
        btnCalendar.style.display = 'none';
    });
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

function deletePost(fpost_number) {
	var csrfHeader = "${_csrf.headerName}"
	var csrfToken = "${_csrf.token}"
	
    $.ajax({
        url: '${contextPath}/freeBoard/erase',
        type: 'POST',
        data: {fpost_number: fpost_number},
        beforeSend: function(xhr) {
        	xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function(response) {
        	location.reload()
        },
        error: function(error) {
            console.error('Error:', error);
        }
    });
}

</script>

<%@include file="../myinclude/myfooter.jsp" %>    