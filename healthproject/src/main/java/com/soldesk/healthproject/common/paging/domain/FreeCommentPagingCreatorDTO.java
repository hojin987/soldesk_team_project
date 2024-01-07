package com.soldesk.healthproject.common.paging.domain;

import java.util.List;

import com.soldesk.healthproject.domain.FreeCommentVO;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class FreeCommentPagingCreatorDTO {
	
	private List<FreeCommentVO> freeCommentList ;
	private FreeCommentPagingDTO freeCommentPaging ;
	
	public FreeCommentPagingCreatorDTO(List<FreeCommentVO> freeCommentList, 
								   FreeCommentPagingDTO freeCommentPaging) {
		
		this.freeCommentList = freeCommentList ;
		this.freeCommentPaging = freeCommentPaging ;
	}

}
