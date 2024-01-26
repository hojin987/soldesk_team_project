<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%@include file="../myinclude/myheader.jsp" %>  

<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h3 class="page-header">채용게시판 수정</h3>
        </div><%-- /.col-lg-12 --%>
    </div><%-- /.row --%>
    
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                	<h4>게시글 수정 - 삭제 </h4>
				</div><%-- /.panel-heading --%>
                <div class="panel-body">
                
                <form role="form" id="frmModify" method="post" name="frmBoard" >
                
					<div class="form-group">
						<label>글번호</label>
							<input class="form-control" name="apost_number" value='<c:out value="${applyBoard.apost_number}"/>'
								   readonly="readonly" />
					</div>
					<div class="form-group">
						<label>글제목</label>
							<input class="form-control" name="atitle" value='<c:out value="${applyBoard.atitle}"/>'/>
					</div>
					<div class="form-group">
						<label>글내용</label>
						<%-- <textarea>와 </textarea>는 사이에 공백이 없어야 데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
						<textarea class="form-control" rows="3" name="acontent"
								><c:out value="${applyBoard.acontent}"/></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label>
							<input class="form-control" name="awriter" value='<c:out value="${applyBoard.awriter}"/>'
								   readonly="readonly"/>
					</div>
						
					<button type="button" class="btn btn-default btn-frmModify" id="btnModify" data-oper="modify">수정</button>
 					<button type="button" class="btn btn-danger btn-frmModify" id="btnRemove" data-oper="remove">삭제</button>
 					<button type="button" class="btn btn-info btn-frmModify" id="btnList" data-oper="list">취소</button>
 				<sec:csrfInput/>
		  </form>
          </div><%-- /.panel-body --%>
            
        </div><%-- /.panel --%>
    </div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>
  
<%-- 첨부파일 표시 --%>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">파일첨부</div>
			<div class="panel-body" >
				<div class="form-group uploadDiv">
					<input id="inputFile" type="file" name="uploadFiles" multiple><br>
				</div>
				<div class="form-group fileUploadResult">
					<ul>
					<!-- 업로드 후 결과처리 로직이 표시될 영역 -->
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
//form의 수정/삭제/목록보기 버튼 클릭 에벤트 처리
var frmModify = $("#frmModify");

$('.btn-frmModify').on("click", function(e){ 
//e.preventDefault(); //버튼 유형이 submit가 아니므로 설정할 필요 없음

	var operation = $(this).data("oper"); //각 버튼의 data-xxx 속성에 설정된 값을 저장
	//alert("operation: "+ operation);
 
	if(operation == "modify"){ //게시물 수정 요청
		
		var strFilesInputHidden = ""; 
		//업로드 결과의 li 요소 선택하여 각각에 대하여 다음을 처리
		$(".fileUploadResult ul li").each(function(i, obj){
			var objLi = $(obj);
			strFilesInputHidden
				+= " <input type='hidden' name='attachFileList["+i+"].uuid' "
				+ " 		value='" + objLi.data("uuid") + "'>"
				+ " <input type='hidden' name='attachFileList["+i+"].uploadPath' "
				+ " 		value='" + objLi.data("uploadpath") + "'>"
				+ " <input type='hidden' name='attachFileList["+i+"].fileName' "
				+ " 		value='" + objLi.data("filename") + "'>"
				+ " <input type='hidden' name='attachFileList["+i+"].fileType' "
				+ " 		value='" + objLi.data("filetype") + "'>" ;
		});
		console.log(strFilesInputHidden);//테스트 후, 주석
		frmModify.append(strFilesInputHidden);
		
		frmModify.attr("action", "${contextPath}/applyBoard/modify");
	
	} else if(operation == "remove"){ //게시물 삭제 요청
		
		frmModify.attr("action", "${contextPath}/applyBoard/remove");
	
	} else if(operation == "list"){ //게시물 목록 화면 요청
		
		frmModify.attr("action","${contextPath}/applyBoard/list").attr("method","get");
		frmModify.empty();
}
 
frmModify.submit() ; //요청 전송
});

</script>

<script><%-- 첨부파일 표시 처리 --%>

var apost_number_value = '<c:out value="${applyBoard.apost_number}"/>'; 

