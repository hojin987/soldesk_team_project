package com.soldesk.healthproject.common.fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.soldesk.healthproject.common.fileupload.domain.AttachFileDTO;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class FileUploadAjaxController {
	
	private String uploadFileRepoDir = "C:/myupload" ;
	
	//form을 통한 다중 파일 업로드  //uploadFiles
	
	//1. 파일 업로드 요청 JSP 페이지 호출
	
	@GetMapping(value= {"/fileUploadAjax"})
	public String callFileUploadAjaxPage() {
		System.out.println("'Ajax를 통한 업로드 테스트' JSP 페이지 호출======== ");
		return "sample/fileUploadAjax";
		
	}
	//이미지파일에 대한 썸네일이미지 저장
	//Step1: 업로드파일에 대한 이미지 파일여부 검사 메소드
	private boolean isImageFile(File yourFile) {
		
		String yourFileContentType = null;
		try {
			yourFileContentType = Files.probeContentType(yourFile.toPath());
			System.out.println("fileContentType: " + yourFileContentType);
			
			return yourFileContentType.startsWith("image");
		} catch (IOException e) {
			System.out.println("오류: " + e.getMessage());
		}
		
		return false ;
	}

	//날짜형식 문자열 생성 메서드
	private String getDateFmtPathName() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd") ;
		String dateFmtStr = sdf.format(new Date());
		
		return dateFmtStr ;

	}
	
	//2. 파일 업로드 처리
	@PostMapping(value = "/fileUploadAjaxAction", 
				 produces = "application/json; charset=utf-8") 
	@ResponseBody
	public List<AttachFileDTO> fileUploadAction(MultipartFile[] yourUploadFiles) {
		
		List<AttachFileDTO> attachFileList = new ArrayList<AttachFileDTO>();
		
		AttachFileDTO attachFile = null ;
		
		//파일이름이 저장되는 변수
		String fileName = null ;
		
		//UUID를 이용한 고유한 파일이름 적용
		String myUuid = null ;
		
		//날짜 형식 폴더 구조 생성
		String dateFmtStr = getDateFmtPathName() ;
		
		
		
		File fileUploadPath = new File(uploadFileRepoDir, dateFmtStr);
//		 C:/myupload\2023/12/14
		if (!fileUploadPath.exists()) {
			fileUploadPath.mkdirs() ;
		}
		
		for(MultipartFile uploadFile : yourUploadFiles) {
			System.out.println("=============================");
			System.out.println("Upload File Name: " + uploadFile.getOriginalFilename());
			System.out.println("Upload File Size: " + uploadFile.getSize());
			
			attachFile = new AttachFileDTO() ;
			
			attachFile.setUploadPath(dateFmtStr) ;
			attachFile.setRepoPath(uploadFileRepoDir) ;
			
			
			fileName = uploadFile.getOriginalFilename();
			// 파일이름.확장자, 경로명\파일이름.확장자, 파일이름만 남기는 처리.
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1) ;
			
			attachFile.setFileName(fileName);
			
			
			//UUID를 이용한 고유한 파일이름 적용
			myUuid = UUID.randomUUID().toString() ;
			
			attachFile.setUuid(myUuid) ;
			
			
			fileName = myUuid + "_" + fileName ;
			
			File saveUploadFile = new File(fileUploadPath, fileName);
			
			try {
				uploadFile.transferTo(saveUploadFile);
				
				//이미지파일이면 썸네일 생성
				if(isImageFile(saveUploadFile)) {
					
					attachFile.setFileType("I") ;
					
					File thumbnameFile = new File(fileUploadPath, "s_" + fileName);
					
					FileOutputStream myFos = 
							new FileOutputStream(thumbnameFile) ;
							
					
					InputStream myIs = uploadFile.getInputStream() ;
					
					Thumbnailator.createThumbnail(myIs, myFos, 30, 30) ;
					
					myIs.close() ;
					myFos.flush() ; 
					myFos.close() ;
				} else {
					attachFile.setFileType("F") ;
				}
				
			} catch (IllegalStateException | IOException e) {
				System.out.println("error: " + e.getMessage());
			} 
			
			attachFileList.add(attachFile) ;

		}//for-end
		
		return attachFileList ;
	}
	
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName, String fileType){
//		System.out.println("fileName: " + fileName);
//		System.out.println("fileType: " + fileType);
//		fileName: C:/myupload/2023/12/15/0d62242c-c8cf-4365-8ab6-cebd21e247e1_%EC%97%85%EB%A1%9C%EB%93%9C%20%ED%85%8C%EC%8A%A4%ED%8A%B8PPT%ED%8C%8C%EC%9D%BC.pptx
//		fileType: F
		
		try {
			fileName = URLDecoder.decode(fileName, "utf-8") ;
			System.out.println("fileName: " + fileName);
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		File delFile = new File(fileName) ;
		
		boolean delResult = delFile.delete() ; //일반파일과 썸네일 파일 삭제
		//정상삭제: true 반환, 삭제실패: false 반환
		if (!delResult) {
			return new ResponseEntity<String>("F", HttpStatus.OK) ;
		}
		
		if(fileType.equals("I")) {
			delFile = new File(fileName.replaceFirst("s_", ""));
			delResult = delFile.delete() ;
		}
		
		return delResult ? new ResponseEntity<String>("S", HttpStatus.OK)
						 : new ResponseEntity<String>("F", HttpStatus.OK) ;
		
		
	}
}
