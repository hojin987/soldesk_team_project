<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  



<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">product - detail</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>상품정보 상세</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<div class="form-group">
						<label>상품 내용</label>
							<input class="form-control" name="product_content" value='<c:out value="${product.product_content}"/>'
								   readonly="readonly" />
					</div>
					<div class="form-group">
						<label>상품 유통기한</label>
							<input class="form-control" name="product_period" value='<c:out value="${product.product_period}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>상품 가격</label>
							<input class="form-control" name="product_price" value='<c:out value="${product.product_price}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>상품 재고</label>
							<input class="form-control" name="product_stock" value='<c:out value="${product.product_stock}"/>'
								   readonly="readonly"/>
					</div>
						
					<button type="button" class="btn btn-default" id="BtnMoveModify" data-oper="modify">수정</button>
					<button type="button" class="btn btn-info" id="BtnMoveList" data-oper="list">목록</button>

          </div><%-- /.panel-body --%>
            
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>
  
  
<%-- 댓글 화면 표시 시작 --%>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default" >
			<div class="panel-heading">
				<p style="margin-bottom: 0px; font-size: 16px;">
					<strong style="padding-top: 2px;"> 
						<%-- <span>댓글&nbsp;<c:out value="${product.preply_count}"/>개</span>  --%>
						<span id="replyTotal"></span>
						<span>&nbsp;</span>	
						<button type="button" id="btnChgCmtReg" class="btn btn-info btn-sm">댓글 작성</button>						
						<button type="button" id="btnRegCmt" class="btn btn-warning btn-sm"
								style="display:none">댓글 등록</button>
						<button type="button" id="btnCancelRegCmt" class="btn btn-warning btn-sm"
								style="display:none">취소</button>&nbsp;&nbsp;&nbsp;
					</strong>
				</p>
			</div> <%-- /.panel-heading --%>
			
<div class="panel-body">
		
<%-- 댓글 입력창 div 시작 --%>
	<div class="form-group" style="margin-bottom: 5px;">
		<textarea class="form-control txtBoxCmt" name="pcomment"
				  placeholder="댓글작성을 원하시면,&#10;댓글 작성 버튼을 클릭해주세요."
				  readonly="readonly"
		></textarea>
	</div>
	<hr style="margin-top: 10px; margin-bottom: 10px;">	
<%-- 댓글 입력창 div 끝 --%>				
	<ul class="chat">
	<%-- 댓글 목록 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%>
		<li class="left clearfix commentLi" data-bno="123456" data-rno="12">
			<div>
				<div>
					<span class="header info-rwriter">
						<strong class="primary-font">user00</strong>
						<span>&nbsp;</span>
						<small class="text-muted">2024-01-01 13:24</small>
					</span>
					<p>앞으로 사용할 댓글 표시 기본 템플릿입니다.</p>
				</div>		
				<div class="btnsComment" style="margin-bottom:10px">
					<button type="button" style="display:in-block"
							class="btn btn-primary btn-xs btnChgReg">답글 작성</button>
					<button type="button" style="display:none"
							class="btn btn-warning btn-xs btnRegCmt">답글 등록</button>
					<hr class="txtBoxCmtHr" style="margin-top:10px; margin-bottom:10px">
					<textarea class="form-control txtBoxCmtMod" name="pcomment" 
							  style="margin-bottom:10px"
							  placeholder="답글작성을 원하시면,&#10;답글 작성 버튼을 클릭해주세요."
					></textarea>
				</div>
			</div>
		</li> 
	</ul> <%-- /.chat --%>
</div><%-- /.panel-body --%>
  
   <div class="panel-footer text-center" id="showCmtPagingNums">
	<%-- 댓글 목록의 페이징 번호 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%>
   </div>
  </div><%-- /.panel --%>
 </div><%-- .col-lg-12 --%>
</div><%-- .row : 댓글 화면 표시 끝 --%>

<%-- 댓글 페이징 데이터 저장 form --%>
<form id = "frmCmtPagingValue">
	<input type="hidden" name="pageNum" value="" />
	<input type="hidden" name="rowAmountPerPage" value="" />