<%-- 첨부파일 정보 표시 함수 --%>
function showUploadedFiles(uploadResult) {
	
	if(!uploadResult || uploadResult.length == 0){
		return ;
	}
	
	var fileUploadResult = $(".fileUploadResult ul");
	var str = "";
	
	$(uploadResult).each(function(i, obj) {
		if (obj.fileType=="F") { //이미지가 아닌 경우
			
		//encodeURIComponent로 처리된 첨부파일(전체 경로 포함, 삭제 시 필요):
			var calledPathFileName = encodeURIComponent(obj.repoPath + "/" + obj.uploadPath + "/" +
														obj.uuid + "_" + obj.fileName);
			console.log("전체 경로포함 파일이름: " + calledPathFileName);
			
			//아이콘 이미지 및 uuid 없는 파일이름 표시
			str +=" <li data-repopath='" + obj.repoPath + "' data-uploadpath='" + obj.uploadPath + "'"
				+ " 	data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'"
				+ " 	data-filetype='F' style='height: 50px;'>" 
				+ " 	<img src='${contextPath}/resources/img/icon-attach.png' alt='No Icon' "
				+ " 		style='height: 50px; width: 50px;'>&nbsp;&nbsp;" 
				+ 		obj.fileName
				+ " 	&nbsp;<button type='button' class='btn btn-danger btn-xs' "
				+ " 				  data-filename='" + calledPathFileName + "' data-filetype='F'>X</button>"
				+ " </li>";
				
		} else if (obj.fileType=="I") { //이미지파일인 경우
			
		//encodeURIComponent로 처리된 썸네일파일(전체 경로 포함):
			var thumbnailFilePath =
					encodeURIComponent(obj.repoPath + "/" + obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			console.log("encodeURIComponent 처리된 썸네일이름: " + thumbnailFilePath);
			
			//업로드 된 파일이름(uuid 포함된 이름, 삭제 시 필요)
			//썸네일 및 uuid 없는 파일이름 표시
			str +=" <li data-repopath='" + obj.repoPath + "'"
				+ " 	data-uploadpath='" + obj.uploadPath + "'"
				+ " 	data-uuid='" + obj.uuid + "'"
				+ " 	data-filename='" + obj.fileName + "'"
				+ " 	data-filetype='I' style='height: 20px;' >" //수정
				+ " 	<img src='${contextPath}/displayThumbnailFile?fileName=" + thumbnailFilePath + "'"
				+ " 		alt='No Icon' style='height: 20px; width: 20px;'>&nbsp;&nbsp;" //추가
				+ 		obj.fileName
				+ "		&nbsp;<button type='button' class='btn btn-danger btn-xs'"
				+ " 				  data-filename='" + thumbnailFilePath + "' data-filetype='I'>X</button>"
				+ " </li>";
		}
	});
	
	fileUploadResult.append(str);
}


<%-- 업로드 파일의 확장자 및 최대 파일 크기 검사 함수 --%>
function checkUploadfile(fileName, fileSize) {
	// 확장자에 대한 정규식 및 최대 허용크기(10MB) 저장변수
	var maxSizeAllowed = 5242880;
	var regExpForFileExtention = /(.*)\.(exe|sh|zip|alz)$/i ;
	
	//최대 허용 크기 제한 검사
	if (fileSize >= maxSizeAllowed) {
		alert("업로드 파일의 제한된 크기(1MB)를 초과했습니다.");
		return false;
	}
	
	//업로드파일의 확장자 검사:
	if (regExpForFileExtention.test(fileName)) {
		alert("해당 종류(exe/sh/zip/alz)의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}

//input 초기화를 위해 div 요소의 비어있는 input 요소를 복사해서 저장함.
var cloneInputFile = $(".uploadDiv").clone() ; 

//파일업로드 처리
$(".uploadDiv").on("change", "input[type='file']", function(e) {
	//FormData() Ajax 파일 전송 시에 사용되는 Web API 클래스의 생성자
	var formData = new FormData();
	
	//선택된 input 요소를 변수에 저장
	var inputFiles = $(this);
	
	//inputFiles에 저장된 파일들을 files 변수에 저장
	var files = inputFiles[0].files;
	console.log(files);
	
	//formdata 객체에 파일추가
	for(var i = 0; i < files.length ; i++) {
		
		if (!checkUploadfile(files[i].name, files[i].size)) { //파일 확장자 및 최대크기검사 실행
		return false; //검사를 만족하지 못하면 false를 반환하고 파일업로드 중지
		}
		
		//uploadFiles 파라미터로 file 정보 추가
		formData.append("uploadFiles", files[i]);
	}
	
	//url 키에 명시된 주소의 컨트롤러에게 formData 객체를 POST 방식으로 전송.
	$.ajax({
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


<%-- 첨부 파일 삭제(수정화면): 브라우저 표시 항목만 삭제 --%>
$(".fileUploadResult").on("click","button", function(e){

	console.log("파일삭제(화면에서 항목만 삭제)");
	
	if (confirm("이 파일을 삭제하시겠습니까?")){
		var targetLi = $(this).closest("li");
		targetLi.remove();
		alert("파일이 삭제되었습니다")
	} else {
		alert("파일 삭제가 취소되었습니다.")
	}
});


<%-- 제일 아래 --%>
$(document).ready(function(){
	
	$.ajax({
		type: 'get',
		url: '${contextPath}/applyBoard/getFiles',
		data: {apost_number: apost_number_value}, 
		dataType: 'json',
		success: function(fileList, status){
			console.log("첨부파일 목록 수집: " + status);
			showUploadedFiles(fileList);
		}
	}) //ajax end
	
});


</script>



<%@include file="../myinclude/myfooter.jsp" %>    