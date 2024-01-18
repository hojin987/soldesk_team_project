package com.soldesk.healthproject.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class FreeBoardAttachFileVO {
 private String uuid;
 private String uploadPath;
 private String fileName;
 private String fileType;
 private long fpost_number;
 private String repoPath= "C:\\myupload"; //서버의 첨부파일 기본 저장경로(C:\myupload)
 //데이터베이스에는 저장되지 않습니다.
}