</form>

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
//상품정보 수정-삭제 페이지로 이동
$("#BtnMoveModify").on("click", function(){
 location.href='${contextPath}/product/modify?product_number=<c:out value="${product.product_number}"/>';
})
//상품 목록 페이지로 이동
$("#BtnMoveList").on("click", function(){
 location.href="${contextPath}/product/list";
})
</script>


<%-- 댓글/답글 자바스크립트 시작 --%>
<script type="text/javascript" src="${contextPath}/resources/js/productcomment.js"></script>
<script> 

//게시물 번호 저장
var product_number_value = '<c:out value="${product.product_number}"/>'; 
var commentUL = $(".chat");
var frmCmtPagingValue = $("#frmCmtPagingValue");

<%--댓글목록 표시 함수: 서버로부터 전달된 데이터를 이용해서 댓글 목록을 표시하는 JS 함수--%>
function showCmtList(pageNum){
	//댓글 목록 데이터를 요청하는 클로저 모듈 함수 호출
	pcommentClsr.getCmtList(
		{product_number: product_number_value, pageNum: pageNum || 1} ,
		
		function(productCommentPagingCreator){
			
			$("#replyTotal").html("댓글&nbsp;" + productCommentPagingCreator.pcommentTotalCount + "개") ;
			
			frmCmtPagingValue.find("input[name='pageNum']").val(pageNum);
			frmCmtPagingValue.find("input[name='rowAmountPerPage']").val(productCommentPagingCreator.pcommentPaging.rowAmountPerPage) ;
			
			var str = '';
			
			//댓글이 없으면, if 문의 블록이 실행되고, 함수 실행이 중지됨(return), 따라서 for문 실행 안됨
			if(!productCommentPagingCreator.pcommentList || productCommentPagingCreator.pcommentList.length == 0){
				str += '<li class="left clearfix commentLi" '
					+ ' 	style="text-align: center; background-color: lightCyan;'
					+ ' 	height: 35px;margin-bottom: 0px;padding-bottom:0px;'
					+ ' 	padding-top:6px;border: 1px dotted;">'
					+ ' 	<strong>등록된 댓글이 없습니다.</strong></li>';
				commentUL.html(str) ;
				return ;
			} 
			
			//답글 표시 for문
			for(var i = 0, len = productCommentPagingCreator.pcommentList.length; i < len ; i++) {
				str +='<li class="left clearfix commentLi" data-product_number="' + product_number_value
					+ '"	data-pcomment_number="'+productCommentPagingCreator.pcommentList[i].pcomment_number+'">'
					+ '		<div>';
			//댓글에 대한 답글 들여쓰기
				if(productCommentPagingCreator.pcommentList[i].lvl == 1) {
					str +='  <div>';
					} else if (productCommentPagingCreator.pcommentList[i].lvl == 2){
				str += '<div style="padding-left: 25px;">' ;
					} else if (productCommentPagingCreator.pcommentList[i].lvl == 3){
				str += '<div style="padding-left: 50px;">' ;		
					} else if (productCommentPagingCreator.pcommentList[i].lvl == 4){
				str += '<div style="padding-left: 70px;">' ;
					} else {
				str += '<div style="padding-left: 100px;">' ;	
					}
			<%-- 답글에 대한 아이콘 표시  --%>	
				if(productCommentPagingCreator.pcommentList[i].lvl > 1) {
					str += '    <i class="fa fa-reply fa-fw"></i>&nbsp;';
				}

					str +='    <span class="header info-pcomment_writer">'
					    + '        <strong class="primary-font">' + productCommentPagingCreator.pcommentList[i].pcomment_writer + '</strong>&nbsp;&nbsp;'
					    + '    </span>'
					    + '    <p class="pcomment-p" style="white-space:pre-wrap;"'
					    + '       data-product_number="' + productCommentPagingCreator.pcommentList[i].product_number + '"'
					    + '       data-pcomment_number="' + productCommentPagingCreator.pcommentList[i].pcomment_number + '">'
					    +         productCommentPagingCreator.pcommentList[i].pcomment + '</p>'
					    + '</div>'
					 str+='    <div class="btnsReply" style="margin-bottom:10px">'
						+ '    		<button type="button" style="display:in-block" ' 
					    + '            class="btn btn-primary btn-xs btnChgReplyReg">'
						+ '           <span>답글작성</span></button>'
						+ '    </div>';
					 str+='</li>' ;
					}//for-End
			
						commentUL.html(str) ;
			
						showCmtPagingNums(productCommentPagingCreator.pcommentTotalCount, 
										  productCommentPagingCreator.pcommentPaging.pageNum,
										  productCommentPagingCreator.pcommentPaging.rowAmountPerPage)
		}<%-- callback-function-end --%>		
	); <%-- pcommentClsr.getCmtList(); 완료 --%>	
} <%-- showCmtList-end --%>

