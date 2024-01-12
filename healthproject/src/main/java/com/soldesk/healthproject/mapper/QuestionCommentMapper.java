package com.soldesk.healthproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.soldesk.healthproject.common.paging.domain.QuestionCommentPagingDTO;
import com.soldesk.healthproject.domain.QuestionCommentVO;


public interface QuestionCommentMapper {

	//특정 게시물에 대한 댓글 목록 조회: (페이징 고려)
	public List<QuestionCommentVO> selectQuestionCommentList(QuestionCommentPagingDTO questionCommentPagingDTO) ;
		
	//특정 게시물에 대한 댓글 총 개수
	public long selectQuestionRowTotal(long qpost_number) ;
	
	//특정 게시물에 대한 댓글 등록(qreply_number: null)
	public long insertQuestionCommentForQuestionBoard(QuestionCommentVO qcomment) ;

	//댓글에 대한 답글 등록(qreply_number: 부모글의 qcomment_number 값)
	public long insertQuestionCommentForQuestionComment(QuestionCommentVO qcomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 조회
	public QuestionCommentVO selectQuestionComment(@Param("qpost_number") long qpost_number, @Param("qcomment_number") long qcomment_number) ;
		
	//특정 게시물에 대한 특정 댓글/답글 수정
	public int updateQuestionComment(QuestionCommentVO qcomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 삭제요청(qcomment_delete_flag를 1로 업데이트)
	public int updateQcommentDeleteFlag(@Param("qpost_number") long qpost_number, @Param("qcomment_number") long qcomment_number) ;
		
	//특정 게시물에 대한 모든 댓글 삭제
	public int deleteAllQuestionComment(long qpost_number) ;
	
}
