<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>


<%@include file="../myinclude/myheader.jsp" %>  

<style>
 th {text-align: center;}
 strong {color:#000000;}
</style>  

<style>
.txtBoxCmt, .txtBoxComment {
	overflow: hidden; resize: vertical; min-height: 100px; color: black;
}
</style>

    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-8">
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px;">${noticeBoard.nwriter}님 작성</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
								<span>
									<span>등록일:&nbsp;</span>
									<strong><fmt:formatDate 
												pattern="yyyy-MM-dd HH:mm:ss"
												value="${noticeBoard.nregister_date}"
											 /></strong>
									<span>&nbsp;&nbsp;</span>
								</span>
								<span>조회수:&nbsp;<strong><c:out value="${noticeBoard.nview_count}"/></strong>
								</span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
							
				<sec:authorize access="isAuthenticated()" >
					<sec:authentication property="principal" var="principal"/>
						<c:if test="${principal.username eq noticeBoard.nwriter}">
							<button type="button" id="btnToModify" data-oper="modify"
									class="btn btn-primary btn-sm"><span>수정페이지로 이동</span></button>
						</c:if>
					</sec:authorize>		
							<button type="button" id="btnToList" data-oper="list"
									class="btn btn-primary btn-sm"><span>목록페이지로 이동</span></button>
							</div>
						</div>
					</div>
                </div><!-- /.panel-heading --><%-- /.panel-heading --%>
                
                <div class="panel-body">

	
	<div class="form-group">
	    <label>글제목</label>
	    <input class="form-control" name="ntitle" id="ntitle" 
	    	   value="${noticeBoard.ntitle }" readonly="readonly">
	</div>
	<div class="form-group">
	    <label>글내용</label>
	    <textarea class="form-control" rows="3" name="ncontent" id="ncontent"
	    		  readonly="readonly">${noticeBoard.ncontent}</textarea>
	</div>
	
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



<%-- 댓글 화면 표시 시작 --%>
<div class="row" style="display: flex; justify-content: center;">
	<div class="col-lg-8">
		<div class="panel panel-default" >
			<div class="panel-heading">
				<p style="margin-bottom: 0px; font-size: 16px;">
					<strong style="padding-top: 2px;"> 
						<%-- <span>댓글&nbsp;<c:out value="${noticeBoard.nreply_count}"/>개</span>  --%>
						<span id="replyTotal"></span>
						<span>&nbsp;</span>	
						
						<sec:authorize access="isAuthenticated()" >	
							<button type="button" id="btnChgCmtReg" class="btn btn-primary btn-sm">댓글 작성</button>	
						</sec:authorize>	
											
							<button type="button" id="btnRegCmt" class="btn btn-primary btn-sm"
								style="display:none">댓글 등록</button>
							<button type="button" id="btnCancelRegCmt" class="btn btn-warning btn-sm"
								style="display:none">취소</button>&nbsp;&nbsp;&nbsp;
					</strong>
				</p>
			</div> <%-- /.panel-heading --%>
			
<div class="panel-body">
		
<%-- 댓글 입력창 div 시작 --%>
<sec:authorize access="isAuthenticated()" >
	<div class="form-group" style="margin-bottom: 5px;">
		<textarea class="form-control txtBoxCmt" name="ncomment"
				  placeholder="댓글작성을 원하시면,&#10;댓글 작성 버튼을 클릭해주세요."
				  readonly="readonly"
		></textarea>
	</div>
	<hr style="margin-top: 10px; margin-bottom: 10px;">	
</sec:authorize>
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
							class="btn btn-primary btn-xs btnRegCmt">답글 등록</button>
					<hr class="txtBoxCmtHr" style="margin-top:10px; margin-bottom:10px">
					<textarea class="form-control txtBoxCmtMod" name="ncomment" 
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

//게시물 목록 페이지 이동
$("#btnToList").on("click", function(){;

	frmSendValue.attr("action", "${contextPath}/noticeBoard/list").attr("method", "get") ;
	frmSendValue.submit() ;
});

//게시물 수정-삭제 페이지 이동
$("#btnToModify").on("click", function(){
	
	var npost_number = '<c:out value="${noticeBoard.npost_number}"/>' ;
	
	frmSendValue.append("<input type='hidden' name='npost_number' value='" + npost_number + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/noticeBoard/modify").attr("method", "get") ;
	frmSendValue.submit() ;
});


var result = '<c:out value="${result}" />' ;
//alert("result" + result);

function runModal(result) {
	
	if (result.length == 0) {
		return ;
	
	} else if ( result == "successModify" ) {
		var myMsg =  "게시글이 수정되었습니다. " ;
		
	}  

	$("#yourModal-body").html(myMsg) ;
	
	$("#yourModal").modal("show") ;
	
	myMsg = "" ;
}
</script>


<%-- 첨부파일 이미지 표시 --%>
<script>
$(".attachLi").on("click", function(){
	var objLi = $(this) ;
	var myFileName = objLi.data("repopath") + "/" + objLi.data("uploadpath") + "/" 
				   + objLi.data("uuid") + "_" + objLi.data("filename");
	
	if(objLi.data("filetype")=="I"){
		$("#attachModal-body").html("<img src='${contextPath}/fileDownloadAjax?fileName=" + encodeURI(myFileName) + "' style='width:80%' >");
		
		$("#attachModal").modal("show");
	}else{
		self.location="${contextPath}/fileDownloadAjax?fileName=" + encodeURI(myFileName) ;
	}
	
})

<%-- 표시된 이미지 모달 감추기 --%>
$("#attachModal").on("click", function(){
	$(this).modal("hide");
})

</script>

<%-- 댓글/답글 자바스크립트 시작 --%>
<script type="text/javascript" src="${contextPath}/resources/js/noticecomment.js"></script>
<script> 

<%-- 로그인 계정을 loginUser 변수에 저장 --%>
var loginUser = "";
<sec:authorize access="isAuthenticated()">
	loginUser = '<sec:authentication property="principal.username"/>';
</sec:authorize>

<%-- HTML에서 일어나는 모든 Ajax 전송 요청에 대하여 csrf 토큰값이 요청 헤더에 설정됨 --%>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

//게시물 번호 저장
var npost_number_value = '<c:out value="${noticeBoard.npost_number}"/>'; 
var commentUL = $(".chat");
var frmCmtPagingValue = $("#frmCmtPagingValue");

//댓글 목록 데이터 요청 받기 테스트
/*  ncommentClsr.getCmtList(
	{npost_number:npost_number_value, pageNum:1},
	function(noticeCommentPagingCreator){
		for(var i =0,len=noticeCommentPagingCreator.ncommentList.length || 0; i < len; i++){
			console.log(noticeCommentPagingCreator.ncommentList[i]);
		}	
	}		
);  */ 

/* //댓글등록 테스트
ncommentClsr.registerCmt(
		{npost_number:npost_number_value, ncomment:"js-클로저-댓글입력 테스트", ncomment_writer: "user5"},
		function(result){
			alert("ncommentClsr.registerCmt()처리결과 " + result);
		}
);  */

/* //답글등록 테스트
ncommentClsr.registerReply(
		{npost_number:npost_number_value, nreply_number: 1, ncomment:"js-클로저-답글입력 테스트", ncomment_writer: "user6"},
		function(result){
			alert("ncommentClsr.registerReply()처리결과 " + result);
		}
); */ 

/*  //댓글-답글 조회 테스트
ncommentClsr.getCmtReply(
		{npost_number:npost_number_value, ncomment_number:274},
		function(data){
			console.log(data);
		}
);  

//댓글-답글 수정 테스트
ncommentClsr.modifyCmtReply(
		{npost_number:npost_number_value, ncomment_number:274, ncomment:"js클로저에 의한 댓글 수정 테스트"},
		function(modifyResult){
			console.log(modifyResult);
		}
);  */

//댓글 삭제 테스트
/* ncommentClsr.removeCmtReply(
		{npost_number: npost_number_value, ncomment_number: 273, ncomment_writer:"user10"},
		function(deleteResult){
			console.log(deleteResult);
			if(deleteResult === "댓글 삭제 성공") {
				alert(deleteResult + ": 댓글/답글이 삭제되었습니다.");
			}
		},
		function(err) {
			alert("오류로 댓글/답글 삭제 작업 취소..");
		}
); */ 

<%--댓글목록 표시 함수: 서버로부터 전달된 데이터를 이용해서 댓글 목록을 표시하는 JS 함수--%>
function showCmtList(pageNum){
	//댓글 목록 데이터를 요청하는 클로저 모듈 함수 호출
	ncommentClsr.getCmtList(
		{npost_number: npost_number_value, pageNum: pageNum || 1} ,
		
		function(noticeCommentPagingCreator){
			
			$("#replyTotal").html("댓글&nbsp;" + noticeCommentPagingCreator.ncommentTotalCount + "개") ;
			
			frmCmtPagingValue.find("input[name='pageNum']").val(pageNum);
			frmCmtPagingValue.find("input[name='rowAmountPerPage']").val(noticeCommentPagingCreator.ncommentPaging.rowAmountPerPage) ;
			
			var str = '';
			
			//댓글이 없으면, if 문의 블록이 실행되고, 함수 실행이 중지됨(return), 따라서 for문 실행 안됨
			if(!noticeCommentPagingCreator.ncommentList || noticeCommentPagingCreator.ncommentList.length == 0){
				str += '<li class="left clearfix commentLi" '
					+ ' 	style="text-align: center; background-color: lightCyan;'
					+ ' 	height: 35px;margin-bottom: 0px;padding-bottom:0px;'
					+ ' 	padding-top:6px;border: 1px dotted;">'
					+ ' 	<strong>등록된 댓글이 없습니다.</strong></li>';
				commentUL.html(str) ;
				return ;
			} 
			
			//답글 표시 for문
			for(var i = 0, len = noticeCommentPagingCreator.ncommentList.length; i < len ; i++) {
				str +='<li class="left clearfix commentLi" data-npost_number="' + npost_number_value
					+ '"	data-ncomment_number="'+noticeCommentPagingCreator.ncommentList[i].ncomment_number+'">'
					+ '		<div>';
			//댓글에 대한 답글 들여쓰기
				if(noticeCommentPagingCreator.ncommentList[i].lvl == 1) {
					str +='  <div>';
					} else if (noticeCommentPagingCreator.ncommentList[i].lvl == 2){
				str += '<div style="padding-left: 25px;">' ;
					} else if (noticeCommentPagingCreator.ncommentList[i].lvl == 3){
				str += '<div style="padding-left: 50px;">' ;		
					} else if (noticeCommentPagingCreator.ncommentList[i].lvl == 4){
				str += '<div style="padding-left: 70px;">' ;
					} else {
				str += '<div style="padding-left: 100px;">' ;	
					}
			<%-- 답글에 대한 아이콘 표시  --%>	
				if(noticeCommentPagingCreator.ncommentList[i].lvl > 1) {
					str += '    <i class="fa fa-reply fa-fw"></i>&nbsp;';
				}

					str +='    <span class="header info-ncomment_writer">'
					    + '        <strong class="primary-font">' + noticeCommentPagingCreator.ncommentList[i].ncomment_writer + '</strong>&nbsp;&nbsp;'
					    + '    </span>'
					    + '    <p class="ncomment-p" style="white-space:pre-wrap;"'
					    + '       data-npost_number="' + noticeCommentPagingCreator.ncommentList[i].npost_number + '"'
					    + '       data-ncomment_number="' + noticeCommentPagingCreator.ncommentList[i].ncomment_number + '"'
					    + '       data-ncomment_writer="' + noticeCommentPagingCreator.ncommentList[i].ncomment_writer + '">'
					    +         noticeCommentPagingCreator.ncommentList[i].ncomment + '</p>'
					    + '</div>'
					      <sec:authorize access="isAuthenticated()" >
					 str+='    <div class="btnsReply" style="margin-bottom:10px">'
						+ '    		<button type="button" style="display:in-block" ' 
					    + '            class="btn btn-primary btn-xs btnChgReplyReg">'
						+ '           <span>답글작성</span></button>'
						+ '    </div>';
						  </sec:authorize>
					 str+='</li>' ;
					}//for-End
			
						commentUL.html(str) ;
			
						showCmtPagingNums(noticeCommentPagingCreator.ncommentTotalCount, 
								  		  noticeCommentPagingCreator.ncommentPaging.pageNum,
								 		  noticeCommentPagingCreator.ncommentPaging.rowAmountPerPage)
		}<%-- callback-function-end --%>		
	); <%-- ncommentClsr.getCmtList(); 완료 --%>	
} <%-- showCmtList-end --%>

<%-- 댓글 페이징 번호 표시 --%>
function showCmtPagingNums(ncommentTotalCount, pageNum, rowAmountPerPage) {
	
	var pagingNumCnt = 10 ;
	
	var endPagingNum = Math.ceil(pageNum / pagingNumCnt) * pagingNumCnt ;
	
	var startPagingNum = endPagingNum - (pagingNumCnt-1) ;
	
	var lastPagingNum = Math.ceil(ncommentTotalCount/rowAmountPerPage) ;
	
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
	
	//var loginUser = "user10" ;	
	
	//로그인 유무 검증
	if(!loginUser){
		alert("로그인 후, 등록이 가능합니다.");
		return ;
	}
	console.log("댓글등록 시 loginUser: "+ loginUser);
	
	var txtBoxCmt = $(".txtBoxCmt").val() ;
	var reply = {npost_number: npost_number_value, ncomment: txtBoxCmt, ncomment_writer: loginUser } ;
	
	ncommentClsr.init(csrfTokenValue, csrfHeaderName)
	
	ncommentClsr.registerCmt(
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
		  "<textarea class='form-control txtBoxReply' name='ncomment' style='margin-bottom:10px;'"
		+ " 		 placeholder='답글작성을 원하시면, &#10;답글 작성 버튼을 클릭해주세요.'"
		+ "			></textarea>"
		+ "<button type='button' class='btn btn-primary btn-xs btnRegReply'>답글 등록</button>"
		+ "<button type='button' class='btn btn-warning btn-xs btnCancelRegReply'"
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

	//var loginUser = "문영훈" ; 
	if(!loginUser){
		alert("로그인 후, 답글 등록이 가능합니다.");
		return ;
	}
	console.log("답글 등록 시 loginUser: "+ loginUser);
	
	var pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	
	var txtBoxReply = $(this).prev().val();
	var nreply_number_value = $(this).closest("li").data("ncomment_number");
	
	var reply = {npost_number: npost_number_value, ncomment: txtBoxReply, ncomment_writer: loginUser, nreply_number: nreply_number_value } ;
	
	ncommentClsr.init(csrfTokenValue, csrfHeaderName)
	
	ncommentClsr.registerReply(
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

<%--로그인 사용자명 변수에 저장하는 코드는 댓글/답글 자바스크립트 코드 시작 부분으로 이동시킵니다.--%>
var loginUser = "";
<sec:authorize access="isAuthenticated()">
	loginUser = '<sec:authentication property="principal.username"/>';<%--로그인 사용자명 변수에 저장--%>
</sec:authorize>

<%-- 댓글/답글 수정/삭제 화면 요소 표시 --%>
$(".chat").on("click",".commentLi p", function(){ 
	resetCmtRegElements() ;
	resetReplyRegElements() ;
	resetReplyModElements();
	
	<%--로그인 하지 않은 경우--%>
	if(!loginUser){
		alert("로그인 후, 수정이 가능합니다.");
		return ;
	}
	
	<%--작성자 변수에 저장--%>
	var ncomment_writer = $(this).data("ncomment_writer");

	<%--로그인 계정과 작성자가 다른 경우--%>
	if(ncomment_writer != loginUser){
	alert("작성자만 수정 가능합니다");
	return ;
	}
	
	$(this).parents("li").find(".btnChgReplyReg").attr("style", "display:none") ;	
	
	var ncomment = $(this).text() ;
		
	
	var strTxtBoxReply =
		  "<textarea class='form-control txtBoxMod' name='ncomment' style='margin-bottom:10px;'"
		+ "></textarea>"
		+ "<button type='button' class='btn btn-primary btn-sm btnModCmt'>수정</button> "
		+ "<button type='button' class='btn btn-primary btn-sm btnDelCmt'>삭제</button>"
		+ "<button type='button' class='btn btn-warning btn-sm btnCancelCmt' style='margin-left: 4px;'>취소</button>";
	
	$(this).after(strTxtBoxReply) ;
	$(".txtBoxMod").val(ncomment);
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
	
	if(!loginUser){
		alert("로그인 후, 수정이 가능합니다.");
		return ;
	}
	
	var ncomment_writer_value = $(this).siblings("p").data("ncomment_writer") ;
	
	if(ncomment_writer_value != loginUser){
		alert("작성자만 수정 가능합니다");
		return ;
	}
	
	var pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	var txtBoxComment = $(this).prev().val() ;
	var ncomment_value = $(this).closest("li").data("ncomment_number");
	
	var cmtReply = {npost_number: npost_number_value, ncomment_number: ncomment_value, ncomment: txtBoxComment, ncomment_writer: ncomment_writer_value} ;
	
	/* ncommentClsr.init(csrfTokenValue, csrfHeaderName) */
	
	ncommentClsr.modifyCmtReply(
			cmtReply,
			function(result){
				alert("댓글(답글)이 수정되었습니다.") ;
				
				showCmtList(pageNum) ;			
			}
	);
});

<%-- 댓글-답글 삭제 처리: 버튼 클릭 이벤트--%>
$(".chat").on("click",".commentLi .btnDelCmt", function(){
	
	if(!loginUser){
		alert("로그인 후, 삭제가 가능합니다.");
		return ;
	}
	
	var ncomment_writer_value = $(this).siblings("p").data("ncomment_writer") ;
	if(ncomment_writer_value != loginUser){
		alert("작성자만 삭제 가능합니다");
		return ;
	}
	
	var delConfirm = confirm('삭제하시겠습니까?');
	
	if(!delConfirm){
		alert('삭제가 취소되었습니다.');
		return;
	}
	
	var pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	
	var ncomment_value = $(this).closest("li").data("ncomment_number");
	
	var comment ={npost_number: npost_number_value, ncomment_number: ncomment_value, ncomment_writer: ncomment_writer_value} ;
	
	/* ncommentClsr.init(csrfTokenValue, csrfHeaderName) */
	
	ncommentClsr.removeCmtReply(
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