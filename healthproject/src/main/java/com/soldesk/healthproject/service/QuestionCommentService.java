package com.soldesk.healthproject.service;

import java.util.List;

import com.soldesk.healthproject.domain.QuestionCommentVO;

public interface QuestionCommentService {
	
	//특정 게시물에 대한 댓글 목록 조회
	public List<QuestionCommentVO> getQuestionCommentList() ;
	
	//특정 게시물에 대한 댓글 등록(qreply_number: null)
	public Long registerQuestionCommentForQuestionBoard(QuestionCommentVO qcomment) ;
	
	//댓글에 대한 답글 등록(qreply_number: 부모글의 qcomment_number 값)
	public Long registerQuestionCommentForQuestionComment(QuestionCommentVO qcomment);
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	public QuestionCommentVO getQuestionComment(long qpost_number, long qcomment_number) ;
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	public boolean modifyQuestionComment(QuestionCommentVO qcomment);
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
	public boolean modifyQcommentDeleteFlag(long qpost_number, long qcomment_number) ;
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	public int removeAllQuestionComment(long qpost_number) ;

}
