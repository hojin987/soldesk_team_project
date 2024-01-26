package com.soldesk.healthproject.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ApplyAttachFileVO {
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private String fileType;
	private long apost_number;
	private String repoPath= "C:/myupload"; 

}
