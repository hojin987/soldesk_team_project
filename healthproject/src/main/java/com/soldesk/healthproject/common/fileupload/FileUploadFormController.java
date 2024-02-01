package com.soldesk.healthproject.common.fileupload;

import java.io.File;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadFormController {
	private static final Logger log = LoggerFactory.getLogger(FileUploadFormController.class);
	
	//저장경로 설정 (Windows 환경이므로 경로구분자를 \\로 지정)
	private String uploadFileRepoDir = "C:/myupload" ;
	
	//다중파일 업로드 방법1: form 방식의 파일업로드
	//파일 업로드 요청 JSP 페이지 호출
	@GetMapping("/fileUploadForm")
	public String callFileUploadForm() {
		return "sample/fileUploadForm";
	}
	
	//다중파일 업로드 방법1: form 방식의 파일업로드
	//Model이용, 업로드 파일 저장
	@PostMapping("/fileUploadFormAction")
	public String fileUploadActionPost(MultipartFile[] uploadFiles, Model model ) {
		for(MultipartFile multipartUploadFile : uploadFiles) {
			
			//업로드 파일의 리소스(저장폴더와 파일이름)가 설정된 File 객체 생성
			String strUploadFileName = multipartUploadFile.getOriginalFilename();
			
			//[Edge, IE 오류 해결] multipartUploadFile.getOriginalFilename()에서 업로드 파일이름만 추출
			//파일이름만 있는 경우, 파일이름만 추출됨
			strUploadFileName = strUploadFileName.substring(strUploadFileName.lastIndexOf("\\")+1);
			
			//업로드 정보(저장폴더와 파일이름 문자열)의 파일객체 생성
			File saveUploadFile = new File(uploadFileRepoDir, strUploadFileName);
			
			try {
				//서버에 파일객체를 이용하여 업로드 파일 저장
				multipartUploadFile.transferTo(saveUploadFile);
			} catch (Exception e) {
			}
		} // End-for
		return "sample/fileUploadFormResult";
}
}