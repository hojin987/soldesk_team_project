package com.soldesk.healthproject.common.paging.domain;

import java.util.List;

import com.soldesk.healthproject.domain.NoticeCommentVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class NoticeCommentPagingCreatorDTO {
	
	private List<NoticeCommentVO> ncommentList ;
	private long ncommentTotalCount ;
	private NoticeCommentPagingDTO ncommentPaging ;
	
	public NoticeCommentPagingCreatorDTO(List<NoticeCommentVO> ncommentList,
									   long ncommentTotalCount,
								   NoticeCommentPagingDTO ncommentPaging) {
		
		this.ncommentList = ncommentList ;
		this.ncommentTotalCount = ncommentTotalCount ;
		this.ncommentPaging = ncommentPaging ;
	}

}