<%-- 댓글 페이징 번호 표시 --%>
function showCmtPagingNums(pcommentTotalCount, pageNum, rowAmountPerPage) {
	
	var pagingNumCnt = 10 ;
	
	var endPagingNum = Math.ceil(pageNum / pagingNumCnt) * pagingNumCnt ;
	
	var startPagingNum = endPagingNum - (pagingNumCnt-1) ;
	
	var lastPagingNum = Math.ceil(pcommentTotalCount/rowAmountPerPage) ;
	
	if(lastPagingNum < endPagingNum) {
		endPagingNum = lastPagingNum ;
	}
	
	var prev = startPagingNum > 1 ;
	var next = endPagingNum < lastPagingNum ;
	
	var pagingStr  
		= '<div style="text-align: center;">'
		+ '   <ul class="pagination pagination-sm" >' ;
                
	if(prev) {
               
	pagingStr 
		<%-- 맨 앞으로 --%>
	    +='        <li class="pagination-button">'
		+ '            <a href="1" aria-label="Previous">'
		+ '                <span aria-hidden="true">&laquo</span>'
		+ '            </a>'
		+ '        </li>'
		<%-- 이전 페이징 번호 그룹 --%>
		+ '        <li class="pagination-button">'
		+ '            <a href="' + (startPagingNum-1) + '" aria-label="Previous">'
		+ '                <span aria-hidden="true">이전</span>'
		+ '            </a>'
		+ '        </li>' ;
	}      
	        
	for(var i = startPagingNum ; i <= endPagingNum ; i++) {
		    
		var active = ((pageNum == i) ? "active" : "") ;
	pagingStr
	   += '        <li class="pagination-button ' + active + '" >'  
	   +  '            <a href="' + i + '">' + i + '</a>'
       +  '        </li>' ;
	}
	
	if(next) {
        
		pagingStr
			<%-- 다음 페이징 번호 그룹 --%>
			+='        <li class="pagination-button">'
			+ '            <a href="' + (endPagingNum + 1) + '" aria-label="Next">'
			+ '                <span aria-hidden="true">다음</span>'
			+ '            </a>'
			+ '        </li>' 
			<%-- 맨 뒤로 --%>
		    + '        <li class="pagination-button">'
			+ '            <a href="' + lastPagingNum + '" aria-label="Next">'
			+ '                <span aria-hidden="true">&raquo</span>'
			+ '            </a>'
			+ '        </li>' ;
		}
	
        pagingStr 
            +='    </ul>'
            + '</div>' ;
            
		$("#showCmtPagingNums").html(pagingStr);
}

<%-- 선택된 페이징 번호 클릭 시, 게시물목록 가져오는 함수: 이벤트 전파 이용 --%>
$("#showCmtPagingNums").on("click","div ul li a", function(e){
	e.preventDefault() ;
	
	var targetPageNum = $(this).attr("href") ;
	console.log("tagetPageNum: " + targetPageNum);
	
	showCmtList(targetPageNum) ;
});

