package com.soldesk.healthproject.common.fileupload.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AttachFileDTO {
	
	private String fileName ;  //원본파일이름
	private String uploadPath ; //yyyy/MM/dd 형식 경로 문자열
	private String uuid ;       //파일 이름에 추가된 UUID.toString() 값.
	private String fileType ; //"I": 이미지파일, "F" : 이미지가 아닌 파일
	private String repoPath = "C:/myupload" ;
}
