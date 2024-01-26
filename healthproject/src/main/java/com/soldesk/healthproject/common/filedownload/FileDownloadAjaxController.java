package com.soldesk.healthproject.common.filedownload;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
//import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FileDownloadAjaxController {
	
	private static final Logger log = LoggerFactory.getLogger(FileDownloadAjaxController.class);
	
	@GetMapping(value = "/fileDownloadAjax", produces = {"application/octet-stream"} )
	@ResponseBody //일반 컨트롤러에서 REST 방식으로 사용자 브라우저에 데이터만 전송하는 REST-API 어노테이션
	public ResponseEntity<Resource> fileDownloadActionAjax(
					//사용자 브라우저를 확인하기 위해 User-Agent 해더를 매개변수로 설정
					@RequestHeader("User-Agent") String userAgent, String fileName){
		log.info("브라우저로 요청에서 전달된 User-Agent 해더정보: "+ userAgent);
		log.info("처리 전 파일이름: " + fileName);
		
		//톰캣 서버 운영체제에 있는 파일을 액세스할 수 있는 Resource 객체를 생성하기 위하여
		//스프링 Resource 인터페이스를 통해 FileSystemResource 구현객체를 생성합니다.
		Resource resource = new FileSystemResource(fileName);
		log.info("resource :" + resource);
		
	//	파일이 존재하지 않으면, 오류전송 후, 메소드 종료
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		//확인된 파일이름을 변수에 저장
		String resourceFileName = resource.getFilename();
		log.info("UUID 제거 전 resourceFileName :" + resourceFileName);
		
		//UUID가 제거된 파일이름
		resourceFileName = resourceFileName.substring(resourceFileName.indexOf("_") + 1);
		log.info("UUID 제거 후 resourceFileName :" + resourceFileName);
		
		//스프링의 HttpHeders 객체 생성
		HttpHeaders httpHeaders = new HttpHeaders();
		
		try {
			String downloadName = null;
			if ( userAgent.contains("Trident") || userAgent.contains("MSIE") ||
				 userAgent.contains("Edge") || userAgent.contains("Edg")) {
				log.info("IE 또는 엣지 브라우저입니다");
				downloadName = URLEncoder.encode(resourceFileName, "UTF8");
				log.info("IE에서의 파일이름: "+ downloadName);
				
			} else {
				log.info("Chrome 브라우저입니다");
				
				downloadName = new String(resourceFileName.getBytes("UTF-8"), "ISO-8859-1");
				
				log.info("Chrome에서의 파일이름: "+ downloadName);
			}
			
			//생성된 HttpHeaers 객체에 파일을 다운로드 받을 수 있도록 Content-Disposition 해더 설정
			//HTML기본 인코딩(ISO-8859-1)으로 인코딩된 파일이름 문자열을 지정
			httpHeaders.add("Content-Disposition", "attachment; filename=" + downloadName);
			
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	}
		
	//ResponseEntity<Resource>에 서버의 파일리소스, HttpHeaders객체, 상태를 담아서 반환
	return new ResponseEntity<Resource>(resource, httpHeaders, HttpStatus.OK);
  }
}