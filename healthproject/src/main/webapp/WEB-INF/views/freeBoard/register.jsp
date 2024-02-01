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
                	<h4>게시글 등록</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<form role="form" action="${contextPath}/freeBoard/register" method="post" name="frmBoard">
						<div class="form-group">
							<label>제목</label> <input class="form-control" name="ftitle">
						</div>
						<div class="form-group">
						    <label>이미지/영상 URL</label>
						    <input class="form-control" name="free_media_url" placeholder="예시: https://youtube.com/watch?v=[비디오ID] or https://youtube.com/shorts/[비디오ID]"/>
						</div>
						<div class="form-group">
							<label>내용</label> <textarea class="form-control" rows="15" name="fcontent" placeholder="상업성 광고, 저작권 침해, 명예훼손, 정치적 종교적 글, 그 외 기타 공익을 저해하거나 운영 취지에 맞지 않는 게시글은 통보없이 삭제될 수 있습니다."></textarea>
						</div>
						<div class="form-group">
							<label>작성자</label> 
							<input class="form-control" name="fwriter" value="<sec:authentication property="name" />" readonly>
						</div>
							<button type="submit" class="btn btn-primary btn-sm">등록</button>
							<button type="button" class="btn btn-warning btn-sm" data-oper="list"
									onclick="location.href='${contextPath}/freeBoard/list'">취소
							</button>
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