package com.soldesk.healthproject.common.paging.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductCommentPagingDTO {
	
	private long product_number ;
	private int productPageNum ;
	private int rowAmountPerProductPage ;

	
//	public ProductBoardPagingDTO() {
//		this.productPageNum = 1 ;
//		this.rowAmountPerProductPage = 10 ;
//	}

	//생성자: 목록 화면에서 사용자가 표시할 행수를 선택하고 페이징 번호 클릭 시,
	//페이지번호와 행수를 각각 사용자가 선택한 페이징번호와 표시행수로 전달
	public ProductCommentPagingDTO(Long product_number, Integer productPageNum) {
		
		this.product_number = product_number ;
		
		if (productPageNum == null) {
			this.productPageNum = 1 ;
			
		} else {
			this.productPageNum = productPageNum;
		}
		
		this.rowAmountPerProductPage = 10 ;
		
	}
	

	

}
