<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  
    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-8">
        
            <div class="panel panel-default">
            	<div class="panel-heading">
					<div class="row">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">운동 목록</div>
						<div class="col-md-6" style="padding-top:8px;">
							<sec:authorize access="hasAnyAuthority('ADMIN', 'TRAINER')">
								<button type="button" id="btnToRegister" class="btn btn-primary btn-sm pull-right">운동 등록</button>
							</sec:authorize>
						</div>
					</div>
				</div><%-- /.panel-heading --%>
                <div class="panel-body">

	<table class="table table-bordered " 
	       style="margin:0 auto; width: 100%; text-align: center;">
	    <tbody>
<style>
    .flex-container {
        display: flex;
        flex-wrap: wrap;
    }
    .flex-item {
        flex: 1 0 25%;
        box-sizing: border-box;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        border: 1px solid #cccccc; /* 셀 사이의 구분선 */
    }
    .image-container {
        border: 1px solid #cccccc; /* 이미지 칸과 그 외를 나누는 선 */
    }
</style>

<div class="flex-container">
    <c:forEach items="${workoutList}" var="workout" varStatus="loop">
        <div class="flex-item moveDetail" data-workout_code="${workout.workout_code}">
            <div class="image-container" style="font-size:20px; text-align:center;">
                <img src="${contextPath}/resources/images/${workout.workout_name}.jpg" style="height:200px;">
            </div>
            &nbsp; [<c:out value="${workout.workout_target}" />] <c:out value="${workout.workout_name}"/>
        </div>
        <c:if test="${(loop.index + 1) % 4 == 0}">
            <div style="flex-basis: 100%; height: 0;"></div> <!-- 줄바꿈 -->
        </c:if>
    </c:forEach>
</div>

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
//alert("result.length: " + result.length)

//등록페이지 이동
$("#btnToRegister").on("click",function(){
	window.location.href = "${contextPath}/workout/register" ; 
});

//상세페이지 이동
$(".moveDetail").on("click", function(){
	var workout_code = $(this).data("workout_code") ;
	
	frmSendValue.append("<input type='hidden' name='workout_code' value='" + workout_code + "'/>")
	frmSendValue.attr("action", "${contextPath}/workout/detail").attr("method", "get") ;
	frmSendValue.submit() ;
	frmSendValue.find('input[name="workout_code"]').remove() ;
});


</script> 

<%@include file="../myinclude/myfooter.jsp" %> 