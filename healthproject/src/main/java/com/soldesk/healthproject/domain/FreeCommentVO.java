package com.soldesk.healthproject.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FreeCommentVO {
	
	private long fcomment_number ;
	private long fpost_number ;
	private String fcomment ;
	private String fcomment_writer ;
	private Date fcomment_register_date ;
	private long freply_number ;
	private int fcomment_delete_flag ;


}
