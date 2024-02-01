<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

    <div class="row" style="display: flex; justify-content: center;">
        <div class="col-lg-8" >
        
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>게시글 등록</h4>
				</div><%-- /.panel-heading --%>
                
                <div class="panel-body">
					<form role="form" action="${contextPath}/applyBoard/register" method="post" name="frmBoard">
						<div class="form-group">
							<label>제목</label> <input class="form-control" name="atitle">
						</div>
						<div class="form-group">
							<label>내용</label> <textarea class="form-control" rows="15" name="acontent"></textarea>
						</div>
						<div class="form-group">
							<label>작성자</label> 
							<input class="form-control" name="awriter" value="<sec:authentication property="name" />" readonly>
						</div>
							<button type="submit" class="btn btn-primary btn-sm" id="btnRegister">등록</button>
							<button type="button" class="btn btn-warning btn-sm" data-oper="list"
									onclick="location.href='${contextPath}/applyBoard/list'">취소
							</button>
							
						<sec:csrfInput/>
					</form>

          </div><%-- /.panel-body --%>           
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>
  
<%-- 첨부파일 결과 표시 --%>
<div class="row" style="display: flex; justify-content: center;">
	<div class="col-lg-8">
		<div class="panel panel-default">
			<div class="panel-heading">파일첨부</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input id="inputFile" type="file" name="uploadFiles" multiple><br>
				</div>
				<div class="form-group fileUploadResult">
					<ul>
					<%-- 업로드 후, 업로드 처리결과가 표시될 영역 --%>
					</ul>
				</div>
			</div><%-- /.panel-body --%>
		</div><%-- /.panel --%>
	</div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>


<script>

<%--첨부파일 처리 구현 시 수정된 입력값 확인 함수--%>
 function checkBoardValues(){
	 
	var frmBoard = document.frmBoard;
	var atitle=frmBoard.atitle.value;
	var acontent=frmBoard.acontent.value;
	var awriter=frmBoard.awriter.value;
	
	if( (atitle.length==0 ||atitle=="") ||
		(acontent.length==0 ||acontent=="") ||
		(awriter.length==0 ||awriter=="") ){
		
	return false;

	} else {
		return true;
	}
} 

//업로드 파일의 확장자 및 최대 파일 크기 검사 함수
function checkUploadfile(fileName, fileSize) {
 	// 확장자에 대한 정규식 및 최대 허용크기(100MB) 저장변수
 	var maxSizeAllowed = 104857600;
 	var regExpForFileExtention = /(.*)\.(exe|sh|zip|alz)$/i ;
 	
 	//최대 허용 크기 제한 검사
 	if (fileSize >= maxSizeAllowed) {
 		alert("업로드 파일의 제한된 크기(100MB)를 초과했습니다.");
 		return false;
 	}
 	
 	//업로드파일의 확장자 검사:
 	if (regExpForFileExtention.test(fileName)) {
 		alert("해당 종류(exe/sh/zip/alz)의 파일은 업로드할 수 없습니다.");
 		return false;
 	}
 	return true;
 }
 
 
var apost_number_value = '<c:out value="${applyBoard.apost_number}"/>';

