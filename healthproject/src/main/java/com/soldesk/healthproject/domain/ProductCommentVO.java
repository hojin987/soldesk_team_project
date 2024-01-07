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
public class ProductCommentVO {
	
	private long pcomment_number ;
	private long product_number ;
	private String pcomment ;
	private String pcomment_writer ;
	private Date pcomment_register_date ;
	private long preply_number ;
	private int pcomment_delete_flag ;


}
