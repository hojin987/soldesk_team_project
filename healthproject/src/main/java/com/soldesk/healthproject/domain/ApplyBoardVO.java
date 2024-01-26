package com.soldesk.healthproject.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
//@AllArgsConstructor
@Data
public class ApplyBoardVO {
	
	private long apost_number ;
	private String atitle ;
	private String acontent ;
	private String awriter ;
	private Date aregister_date ;
	private long aview_count ;
	private String adelete_flag ;
	private List<ApplyAttachFileVO> attachFileList;
	
}
