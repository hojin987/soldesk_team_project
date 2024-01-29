<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>운동정보 상세 [<c:out value="${workout.workout_target}"/>]</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<div class="form-group">
						<label>운동 이름</label>
							<input class="form-control" name="workout_name" value='<c:out value="${workout.workout_name}"/>'
								   readonly="readonly" />
					</div>
					<div class="form-group">
						<label>운동 내용</label>
						<div class="workout-media">
							<c:if test="${workout != null and workout.workout_media_url != null}">
							   <c:choose>
							       <c:when test="${fn:contains(workout.workout_media_url, 'youtube.com')}">
							           <c:choose>
							               <c:when test="${fn:contains(workout.workout_media_url, 'shorts')}">
							                   <iframe width="560" height="315"
							                       src="https://www.youtube.com/embed/${fn:substringAfter(workout.workout_media_url, 'shorts/')}"
							                       allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
							               </c:when>
							               <c:otherwise>
							                   <iframe width="560" height="315"
							                       src="https://www.youtube.com/embed/${fn:substringAfter(workout.workout_media_url, 'v=')}"
							                       allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
							               </c:otherwise>
							           </c:choose>
							       </c:when>
							       <c:when test="${fn:contains(workout.workout_media_url, 'youtu.be')}">
							           <iframe width="560" height="315"
							               src="https://www.youtube.com/embed/${fn:substringAfter(workout.workout_media_url, 'be/')}"
							               allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
							       </c:when>
							   </c:choose>
							</c:if>

							<input class="form-control" name="workout_content" value='<c:out value="${workout.workout_content}"/>'
								   readonly="readonly"/>
						</div>
					</div>
					<div class="form-group">
						<label>운동 주의사항</label>
							<input class="form-control" name="workout_warning" value='<c:out value="${workout.workout_warning}"/>'
								   readonly="readonly"/>
					</div>
					<sec:authorize access="hasAnyAuthority('TRAINER', 'ADMIN')">	
						<button type="button" class="btn btn-primary btn-sm" id="BtnMoveModify" data-oper="modify">수정</button>
					</sec:authorize>
					<button type="button" class="btn btn-warning btn-sm" id="BtnMoveList" data-oper="list">목록</button>

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
//상품정보 수정-삭제 페이지로 이동
$("#BtnMoveModify").on("click", function(){
 location.href='${contextPath}/workout/modify?workout_code=<c:out value="${workout.workout_code}"/>';
})
//상품 목록 페이지로 이동
$("#BtnMoveList").on("click", function(){
 location.href="${contextPath}/workout/list";
})
</script>

<%@include file="../myinclude/myfooter.jsp" %>    