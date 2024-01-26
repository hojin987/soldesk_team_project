package com.soldesk.healthproject.common.fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.soldesk.healthproject.common.fileupload.domain.AttachFileDTO;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class FileUploadAjaxController {
	
	private static final Logger log = LoggerFactory.getLogger(FileUploadAjaxController.class);
	
	//저장경로 (Windows 환경이므로 경로구분자를 \\로 지정)
	private String uploadFileRepoDir = "C:/myupload" ;
	
	//파일 업로드 요청 JSP 페이지 호출
	@GetMapping("/fileUploadAjax")
	public String callFileUploadAjax() {
		log.info("upload Ajax =====================");
		return "sample/fileUploadAjax" ;
	}
	
	//Step1- 날짜 형식 경로 문자열 생성 메소드
	private String getDatefmtPathName() { //메서드 추가
		//날짜 형식 지정
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		//날짜 생성
		Date date = new Date();
		//날짜 형식이 지정된 날짜문자열(yyyy/MM/dd) 생성
		String strDatefmtPathName = simpleDateFormat.format(date);
		//경로구분자를 운영체제에 맞도록 변경한 문자열을 반환
		return strDatefmtPathName.replace("/", File.separator);
	}
	
	//썸네일 이미지 생성
	//Step1: 업로드파일에 대한 이미지 파일여부 검사 메소드
	private boolean checkIsImageForUploadFile(File uploadFile) { // 메서드 추가
		try {
			String strContentType = Files.probeContentType(uploadFile.toPath());
			log.info("업로드파일의 ContentType: " + strContentType);
			
			return strContentType.startsWith("image");
			
		} catch (IOException e) {
			e.printStackTrace();		
		}
		
		return false;
	}
	
	//업로드 요청 파일-저장 및 결과 메시지 전송
	@PostMapping(value = "/fileUploadAjaxAction", produces = {"application/json; charset=UTF-8"}) 
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> fileUploadActionPost(MultipartFile[] uploadFiles) {//Ajax사용 시 Model 필요없슴
		log.info("====FileUpload With Ajax ========");
		
		//업로드 파일 각각에 대한 피드백정보(AttachInfoDTO)를 담을 리스트 객체
		List<AttachFileDTO> listAttachInfo = new ArrayList<AttachFileDTO>(); 
		
		//날짜 형식 폴더경로 문자열 생성(사용자에게 전달될 각 업로드파일의 저장경로로 날짜구조 폴더만 전달)
		String strDatefmtPathName = getDatefmtPathName(); 
		
		//전체 업로드 경로 파일객체 생성
		File fileUploadPath = new File(uploadFileRepoDir, strDatefmtPathName); 
		log.info("upload path: " + fileUploadPath);
		
		//경로가 존재하지 않으면 전체 폴더 구조 생성, 기존 폴더 구조중 일부가 있으면 없는 부분을 포함하여 전체를 생성
		if (fileUploadPath.exists() == false) { 
		fileUploadPath.mkdirs(); 
		}
		
		for(MultipartFile multipartUploadFile : uploadFiles) {		
			log.info("=================================");
			log.info("Upload File Name: "+ multipartUploadFile.getOriginalFilename());
			log.info("Upload File Size: "+ multipartUploadFile.getSize());
			
			//업로드파일 각각에 대한 피드백 정보가 저장될 AttachInfoDTO 객체 생성
			AttachFileDTO attachInfo = new AttachFileDTO();
			
			//attachInfoDTO에 repository 경로 저장
			attachInfo.setRepoPath(uploadFileRepoDir.toString());
			log.info("attachInfoDTO.repoPath: "+ attachInfo.getRepoPath());
			
			//attachInfoDTO에 날짜형식 경로 저장
			attachInfo.setUploadPath(strDatefmtPathName.toString());
			log.info("attachInfoDTO.uploadPath: "+ attachInfo.getUploadPath());
			
			//업로드파일이름 원본문자열
			String strUploadFileName = multipartUploadFile.getOriginalFilename();
			
			//[Edge, IE 오류 해결] 파일이름만 있는 경우, 파일이름만 추출됨
			strUploadFileName = strUploadFileName.substring(strUploadFileName.lastIndexOf("/")+1);
			log.info("수정된 파일이름(strUploadFileName): " + strUploadFileName);
			
			//attachInfoDTO에 원본업로드파일이름 저장
			attachInfo.setFileName(strUploadFileName);
			log.info("attachInfoDTO.fileName: " + attachInfo.getFileName());
			
			//UUID를 이용한 고유한 파일이름 적용
			UUID uuid = UUID.randomUUID(); 	
			
			//attachInfoDTO에 UUID 문자열 저장
			attachInfo.setUuid(uuid.toString()); 
			log.info("attachInfoDTO.uuid: " + attachInfo.getUuid());
			
			//파일이름에 UUID 문자열 추가(파일 확장자 때문에 UUID를 앞에다 추가해야 함
			strUploadFileName = uuid.toString() + "_" + strUploadFileName ; 
			log.info("UUID처리된파일이름: "+strUploadFileName); 
			
			//최종 저장 정보를 가진 파일 객체(서버레포경로 + 날짜형식 폴더 + UUID적용 파일이름)
			File saveUploadFile = new File(fileUploadPath, strUploadFileName); 
			log.info("저장시 사용되는 파일이름(saveUploadFile, 경로포함): " + saveUploadFile); 
			
			try {
				//서버에 파일객체를 이용하여 업로드 파일 저장
				multipartUploadFile.transferTo(saveUploadFile);
				
				//업로드 파일에 대하여 이미지파일 여부 확인
				
				
				if (checkIsImageForUploadFile(saveUploadFile)) { //이미지파일 임 --> if 문 처리로 썸네일이미지 생성 및 저장
					
					//attachInfoDTO.fileType에 "I" 저장
					attachInfo.setFileType("I"); 
					log.info("attachInfoDTO.fileType: "+ attachInfo.getFileType()); 
					
					//썸네일 생성경로와 파일이름이 설정된 파일객체를 전송 보내는 FileOutputStream 객체 생성
					FileOutputStream outputStreamForThumbnail =
							new FileOutputStream( new File(fileUploadPath, "s_" + strUploadFileName) );
					//FileOutput-스트림으로 보내진 파일객체를 서버에 저장(input)하여, 20X20 크기(px)의 썸네일 생성
					Thumbnailator.createThumbnail( multipartUploadFile.getInputStream(), //원본파일이 inputStream
												   outputStreamForThumbnail, 20, 20); // 썸네일이 outputStream
					//OUT 스트림리소스 닫기
					outputStreamForThumbnail.close();
					
				} else {//이미지파일 아님 --> if 문 처리 없음.
					//attachInfoDTO.fileType 에 "F" 저장
					attachInfo.setFileType("F"); 
					log.info("attachInfoDTO.fileType: " + attachInfo.getFileType());
				}
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			//List 객체에 attachInfoDTO 추가
			listAttachInfo.add(attachInfo);
		} // End-for	
		
		return new ResponseEntity<List<AttachFileDTO>> (listAttachInfo, HttpStatus.OK) ;
		
	}
	
	//썸네일 이미지 파일 다운로드  메서드 전체 추가
	@GetMapping("/displayThumbnailFile")
	@ResponseBody
	public ResponseEntity<byte[]> sendThumbNailFile(String fileName) {
		
		File file = new File(fileName);
		log.info("썸네일파일이름(경로포함): " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			//HttpHeader 객체에 썸네일이미지파일의 Content-Type 추가
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			//복사된 썸네일 파일을 HttpHeader에 추가된 Content-Type과 상태값을 가지고 ResponseEntity<byte[]> 객체 생성
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result; //ResponseEntity<byte[]> 객체 반환
	}
	
	//서버에 업로드 된 파일 삭제
	@PostMapping("/deleteUploadedFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String fileType) {
		log.info("deleteFileName: " + fileName);
		log.info("deleteFileType: " + fileType);
		
		//File 객체 생성
		File delFile = null ;
		
		try {
			//전체 경로명이 포함된 파일이름을 UTF-8로 디코딩하여 파일 객체를 생성
			delFile = new File(URLDecoder.decode(fileName, "UTF-8"));
			log.info("decoded deleting fileName: " + delFile);
			
			//파일객체의 delete()메서드로 파일(썸네일파일과 일반파일)을 삭제
			delFile.delete();
			
			//삭제파일의 유형이 image 값인 경우
			if (fileType.equals("I")) {
				//삭제된 파일의 파일객체에서 s_가 삭제된 파일이름을 얻음
				String originalImageFileName = delFile.getAbsolutePath().replace("s_", "");
				log.info("largeFileName: " + originalImageFileName);
				
				//이미지파일 이름의 객체를 얻어서
				delFile = new File(originalImageFileName);
				//원본 이미지파일 삭제
				delFile.delete();
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			
		}
		
		//삭제 후, 파일이 삭제되었다는 메시지를 전달합니다.
		return new ResponseEntity<String>("SuccessDeletingFile", HttpStatus.OK);
	}
	
	
	
	
	
}	