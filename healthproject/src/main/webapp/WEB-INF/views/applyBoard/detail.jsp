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


<style>
body {
    background-color: #f0f0f0; /* 원하는 색상으로 변경하세요. */
}
.txtBoxCmt, .txtBoxComment {
	overflow: hidden; resize: vertical; min-height: 100px; color: black;
}
textarea[readonly] {
    background-color: white !important;
}
#acontent {
    overflow: hidden; !important;
    font-size: 17px;
}
</style>

    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-8">
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<div class="row">
						<div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
							<strong style="font-size:16px; color:#000000">${applyBoard.awriter}님 작성</strong>
						</div>
						<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
							<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px; ">
								<span>
									<span>등록일:&nbsp;</span>
									<strong style="color:#000000;"><fmt:formatDate 
												pattern="yyyy-MM-dd HH:mm:ss"
												value="${applyBoard.aregister_date}"
											 /></strong>
									<span>&nbsp;&nbsp;</span>
								</span>
								<span>조회수:&nbsp;<strong style="color:#000000;"><c:out value="${applyBoard.aview_count}"/></strong>
								</span>
							</span>
						</div>
						<div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
							<div class="button-group pull-right">
							
			<sec:authorize access="isAuthenticated()" >
				<sec:authentication property="principal" var="principal"/>
					<c:if test="${principal.username eq applyBoard.awriter}">
							<button type="button" id="btnToModify" data-oper="modify"
									class="btn btn-primary btn-sm"><span>수정</span></button>
					</c:if>
			</sec:authorize>
									
							<button type="button" id="btnToList" data-oper="list"
									class="btn btn-primary btn-sm"><span>목록</span></button>
							</div>
						</div>
					</div>
                </div><!-- /.panel-heading --><%-- /.panel-heading --%>
                
<div class="panel-body">
    <div class="form-group">
        <h1 id="atitle">${applyBoard.atitle}</h1>
        <hr>
        </div>
        <div class="form-group">
            <div class="content-field">
               <textarea class="form-control" rows="5" name="acontent" id="acontent"
                          readonly="readonly">${applyBoard.acontent}</textarea>
            </div>
            </div>
             </div>
					
						
                </div><%-- /.panel-body --%>
            </div><%-- /.panel --%>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>

<%-- 첨부파일 표시 --%>
<div class="row" style="display: flex; justify-content: center;">
	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">첨부파일</div>
			<div class="panel-body">
				<div class="form-group fileUploadResult">
					<ul>
					<%-- 업로드 후, 업로드 처리결과가 표시될 영역 --%>
					</ul>
				</div>
			</div><%-- /.panel-body --%>
		</div><%-- /.panel --%>
	</div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>

<%-- Modal:첨부파일 이미지 표시 --%>
<div class="modal fade " id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
            	<%-- 이미지표시 --%>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal --%>

<form id="frmSendValue">
	<input type="hidden" name="pageNum" value="${boardPaging.pageNum }" >
	<input type="hidden" name="rowAmountPerPage" value="${boardPaging.rowAmountPerPage }" >
	<input type="hidden" name="scope" value="${boardPaging.scope }" >
	<input type="hidden" name="keyword" value="${boardPaging.keyword }" >
	<input type="hidden" name="startDate" value="${boardPaging.beginDate }" >
	<input type="hidden" name="endDate" value="${boardPaging.endDate }" >
</form>

<script>
window.onload = function() {
    var textArea = document.querySelector('#acontent');
    textArea.style.height = 'auto';
    textArea.style.height = textArea.scrollHeight + 'px';
}

var frmModify = $("#frmModify");
var frmSendValue = $("#frmSendValue") ;


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

