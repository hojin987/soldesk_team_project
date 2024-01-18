package com.soldesk.healthproject.common.fileupload;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadFormController {
	
	private String uploadFileRepoDIr = "C:/myupload" ;
	
	//form을 통한 다중 파일 업로드  //uploadFiles
	
	//1. 파일 업로드 요청 JSP 페이지 호출
	
	@GetMapping(value= {"/fileUploadForm"})
	public String callFileUploadFormPage() {
		System.out.println("'Form을 통한 업로드 테스트' JSP 페이지 호출======== ");
		return "sample/fileUploadForm";
		
	}
	
	//2. 파일 업로드 처리
	@PostMapping(value = "/fileUploadFormResult")
	public String fileUploadActionForm(@ModelAttribute("ename") String ename,
									   MultipartFile[] uploadFiles) {
		String originalFileName = null ;
		
		for(MultipartFile uploadFile : uploadFiles) {
			System.out.println("=============================");
			System.out.println("Upload File Name: " + uploadFile.getOriginalFilename());
			System.out.println("Upload File Size: " + uploadFile.getSize());
			
//			File saveuploadFile = new File(uploadFileRepoDIr, uploadFile.getOriginalFilename());
			
			originalFileName = uploadFile.getOriginalFilename();
			// 파일이름.확장자, 경로명\파일이름.확장자, 파일이름만 남기는 처리.
			originalFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1) ;
			
			File saveuploadFile = new File(uploadFileRepoDIr, originalFileName);
			
			try {
				uploadFile.transferTo(saveuploadFile);
				
			} catch (IllegalStateException | IOException e) {
				System.out.println("error: " + e.getMessage());
			} 

		}
		
		return "sample/fileUploadFormResult" ;
	}
}
