<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">자유게시판 - 게시물등록</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    <div class="row">
        <div class="col-lg-12">
        
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
							<label>내용</label> <textarea class="form-control" rows="3" name="fcontent"></textarea>
						</div>
						<div class="form-group">
							<label>작성자</label> <input class="form-control" name="fwriter">
						</div>
							<button type="submit" class="btn btn-primary">등록</button>
							<button type="button" class="btn btn-warning" data-oper="list"
									onclick="location.href='${contextPath}/freeBoard/list'">취소
							</button>
					</form>

          </div><%-- /.panel-body --%>
            
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>
  <%-- 첨부파일 결과 표시 --%>    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">파일첨부</div><!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="form-group uploadDiv">
                        <input id="inputFile" class="btn btn-primary inputFile" type="file" name="uploadFiles" multiple="multiple" /><br>
                    </div>
	                <div class="form-group fileUploadResult">
	                    <ul>
	                        <%-- 업로드 후 처리결과가 표시될 영역 --%>
	                    </ul>
	                </div>
                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->
  

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

<%-- 게시물 등록 시에 업로드 된 첨부파일 데이터들도  DB에 저장되도록 수정 --%> 
$("#btnRegister").on("click", function(){
	
	if (!checkBoardValues()){
		alert("글제목/글내용/작성자를 모두 입력해야 합니다.");
		return ;
	}
<%--	
	var frmBoard = document.getElementById("frmBoard") ; //제이쿼리 append() 동작 않됨, 자바스크립트 객체를 이용해서는 JQuery 메서드를 사용할 수 없습니다.
--%>
	var frmBoard = $("#frmBoard") ;
	var attachFileInputHTML = "";
	
	<%-- li요소의 값들을 읽어와서 hidden input을 생성하는 택스트를 만드는 함수 --%>
	<%--div.form-group.fileUploadResult > ul > li:nth-child(1)--%>
	$("div.fileUploadResult ul li").each(function(i, obj){
		
		var objLi = $(obj) ;

 		if(objLi == null){
			return ;
		} 
		
		attachFileInputHTML 
			+="<input type='hidden' name='attachFileList[" + i + "].uuid' value='" + objLi.data("uuid") + "'>" 
			+ "<input type='hidden' name='attachFileList[" + i + "].uploadPath' value='" + objLi.data("uploadpath") + "'>" 
			+ "<input type='hidden' name='attachFileList[" + i + "].fileName' value='" + objLi.data("filename") + "'>" 
			+ "<input type='hidden' name='attachFileList[" + i + "].fileType' value='" + objLi.data("filetype") + "'>" ;
	});<%--each-end--%>
	
	if (attachFileInputHTML != ""){
		frmBoard.append(attachFileInputHTML) ;	
	}

	frmBoard.submit();
	
});

</script>
<script>

<%--input 초기화: div 요소의 "비어있는 input 요소를 복사"해서 저장함.--%>
<%--
	var cloneFileInput = $(".uploadDiv").clone(); //clone(): 선택된 요소의 자식요소가 복사됨 
--%>
<%--복사된 것을 사용하는 경우, 첨부파일 삭제 및 추가 시에는, 동작하지 않음--%>

<%-- 업로드 파일에 대한 확장자 및 크기 제한 --%>
function checkUploadFile(fileName, fileSize) {
	
	var allowedMaxSize = 104857600 ;
	var regExpForbiddenFileExtension = /((\.(exe|dll|sh|c|zip|alz|tar)$)|^[^.]+$|(^\..{1,}$))/i ;
	
	if (fileSize > allowedMaxSize) {
		alert("업로드 파일의 제한된 크기(1MB)를 초과했습니다.") ;
		return false ;
	}

	if(regExpForbiddenFileExtension.test(fileName)){
		alert("확장명이 없거나 [exe,dll,sh,c,zip,alz,tar] 형식 파일들은\n업로드 할 수 없습니다.") ;
		return false ;
		
	}
	
	return true ;
}

