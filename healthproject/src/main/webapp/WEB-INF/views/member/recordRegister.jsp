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
                	<h4>경력 등록</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<form role="form" action="${contextPath}/member/recordRegister" method="post" name="frmBoard">
						<div id="experienceContainer">
						    <div class="form-group">
						        <input type="hidden" name="member_id" value="${param.member_id}">
						        <label>경력</label><br>
						        <textarea name="trainer_record" id="treainer_record" rows="4" style="width:100%"></textarea>
						    </div>
						</div>
						
						<button type="submit" class="btn btn-primary btn-sm">등록</button>
						<button type="button" class="btn btn-warning btn-sm" 
								onclick="location.href='${contextPath}/member/trainer'">취소</button>
								
						<sec:csrfInput/>
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