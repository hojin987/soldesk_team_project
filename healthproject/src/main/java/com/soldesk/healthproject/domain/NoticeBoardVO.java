package com.soldesk.healthproject.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NoticeBoardVO {
	
	private long npost_number ;
	private String ntitle ;
	private String ncontent ;
	private String nwriter ;
	private Date nregister_date ;
	private long nview_count ;
	private long nreply_count ; 
	private String ndelete_flag ;
}
