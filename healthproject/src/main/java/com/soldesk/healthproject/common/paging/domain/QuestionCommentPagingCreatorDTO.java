package com.soldesk.healthproject.common.paging.domain;

import java.util.List;

import com.soldesk.healthproject.domain.QuestionCommentVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class QuestionCommentPagingCreatorDTO {
	
	private List<QuestionCommentVO> qcommentList ;
	private long qcommentTotalCount ;
	private QuestionCommentPagingDTO qcommentPaging ;
	
	public QuestionCommentPagingCreatorDTO(List<QuestionCommentVO> qcommentList,
									   long qcommentTotalCount,
								   QuestionCommentPagingDTO qcommentPaging) {
		
		this.qcommentList = qcommentList ;
		this.qcommentTotalCount = qcommentTotalCount ;
		this.qcommentPaging = qcommentPaging ;
	}

}
