 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  



<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">member - modify</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>경력 수정하기</h4>
				</div><%-- /.panel-heading --%>
                <form role="form" method="post" name="frmModify" id="frmModify"> 
				    <div class="panel-body">
				        <c:forEach items="${trainerRecord}" var="trainerRecord">
				            <div class="form-group">
				                <input type="hidden" name="member_id" value="${trainerRecord.member_id}"/>
				            </div>    
				            <div class="form-group">   
				                <label>경력</label>
				                <input class="form-control" name="trainer_record" value='<c:out value="${trainerRecord.trainer_record}"/>'/>
				            </div>    
				            <div class="form-group">    
				                <label>경력 취득일</label>
				                <input class="form-control" name="trainer_record_get_date" value='<c:out value="${trainerRecord.trainer_record_get_date}"/>'/>
				            </div>
				        </c:forEach>
				        
				        <sec:csrfInput/>
				        
				        <button type="button" class="btn btn-default" id="btnModify" data-oper="modify">수정</button>
				        <button type="button" class="btn btn-info" id="btnList" data-oper="list">취소</button>
				    </div>
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

var frmModify = $("#frmModify");

	$('button').on("click", function(e){ 
	
	var operation = $(this).data("oper");
	 
	if(operation == "modify"){ 
		frmModify.attr("action", "${contextPath}/member/recordModify");
		
	} else if(operation == "list"){
		frmModify.attr("action", "${contextPath}/member/trainer");
		frmModify.empty();
	}
	
	frmModify.submit() ; //요청 전송

})

</script>

<%-- var csrfHeader = "${_csrf.headerName}"
var csrfToken = "${_csrf.token}"
	
$(document).ready(function () {
    // 수정 버튼 클릭 시 이벤트 처리
    $("#btnModify").click(function () {

    	var formData = {};
        $("#frmModify").find(":input").each(function () {
            formData[$(this).attr("name")] = $(this).val();
        });

        // JSON 데이터를 서버로 전송 (POST 방식)
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "${contextPath}/member/recordModify",
            data: JSON.stringify(formData),
            dataType: 'json',
            beforeSend: function (xhr) {
                if (xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            },
            success: function (response) {
                // 성공적으로 처리된 경우의 동작
                console.log(response);
                // 원하는 동작 수행
            },
            error: function (error) {
                // 에러 발생 시 동작
                console.log(error);
                // 원하는 에러 처리 수행
            }
        });
    });
}); */ --%>

<%@include file="../myinclude/myfooter.jsp" %>  