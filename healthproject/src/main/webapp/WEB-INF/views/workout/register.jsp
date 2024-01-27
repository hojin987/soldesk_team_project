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
                	<h4>운동 등록</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<form role="form" action="${contextPath}/workout/register" method="post" name="frmBoard">
						<div class="form-group">
							<label>운동 번호</label> <input class="form-control" name="workout_code">
						</div>
						<div class="form-group">
							<label>운동 이름</label> <input class="form-control" name="workout_name">
						</div>
						<div class="form-group">
							<label>운동 방법</label> <input class="form-control" name="workout_content">
						</div>
						<div class="form-group">
							<label>운동 부위</label> <input class="form-control" name="workout_target">
						</div>
						<div class="form-group">
							<label>운동 주의사항</label> <input class="form-control" name="workout_warning">
						</div>
						<div class="form-group">
						    <label>이미지/영상 URL</label>
						    <input class="form-control" name="workout_media_url" placeholder="예시: https://youtube.com/watch?v=영상id 혹은 https://youtube.com/shorts/영상id"/>
						</div>
						<sec:csrfInput/>
						
							<button type="submit" class="btn btn-primary btn-sm">등록</button>
							<button type="button" class="btn btn-warning btn-sm" data-oper="list"
									onclick="location.href='${contextPath}/workout/list'">취소
							</button>
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


<%@include file="../myinclude/myfooter.jsp" %>    