function showUploadResult(uploadResult) {
	
	if(!uploadResult || uploadResult.length == 0) {
		return ;
	}
	
	var fileUploadResult = $(".fileUploadResult ul") ;
	var htmlStr = "";
	
	$(uploadResult).each(function(i, attachFile){
		
		var fullFileName = encodeURI(attachFile.repoPath + "/" +
									 attachFile.uploadPath + "/" +
									 attachFile.uuid + "_" +
									 attachFile.fileName ) ;
		
		if(attachFile.fileType == "F") {
			htmlStr 
			+="<li data-uploadpath='" + attachFile.uploadPath + "'" 
			+ "    data-uuid='" + attachFile.uuid + "'" 
			+ "    data-filename='" + attachFile.fileName + "'" 
			+ "    data-filetype='F'>"
//			+ "    <a href='${contextPath}/fileDownloadAjax?fileName=" + fullFileName +"'>"
			+ "        <img src='${contextPath}/resources/img/icon-attach.png' style='width:25px;'>"
			+ "        &nbsp;&nbsp;" + attachFile.fileName 
//			+ "    </a>"
			+  "  <span data-filename='" + fullFileName + "' data-filetype='F'>[삭제]</span>"
			+ "</li>" ;
			
		} else { //else if(attachFile.fileType == "I") {
			
			var thumbnail = encodeURI(attachFile.repoPath + "/" +
									  attachFile.uploadPath + "/s_" +
									  attachFile.uuid + "_" +
									  attachFile.fileName ) ;
			
		
			htmlStr 
			+="<li data-uploadpath='" + attachFile.uploadPath + "'" 
			+ "    data-uuid='" + attachFile.uuid + "'" 
			+ "    data-filename='" + attachFile.fileName + "'" 
			+ "    data-filetype='I'>"
//			+ "    <a href='${contextPath}/fileDownloadAjax?fileName=" + fullFileName +"'>" //다운로드
//			+ "    <a href=\"javascript:showImage('" + fullFileName + "')\">"
			+ "        <img src='${contextPath}/displayThumbnail?fileName=" + thumbnail + "'>"
			+ "        &nbsp;&nbsp;" + attachFile.fileName 
//			+ "    </a>"
			+  "  <span data-filename='" + thumbnail + "' data-filetype='I'>[삭제]</span>"
			+ "</li>" ;
		}
			
	}); <%--foreach-end--%>
	
	fileUploadResult.append(htmlStr) ;
	
}

var myCsrfHeaderName = "${_csrf.headerName}" ;
var myCsrfToken = "${_csrf.token}" ;

/* 
$(document).ajaxSend(function(e, xhr){
	xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken) ;
}); */
	
<%-- 업로드 처리 --%>
<%--파일 업로드 처리: 파일 input 요소의 "내용이 바뀌면" 업로드가 수행되도록 수정 --%>
$("#inputFile").on("change", function(){
	
	var formData = new FormData() ;
	
	var fileInputs = $("input[name='uploadFiles']") ;
	
	var yourFiles = fileInputs[0].files ;
	
	console.log(yourFiles) ;
	
	if(yourFiles == null || yourFiles.length == 0) {
		alert("파일을 선택하세요");
		return ;
	}
	
	<%--FormData() 객체에 input의 파일을 모두 저장함--%>
	for(var i = 0 ; i < yourFiles.length ; i++) {
		
		<%--업로드 파일의 파일 크기/확장자 제한 검사--%>
		if(!checkUploadFile(yourFiles[i].name, yourFiles[i].size)){
			console.log("파일이름: " + yourFiles[i].name) ;
			console.log("파일크기: " + yourFiles[i].size) ;
			return ;
		}
		
		formData.append("yourUploadFiles", yourFiles[i])
		
	}
	
<%--FormData() 객체(formData)를 서버로 전송(By Ajax)
	url 키에 명시된 주소의 컨트롤러에게 formData 객체를 POST 방식으로 전송.--%>
	$.ajax({
		type: "post" ,
		url: "${contextPath}/fileUploadAjaxAction" ,
		data: formData ,
		contentType: false , <%--contentType에 MIME 타입을 지정하지 않음.--%>
		processData: false , <%--contentType에 설정된 형식으로 data를 처리하지 않음. --%>
		dataType: "json" ,
		beforeSend: function(xhr){
			xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken)
		} ,
		success: function(uploadResult, status){
			
<%--		//복사된 file-input을 삽입하는 경우, 첨부파일 삭제/추가 시에는, 초기화 되지 않음.
			$(".uploadDiv").html(cloneFileInput.html()) ;
--%>			
			$(".inputFile").val("") ;
			
			showUploadResult(uploadResult);
		}
	});
	
}) ;


<%-- 업로드 파일 삭제: 서버에 업로드된 파일이 삭제되고, 이를 화면에 반영해 주어야 함 --%>
<%-- body > div.fileUploadResult > ul > li:nth-child(2) > span --%>
$(".fileUploadResult ul").on("click","li span", function(e){
	var fileName = $(this).data("filename") ;
	var fileType = $(this).data("filetype") ;
	
	var parentLi = $(this).parent() ;
	
	$.ajax({
		type: "post" ,
		url: "${contextPath}/deleteFile" ,
		data: {fileName: fileName, fileType: fileType} ,
		dataType: "text" , 
		beforeSend: function(xhr){
			xhr.setRequestHeader(myCsrfHeaderName, myCsrfToken) ;
		} ,
		success: function(result){
			if(result == "S") {
				alert("파일이 삭제되었습니다.") ;
				parentLi.remove() ;
				
			} else {
				if(confirm("파일이 존재하지 않습니다. 해당 항목을 삭제하시겠습니까 ?") ) {
					parentLi.remove() ;
					alert("파일이 삭제되었습니다.") ;	
				
				}
			}
		} <%--success-end--%>
		
	});  <%--ajax-end--%>
	
});


</script>

<%@include file="../myinclude/myfooter.jsp" %>    