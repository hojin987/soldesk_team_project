<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>


<%@include file="../myinclude/myheader.jsp" %>  

<style>
 th {text-align: center;}
</style>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header"
				style="white-space: nowrap;" >Board - Detail
				 <small>
				 	&nbsp;&nbsp;&nbsp;<c:out value="${applyBoard.apost_number}"/>번 게시물
				 </small>
			</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px;">${applyBoard.awriter}님 작성</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
								<span>
									<span>등록일:&nbsp;</span>
									<strong><fmt:formatDate 
												pattern="yyyy-MM-dd HH:mm:ss"
												value="${applyBoard.aregister_date}"
											 /></strong>
									<span>&nbsp;&nbsp;</span>
								</span>
								<span>조회수:&nbsp;<strong><c:out value="${applyBoard.aview_count}"/></strong>
								</span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
							
							<button type="button" id="btnToModify" data-oper="modify"
									class="btn btn-primary"><span>수정페이지로 이동</span></button>

									
							<button type="button" id="btnToList" data-oper="list"
									class="btn btn-warning"><span>목록페이지로 이동</span></button>
							</div>
						</div>
					</div>
                </div><!-- /.panel-heading --><%-- /.panel-heading --%>
                
                <div class="panel-body">

	
	<div class="form-group">
	    <label>글제목</label>
	    <input class="form-control" name="atitle" id="atitle" 
	    	   value="${applyBoard.atitle }" readonly="readonly">
	</div>
	<div class="form-group">
	    <label>글내용</label>
	    <textarea class="form-control" rows="3" name="acontent" id="acontent"
	    		  readonly="readonly">${applyBoard.acontent}</textarea>
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

<%-- 첨부파일 결과 표시 --%>    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">첨부 파일</div><!-- /.panel-heading -->
                <div class="panel-body"><!-- 
                    <div class="form-group uploadDiv">
                        <input id="inputFile" class="btn btn-primary inputFile" type="file" name="uploadFiles" multiple="multiple" /><br> 
                    </div>-->
	                <div class="form-group fileUploadResult">
	                    <ul>
<%-- 업로드 후 처리결과가 표시될 영역 --%>
<%-- <c:choose>
<c:when test="${empty noticeBoard.attachFileList }">
	<li>첨부파일이 없습니다.</li>
</c:when>
<c:otherwise>
	<c:forEach var="attachFile" items="${applyBoard.attachFileList}">
		<c:choose>
		<c:when test='${attachFile.fileType == "F"}'>
		<li class="attachLi" 
			data-repopath="${attachFile.repoPath}"
			data-uploadpath="${attachFile.uploadPath}"
		    data-uuid="${attachFile.uuid}"
		    data-filename="${attachFile.fileName }"
		    data-filetype="F">
		        <img src='${contextPath}/resources/img/icon-attach.png' style='width:25px;'>
		        &nbsp;&nbsp; ${attachFile.fileName}
		    </a>
		</li>
		</c:when>
		<c:otherwise>
		    <c:set var="thumbnail" value="${attachFile.repoPath}/${attachFile.uploadPath}/s_${attachFile.uuid}_${attachFile.fileName}"/>
		    <li class="attachLi" 
		    	data-repopath="${attachFile.repoPath}"
		        data-uploadpath = "${attachFile.uploadPath }" 
		        data-uuid = "${attachFile.uuid }" 
		        data-filename = "${attachFile.fileName }" 
		        data-filetype = "I" >
		            <img src='${contextPath}/displayThumbnail?fileName=${thumbnail}' style='width:25px;'>
		            &nbsp;&nbsp;${attachFile.fileName}
		        </a> 
		    </li>
		    <c:remove var="thumbnail"/>
		</c:otherwise>
		</c:choose>
	</c:forEach>
</c:otherwise>
</c:choose> --%>
                	</ul>
            	</div>
            </div><!-- /.panel-body -->
        </div><!-- /.panel -->
    </div><!-- /.col-lg-12 -->
</div><!-- /.row -->

<%-- Modal:첨부파일 이미지 표시 --%>
<div class="modal fade" id="attachModal" tabindex="-1" role="dialog" aria-labelledby="attachModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body" id="attachModal-body">
            	<%-- 이미지표시 --%>
            </div>
            
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>
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

var frmSendValue = $("#frmSendValue") ;

//게시물 목록 페이지 이동
$("#btnToList").on("click", function(){;

	frmSendValue.attr("action", "${contextPath}/applyBoard/list").attr("method", "get") ;
	frmSendValue.submit() ;
});

//게시물 수정-삭제 페이지 이동
$("#btnToModify").on("click", function(){
	
	var apost_number = '<c:out value="${applyBoard.apost_number}"/>' ;
	
	frmSendValue.append("<input type='hidden' name='apost_number' value='" + apost_number + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/applyBoard/modify").attr("method", "get") ;
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
