package com.soldesk.healthproject.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FreeBoardVO {
	
	private long fpost_number ;
	private String ftitle ;
	private String fcontent ;
	private String fwriter ;
	private Date fregister_date ;
	private long fview_count ;
	private long freply_count ; 
	private String fdelete_flag ;
	private String free_media_url;
}