<%--댓글 추가 초기화 함수 --%>
function resetCmtRegElements(){
	$("#btnChgCmtReg").attr("style", "display:in-block;") ;
	$("#btnRegCmt").attr("style", "display:none") ;
	$("#btnCancelRegCmt").attr("style", "display:none;") ;
	$(".txtBoxCmt").val("")
				   .attr("readonly", true)
				   .attr("placeholder", "댓글작성을 원하시면,\n댓글 작성 버튼을 클릭해주세요.") ;
	
	$("#spanLoginUser").attr("style", "display:none;") ;

}

<%-- 댓글 작성 버튼 클릭 처리 --%>
$("#btnChgCmtReg").on("click", function(){
	
	resetCmtRegElements();
	resetReplyRegElements();
	
	$(this).attr("style", "display:none;") ;
	$("#btnRegCmt").attr("style", "display:in-block; margin-right:2px") ;
	$("#btnCancelRegCmt").attr("style", "display:in-block;") ;
	$(".txtBoxCmt").attr("placeholder", "").attr("readonly", false) ;
	$("#spanLoginUser").attr("style", "display:in-block") ;
	
	
});

var csrfHeaderName = "${_csrf.headerName}"
var csrfTokenValue = "${_csrf.token}"

<%-- 댓글 등록 버튼 클릭 처리: 이벤트 전파 --%>
$("#btnRegCmt").on("click", function(){
	

	var txtBoxCmt = $(".txtBoxCmt").val() ;
	var loginUser = "user11" ;	
	var reply = {product_number: product_number_value, pcomment: txtBoxCmt, pcomment_writer: loginUser } ;
	
	pcommentClsr.init(csrfTokenValue, csrfHeaderName)
	
	pcommentClsr.registerCmt(
			reply,
			function(result){
				if (result != null) {
					alert(result + "번 댓글이 등록되었습니다.") ;	
				} else {
					alert("서버 장애로 댓글 등록이 취소되었습니다.") ;
				}
				
				resetCmtRegElements();

				showCmtList(-1) ;
			}
			
	);
	
});

<%-- 댓글 등록 "취소" 버튼 클릭 처리 --%>
$("#btnCancelRegCmt").on("click", "", function(){
<%--
	$("#btnChgCmtReg").attr("style", "display:in-block;") ;
	$("#btnRegCmt").attr("style", "display:none") ;
	$("#btnCancelRegCmt").attr("style", "display:none;") ;
	$(".txtBoxCmt").val("")
				   .attr("readonly", true)
				   .attr("placeholder", "댓글작성을 원하시면,\n댓글 작성 버튼을 클릭해주세요.") ; 
--%>
	resetCmtRegElements() ;
	
});

<%--답글 작성 초기화 함수 --%>
function resetReplyRegElements() {
	$(".btnRegReply").remove() ;
	$(".btnCancelRegReply").remove() ;
	$(".txtBoxReply").remove() ;
	$(".btnChgReplyReg").attr("style", "display: in-block;") ;
}

<%-- 답글 작성 버튼 클릭 처리:이벤트 전파 --%>
$(".chat").on("click", ".commentLi div div .btnChgReplyReg" , function(){
	
	$("p").attr("style", "display:in-block;");
	
	resetCmtRegElements();
	resetReplyRegElements();
	
	var strTxtBoxReply =
		  "<textarea class='form-control txtBoxReply' name='pcomment' style='margin-bottom:10px;'"
		+ " 		 placeholder='답글작성을 원하시면, &#10;답글 작성 버튼을 클릭해주세요.'"
		+ "			></textarea>"
		+ "<button type='button' class='btn btn-warning btn-xs btnRegReply'>답글 등록</button>"
		+ "<button type='button' class='btn btn-danger btn-xs btnCancelRegReply'"
		+ " 	   style='margin-left:4px;'>취소</button>";

	$(this).after(strTxtBoxReply);
	$(this).attr("style", "display:none;")//답글 작성 버튼 감춤	
});

<%-- 답글 등록 취소 버튼 클릭 처리: 이벤트 전파 --%>
$(".chat").on("click", ".commentLi .btnCancelRegReply", function(){	
	resetReplyRegElements();
});