//업로드 후, 첨부파일 정보 표시 함수
function showUploadedFiles(uploadResult) {
	console.log("showUploadedFiles 실행: 화면 표시 시작=======================================");
	
	if(!uploadResult || uploadResult.length == 0){ //첨부파일이 없으면, 함수 종료.
		return ;
	}
	
	//화면표시 시작
	var fileUploadResult = $(".fileUploadResult ul");
	var str = "";
	
	$(uploadResult).each(function(i, obj) {
		if (obj.fileType=="F") { //이미지가 아닌 경우, 아이콘 이미지 및 원본 파일이름 표시
			var calledPathFileName = encodeURIComponent( obj.repoPath + "/" + obj.uploadPath + "/" +
														 obj.uuid + "_" + obj.fileName);
			console.log("호출된 파일이름: " + calledPathFileName);
			
			str +="<li data-uploadpath='" + obj.uploadPath + "'"
				+ "		data-uuid='" + obj.uuid + "'"
				+ "		data-filename='" + obj.fileName + "'"
				+ "		data-filetype='F' >"
				+ " 	<img src='${contextPath}/resources/img/icon-attach.png'"
				+ " 		 alt='No Icon' style='height: 18px; width: 18px;'>"
				+ 		obj.fileName
				+ " 	<span data-filename='" + calledPathFileName + "' data-filetype='F'>[삭제]</span>"
				+ "</li>";
				
		} else if (obj.fileType=="I") { //이미지파일인 경우 썸네일 및 원본 파일이름 표시
			
			//encodeURIComponent로 처리된 전체 경로명이 포함된 썸네일 파일이름
			var thumbnailFilePath =
					encodeURIComponent(obj.repoPath + "/" + obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			console.log("encodeURIComponent 처리 파일이름: " + thumbnailFilePath);
						
		str += "<li data-uploadpath='" + obj.uploadPath + "'"
			+ " 	data-uuid='" + obj.uuid + "'"
			+ " 	data-filename='" + obj.fileName + "'"
			+ " 	data-filetype='I' >" 
			+ " 	<img src='${contextPath}/displayThumbnailFile?fileName=" + thumbnailFilePath + "'"
			+ " 		alt='No Icon' style='height: 18px; width: 18px;'>"
			+ 		  obj.fileName
			+ " 	<span data-filename='" + thumbnailFilePath + "' data-filetype='I'>[삭제]</span>"
			+ "</li>";
		}
	});
	
	fileUploadResult.append(str);
}

//input 초기화를 위해 비어있는 input 요소를 복사해서 저장함.
var cloneInputFile = $(".uploadDiv").clone() ; //<-- 파일업로드 처리 함수위에 추가
console.log("cloneInputFile: " + cloneInputFile.html()); //복사된 input 요소 확인

//파일 업로드 처리
$(".uploadDiv").on("change", "input[type='file']", function(e) { //수정
	
	var formData = new FormData(); //전송될 파일을 저장할 객체
	
	var inputFiles = $("input[name='uploadFiles']"); 
	
	var files = inputFiles[0].files;	
	console.log(files);
	
	//formdata 객체에 파일추가
	for(var i = 0; i < files.length ; i++) {
		
		if (!checkUploadfile(files[i].name, files[i].size)) { //업로드 파일 요구조건 검사
		 return false; //검사를 만족하지 못하면 false를 반환하고 파일업로드 중지
		}
		
		//uploadFiles 파라미터로 file 정보 추가
		formData.append("uploadFiles", files[i]);
	}
	
	//url 키에 명시된 주소의 컨트롤러에게 formData 객체를 POST 방식으로 전송.
	$.ajax({ //파일 전송 및 서버로부터 첨부파일 데이터를 받아, 화면 결과 표시
		type: 'post',
		url: '${contextPath}/fileUploadAjaxAction',
		processData: false, //contentType에 설정된 형식으로 data를 처리하지 않음.
		contentType: false, //contentType에 MIME 타입을 지정하지 않음.
		data: formData,
		dataType: 'json', //수정
		success: function(uploadResult, status){
				alert("첨부파일의 업로드 완료: " + status);
				$(".uploadDiv").html(cloneInputFile.html()); //파일이름이 선택된 기존 input을 초기화
				showUploadedFiles(uploadResult);
		}
	})
});

//파일 삭제:이벤트 위임을 이용하여, 서버의 파일 삭제 및 브라우저 항목 삭제.
$(".fileUploadResult").on("click","span", function(e){
	//this: span
	var targetFileName = $(this).data("filename");
	var targetFileType = $(this).data("filetype");
	
	//span이 포함된 li 변수에 저장
	var parentLi = $(this).parent();
	
	$.ajax({
		type: 'post',
		url: '${contextPath}/deleteUploadedFile',
		data: {fileName: targetFileName, fileType: targetFileType},
		dataType:'text',
		success: function(result){
			if (result == "SuccessDeletingFile"){
				alert("파일이 삭제되었습니다.");
				
				parentLi.remove();
				
			} else {
				alert("오류: 파일 삭제 실패.");
			}
		}
	}); //End $.ajax
});

//게시물 등록: 첨부파일 포함
$("#btnRegister").on("click", function(){
	
 	if (!checkBoardValues()){
		alert("글제목/글내용/작성자를 모두 입력해야 합니다.");
		return ;
	} 
	
 	var formObj = $("form[role='form']");
 	var strInputHidden = "";
 	
 	//업로드 결과의 li 요소 각각에 대하여 다음을 처리(이벤트 위임 이용)
 	$(".fileUploadResult ul li").each(function(i, obj){
 		var objLi = $(obj);
 		//name 속성 값은 MyBoardVO의 첨부파일 목록이 저장되는 attachFileList 필드명(List 객체)으로 지정합니다.
 		strInputHidden
 			+=" <input type='hidden' name='attachFileList["+i+"].uuid' value='"+objLi.data("uuid")+"'>"
 			+ " <input type='hidden' name='attachFileList["+i+"].uploadPath' value='"+objLi.data("uploadpath")+"'>"
 			+ " <input type='hidden' name='attachFileList["+i+"].fileName' value='"+objLi.data("filename")+"'>"
 			+ " <input type='hidden' name='attachFileList["+i+"].fileType' value='"+ objLi.data("filetype")+"'>" ;
 	});
 	
 	console.log(strInputHidden);
 	formObj.append(strInputHidden);
    formObj.attr("method", "post");
 	formObj.attr("action", "${contextPath}/applyBoard/register");  
 	
 	formObj.submit();
})



</script>



<%@include file="../myinclude/myfooter.jsp" %>    