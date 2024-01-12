package com.soldesk.healthproject.common.paging.domain;

import java.util.List;

import com.soldesk.healthproject.domain.FreeCommentVO;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class FreeCommentPagingCreatorDTO {
	
	private List<FreeCommentVO> fcommentList ;
	private long fcommentTotalCount ;
	private FreeCommentPagingDTO fcommentPaging ;
	
	public FreeCommentPagingCreatorDTO(List<FreeCommentVO> fcommentList,
									   long fcommentTotalCount,
								   FreeCommentPagingDTO fcommentPaging) {
		
		this.fcommentList = fcommentList ;
		this.fcommentTotalCount = fcommentTotalCount ;
		this.fcommentPaging = fcommentPaging ;
	}

}
