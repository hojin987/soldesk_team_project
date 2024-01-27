<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

    
    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-8"> 
            <div class="panel panel-default">
                <div class="panel-body">

<table class="table table-bordered " 
       style="margin:0 auto; width: 80%; text-align: center;">
    <tbody>
		<c:forEach items="${pagingCreator.memberList}" var="member">
		    <c:forEach items="${member.authorityList}" var="authority">
		        <c:if test="${authority.authority eq 'TRAINER'}">
		            <tr class="moveDetail" data-member_id="${member.member_id}">
		            	<td>이미지</td>
		            	<td style="text-align:left;">
		            		[<c:out value="강사" />] <c:out value="${member.member_name}"/><br>
		            		<c:forEach items="${trainerRecord}" var="record">
							    <c:if test="${member.member_id eq record.member_id}">
							        <span data-trainer-record="${record.trainer_record}">${record.trainer_record}</span>
							    </c:if>
					    	</c:forEach>
					    	<sec:authorize access="isAuthenticated()" >
 							<sec:authentication property="principal" var="principal"/>
						    	<c:if test="${principal.username eq member.member_id}">
				    				<button type="button" class="btn btn-sm pull-right btnToRegister">등록</button>
				    				<button type="button" class="btn btn-sm pull-right btnToModify">수정</button>
				    			</c:if>
			    			</sec:authorize>
			    		</td>
		            </tr>
		        </c:if>
		    </c:forEach>
		</c:forEach>
       </tbody>
   </table><%-- /.table-responsive --%>
                
<form id="frmSendValue">
</form>

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
$(".btnToRegister").on("click",function(){
	var member_id = $(this).closest("tr").data("member_id");
	window.location.href='${contextPath}/member/recordRegister?member_id='+member_id; 
});

//수정페이지 이동
$(".btnToModify").on("click",function(){
	var member_id = $(this).closest("tr").data("member_id");
	window.location.href='${contextPath}/member/recordModify?member_id='+member_id; 
});


$(document).ready(function() {
    $(".moveDetail").each(function() {
        var $td = $(this).find("td:last"); // 가장 마지막 td를 선택
        var trainerRecordValue = $td.find("[data-trainer-record]").data("trainer-record");

        if (trainerRecordValue) {
            $td.find(".btnToModify").show();
            $td.find(".btnToRegister").hide();
        } else {
            $td.find(".btnToModify").hide();
            $td.find(".btnToRegister").show();
        }
    });
});


</script> 

<%@include file="../myinclude/myfooter.jsp" %>    