<%-- 답글 등록 버튼 클릭 처리: 이벤트 전파 --%>
$(".chat").on("click", ".commentLi .btnRegReply", function(){

	var loginUser = "문영훈" ; 
	var pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	
	var txtBoxReply = $(this).prev().val();
	var preply_number_value = $(this).closest("li").data("pcomment_number");
	
	var reply = {product_number: product_number_value, pcomment: txtBoxReply, pcomment_writer: loginUser, preply_number: preply_number_value } ;
	
	pcommentClsr.registerReply(
			reply,
			function(result){
				alert(result + "번 답글이 등록되었습니다.") ;
				
				showCmtList(pageNum) ;
			}
	);
});

<%--댓글-답글 수정-삭제-취소-입력창 삭제 함수 --%>
function resetReplyModElements() {
	
	$("p").attr("style", "display:in-block;") ;
	
	//답글처리 관련 버튼
	$(".btnModCmt").remove() ;
	$(".btnDelCmt").remove() ;
	$(".btnCancelCmt").remove() ;
	$(".txtBoxMod").remove() ;
}

<%-- 댓글/답글 수정/삭제 화면 요소 표시 --%>

$(".chat").on("click",".commentLi p", function(){ 
	resetCmtRegElements() ;
	resetReplyRegElements() ;
	resetReplyModElements();
	
	$(this).parents("li").find(".btnChgReplyReg").attr("style", "display:none") ;	
	
	var pcomment = $(this).text() ;
		
	
	var strTxtBoxReply =
		  "<textarea class='form-control txtBoxMod' name='pcomment' style='margin-bottom:10px;'"
		+ "></textarea>"
		+ "<button type='button' class='btn btn-warning btn-sm btnModCmt'>수정</button> "
		+ "<button type='button' class='btn btn-danger btn-sm btnDelCmt'>삭제</button>"
		+ "<button type='button' class='btn btn-info btn-sm btnCancelCmt' style='margin-left: 4px;'>취소</button>";
	
	$(this).after(strTxtBoxReply) ;
	$(".txtBoxMod").val(pcomment);
	$(this).attr("style", "display:none");
		
}) ;

<%-- 댓글-답글 수정/삭제 취소 --%>
$(".chat").on("click", ".commentLi .btnCancelCmt", function(){
	resetCmtRegElements() ;
	resetReplyRegElements() ;
	resetReplyModElements();	
});

<%-- 댓글-답글 수정 처리: 버튼 클릭 이벤트 --%>
$(".chat").on("click", ".commentLi .btnModCmt", function(){
	
	var pcomment_writer_value = $(this).siblings("p").data("pcomment_writer") ;
	var pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	
	var txtBoxComment = $(this).prev().val() ;
	var pcomment_value = $(this).closest("li").data("pcomment_number");
	
	var cmtReply = {product_number: product_number_value, pcomment_number: pcomment_value, pcomment: txtBoxComment, pcomment_writer: pcomment_writer_value} ;
	
	pcommentClsr.modifyCmtReply(
			cmtReply,
			function(result){
				alert("댓글(답글)이 수정되었습니다.") ;
				
				showCmtList(pageNum) ;			
			}
	);
});

<%-- 댓글-답글 삭제 처리: 버튼 클릭 이벤트--%>
$(".chat").on("click",".commentLi .btnDelCmt", function(){
	
	var pcomment_writer_value = $(this).siblings("p").data("pcomment_writer") ;
	var delConfirm = confirm('삭제하시겠습니까?');
	
	if(!delConfirm){
		alert('삭제가 취소되었습니다.');
		return;
	}
	
	var pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	
	var pcomment_value = $(this).closest("li").data("pcomment_number");
	
	var comment ={product_number: product_number_value, pcomment_number: pcomment_value, pcomment_writer: pcomment_writer_value} ;
	
	pcommentClsr.removeCmtReply(
			comment,
			function(){
				alert("글이 삭제되었습니다.") ;

				showCmtList(pageNum) ;
			}
	);
});





<%-- 제일 아래 --%>
$(document).ready(function(){
	
	showCmtList(1);
	
});



</script>
<%@include file="../myinclude/myfooter.jsp" %>  