<%-- 첨부파일 처리 JS --%>
//업로드 후, 첨부파일 정보 표시 함수
function showUploadedFiles(uploadResult) {
	console.log("showUploadedFiles 실행: 화면 표시 시작=======================================");
	
	//서버로부터 전달된 파일업로드 결과내용이 없으면, 함수 종료.
	if(!uploadResult || uploadResult.length == 0){
		return ;
	}
	
	var fileUploadResult = $(".fileUploadResult ul");
	var str = "";
	
	//전달받은 배열형식 데이터 각각에 대하여
	$(uploadResult).each(function(i, obj) {
		if (obj.fileType=="F") { 
			//이미지가 아닌 경우, 아이콘 이미지 및 원본 파일이름 표시
			str += "<li data-repopath='" + obj.repoPath + "'"
					+ " data-uploadpath='" + obj.uploadPath + "'"
					+ " data-uuid='" + obj.uuid + "'"
					+ " data-filename='" + obj.fileName + "'"
					+ " data-filetype='" + obj.fileType + "' >"
					+ " 	<img src='${contextPath}/resources/img/icon-attach.png' alt='No Icon' "
					+ " 		style='height: 50px; width: 50px;'>"
					+ 		  obj.fileName
					+ "</li>";
		} else if (obj.fileType=="I") {//이미지파일인 경우 썸네일 및 원본 파일이름 표시
			//전체 경로명이 포함된 썸네일 파일이름을 encodeURIComponent로 처리
			var thumbnailFilePath =
					encodeURIComponent(obj.repoPath + "/" + obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			console.log("encodeURIComponent 처리 파일이름: " + thumbnailFilePath);

				//원본이미지 파일이름(경로포함)
				str +="<li data-repopath='" + obj.repoPath + "'"
					+ " data-uploadpath='" + obj.uploadPath + "'"
					+ " data-uuid='" + obj.uuid + "'"
					+ " data-filename='" + obj.fileName + "'"
					+ " data-filetype='" + obj.fileType + "' >"
					+ " 	<img src='${contextPath}/displayThumbnailFile?fileName=" + thumbnailFilePath + "'"
					+ " 		alt='No Icon' style='height: 20px; width: 20px;'>"
					+ 		  obj.fileName
					+ "</li>";
		}
	});
	//기존 페이지에 첨부파일 정보 표시를 HTML로 추가
	fileUploadResult.html(str);
}

//첨부파일 li 클릭 이벤트 처리: 첨부파일 다운로드//원본 이미지 표시(새로 추가)
$(".fileUploadResult ul").on("click","li", function(e){
	
	var objLi = $(this);
	
	var downloadedPathFileName = encodeURIComponent(objLi.data("repopath") + "/" + objLi.data("uploadpath") + "/" +
													objLi.data("uuid")+"_" + objLi.data("filename"));
	
	if(objLi.data("filetype") == "I"){
		//이미지파일일 경우, 원본이미지를 다운로드 하여 결과표시 영역에 표시
		$(".modal-body").html("<img src='${contextPath}/fileDownloadAjax?fileName=" +
										   downloadedPathFileName.replace(new RegExp(/\\/g),"/") + "'" +
							  "		width='100%' height='100%' >");
		
		$("#yourModal").modal("show");
		
	} else { // else if(objLi.data("filetype") == "F") {
		//이미지가 이닐 경우, 다운로드 수행
		self.location ="${contextPath}/fileDownloadAjax?fileName=" + downloadedPathFileName ;
	}
});

//이미지 표시 모달 감추기
$(".modal").on("click", function(e){
		$(".modal").modal("hide");
});

var apost_number_value = '<c:out value="${applyBoard.apost_number}"/>'; 

<%-- 제일 아래 --%>
$(document).ready(function(){
	//첨부파일 정보를 가져오는 Ajax.
	$.ajax({
		type:'get',
		url: '${contextPath}/applyBoard/getFiles',
		data: {apost_number: apost_number_value}, 
		dataType: 'json',
		success: function(fileList, status){
			console.log("첨부파일 목록 수집: " + status);
			showUploadedFiles(fileList);
		}
	}); //ajax end
	
});



</script>
<%@include file="../myinclude/myfooter.jsp" %>  


