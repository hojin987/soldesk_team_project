package com.soldesk.healthproject.common.paging.domain;

import java.util.List;

import com.soldesk.healthproject.domain.ProductCommentVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ProductCommentPagingCreatorDTO {
	
	private List<ProductCommentVO> pcommentList ;
	private long pcommentTotalCount ;
	private ProductCommentPagingDTO pcommentPaging ;
	
	public ProductCommentPagingCreatorDTO(List<ProductCommentVO> pcommentList,
									   long pcommentTotalCount,
								   ProductCommentPagingDTO pcommentPaging) {
		
		this.pcommentList = pcommentList ;
		this.pcommentTotalCount = pcommentTotalCount ;
		this.pcommentPaging = pcommentPaging ;
	}

}
