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
public class ProductVO {
	
	private String product_number ;
	private String product_content ;
	private Date product_period ;
	private long product_price ;
	private long product_stock ;
	private String product_delete_flag ;


}
