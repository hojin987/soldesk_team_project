<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%@include file="../myinclude/myheader.jsp"%>

	<div class="row" style="display: flex; justify-content: center;">
		<div class="col-lg-8">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>회원가입</h4>
				</div>
				<%-- /.panel-heading --%>

				<div class="panel-body">
					<form role="form" action="${contextPath}/member/memberRegister"
						method="post" name="frmBoard">
						<!-- 아이디 체크: 영문 대소문자로 시작하는 영문, 숫자 조합의 6~20자 -->
						<div class="form-group">
							<label>아이디</label> <input class="form-control" name="member_id"
								pattern="^[a-zA-Z][a-zA-Z0-9]{5,19}$"
								title="영문 대소문자로 시작하는 영문, 숫자 조합의 6~20자로 입력해주세요."
								placeholder="영문 대소문자로 시작하는 영문, 숫자 조합의 6~20자">
						</div>

						<!-- 비밀번호 체크: 8 ~ 20자 영문 대소문자, 숫자, 특수문자 조합(영문, 숫자 최소 한가지씩 조합) -->
						<div class="form-group">
							<label>비밀번호</label> <input class="form-control" name="member_pw"
								pattern="^(?=.*[a-zA-Z])(?=.*\d)(?=.*[~`!@#$%\^&*()-]).{8,20}$"
								title="8~20자의 영문 대소문자, 숫자, 특수문자 조합으로 입력해주세요."
								placeholder="8~20자의 영문 대소문자, 숫자, 특수문자 조합">
						</div>

						<!--  이메일 체크 -->
						<div class="form-group">
							<label for="member_email">이메일</label> <input type="email"
								class="form-control" id="member_email" name="member_email"
								pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$"
								title="예시: example@example.com"
								placeholder="예시: example@example.com">
						</div>


						<!-- 핸드폰 번호 체크 -->
						<div class="form-group">
							<label>연락처</label> <input class="form-control"
								name="member_phonenumber"
								pattern="^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$"
								title="핸드폰 번호 형식에 맞게 입력해주세요." placeholder="예시: 000-0000-0000">
						</div>

						<!-- 이름 한글만 -->
						<div class="form-group">
							<label>이름</label> <input class="form-control" name="member_name"
								pattern="^[가-힣]*$" title="한글만 입력해주세요.">
						</div>

						<!-- 생일은 YYYY-MM-DD 형식 -->
						<div class="form-group">
							<label>생년월일</label> <input class="form-control"
								name="member_birth"
								pattern="^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$"
								title="YYYY-MM-DD 형식으로 입력해주세요."
								placeholder="YYYY-MM-DD 형식으로 입력해주세요.">
						</div>

						<!-- 키, 몸무게, 골격근량, 체지방률은 숫자만 -->
						<div class="form-group">
							<label>키</label> <input class="form-control" name="member_height"
								pattern="^[0-9]*$" title="숫자만 입력해주세요." placeholder="숫자만 입력해주세요.">
						</div>
						<div class="form-group">
							<label>몸무게</label> <input class="form-control"
								name="member_weight" pattern="^[0-9]*$" title="숫자만 입력해주세요."
								placeholder="숫자만 입력해주세요.">
						</div>
						<div class="form-group">
							<label>골격근량</label> <input class="form-control"
								name="member_muscle_percent" pattern="^[0-9]*$"
								title="숫자만 입력해주세요." placeholder="숫자만 입력해주세요.">
						</div>
							<div class="form-group">
							<label>체지방률</label> <input class="form-control"
								name="member_fat_percent" pattern="^[0-9]*$" 
								title="숫자만 입력해주세요."
								placeholder="숫자만 입력해주세요.">
						</div>
						<div class="form-group">
							<label>가입한 회원권</label> <select class="form-control"
								name="ticket_number">
								<option value="Ticket1" selected>헬스 플랜 3개월</option>
								<option value="Ticket2">헬스 플랜 6개월</option>
								<option value="Ticket3">헬스 플랜 12개월</option>
								<option value="Ticket4">pt 10회권</option>
								<option value="Ticket5">pt 20회권</option>
								<option value="Ticket6">pt 30회권</option>
							</select>
						</div>

						<div class="form-group">
							<label>목표</label> <select class="form-control" name="member_goal">
								<option value="체력개선" selected>체력개선</option>
								<option value="체형교정">체형교정</option>
								<option value="근육량 증가">근육량 증가</option>
							</select>
						</div>
						<div>
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }" />
						</div>
						<button type="submit" class="btn btn-primary btn-sm">등록</button>
						<button type="button" class="btn btn-warning btn-sm" data-oper="list"
							onclick="location.href='${contextPath}/noticeBoard/list'">취소
						</button>
					</form>

				</div>
				<%-- /.panel-body --%>

			</div>
			<%-- /.panel --%>
		</div>
		<%-- /.col-lg-12 --%>
	</div>
	<%-- /.row --%>


</div>
<%-- /#page-wrapper --%>

<%-- Modal --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog"
	aria-labelledby="yourModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="yourModalLabel">Modal title</h4>
			</div>
			<div class="modal-body" id="yourModal-body">메시지</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
			</div>
		</div>
		<%-- /.modal-content --%>
	</div>
	<%-- /.modal-dialog --%>
</div>
<%-- /.modal --%>


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

<%@include file="../myinclude/myfooter.jsp"%>
