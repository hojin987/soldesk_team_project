<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">Board - detail</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>게시글 상세 - <small>조회수: <c:out value="${noticeBoard.nview_count}"/></small></h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<div class="form-group">
						<label>글번호</label>
							<input class="form-control" name="npost_number" value='<c:out value="${noticeBoard.npost_number}"/>'
								   readonly="readonly" />
					</div>
					<div class="form-group">
						<label>글제목</label>
							<input class="form-control" name="ntitle" value='<c:out value="${noticeBoard.ntitle}"/>'
								   readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>글내용</label>
						<%-- <textarea>와 </textarea>는 사이에 공백이 없어야 데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
						<textarea class="form-control" rows="3" name="ncontent"
								  readonly="readonly"><c:out value="${noticeBoard.ncontent}"/></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
							<input class="form-control" name="nwriter" value='<c:out value="${noticeBoard.nwriter}"/>'
								   readonly="readonly"/>
					</div>
						
					<button type="button" class="btn btn-default" id="BtnMoveModify" data-oper="modify">수정</button>
					<button type="button" class="btn btn-info" id="BtnMoveList" data-oper="list">목록</button>

          </div><%-- /.panel-body --%>
            
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
//게시물 수정 페이지로 이동
$("#BtnMoveModify").on("click", function(){
 location.href='${contextPath}/noticeBoard/modify?npost_number=<c:out value="${noticeBoard.npost_number}"/>';
})
//게시물 목록 페이지로 이동
$("#BtnMoveList").on("click", function(){
 location.href="${contextPath}/noticeBoard/list";
})
</script>

<%@include file="../myinclude/myfooter.jsp" %>    