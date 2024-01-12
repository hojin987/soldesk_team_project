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
public class QuestionBoardVO {
	
	private long qpost_number ;
	private String qtitle ;
	private String qcontent ;
	private String qwriter ;
	private Date qregister_date ;
	private long qview_count ;
	private long qreply_count ; 
	private String qdelete_flag ;
}
