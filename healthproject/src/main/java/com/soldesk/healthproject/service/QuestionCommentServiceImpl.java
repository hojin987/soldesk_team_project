package com.soldesk.healthproject.service;

import java.util.List;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soldesk.healthproject.domain.QuestionCommentVO;
import com.soldesk.healthproject.mapper.QuestionCommentMapper;

@Service
public class QuestionCommentServiceImpl implements QuestionCommentService {

	private QuestionCommentMapper questionCommentMapper ;
//	private QuestionBoardMapper questionBoardMapper ;
	
	public QuestionCommentServiceImpl(QuestionCommentMapper questionCommentMapper
//								  QuestionBoardMapper questionBoardMapper) {
								  ) {
		this.questionCommentMapper = questionCommentMapper ;
//		this.queestionBoardMapper = questionBoardMapper ;
	}
	
	
	//특정 게시물에 대한 댓글 목록 조회
	@Override
	public List<QuestionCommentVO> getQuestionCommentList() {
		
		return questionCommentMapper.selectQuestionCommentList() ;			
	}
	
	//특정 게시물에 대한 댓글 등록(qreply_number: null)
	@Transactional
	@Override
	public Long registerQuestionCommentForQuestionBoard(QuestionCommentVO qcomment) {
		
		questionCommentMapper.insertQuestionCommentForQuestionBoard(qcomment) ;
//		questionBoardMapper.updateQreply_count(qcomment.getQpost_number(), 1);
		return qcomment.getQcomment_number() ; 
	}
	
	//댓글에 대한 답글 등록(qreply_number: 부모글의 qcomment_number 값)
	
	@Override
	@Transactional
	public Long registerQuestionCommentForQuestionComment(QuestionCommentVO qcomment) {
		questionCommentMapper.insertQuestionCommentForQuestionComment(qcomment) ;
//		questionBoardMapper.updateQreply_count(qcomment.getQpost_number(), 1);
		
		return qcomment.getQcomment_number() ; 
	}
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	@Override
	public QuestionCommentVO getQuestionComment(long qpost_number, long qcomment_number) {
		return questionCommentMapper.selectQuestionComment(qpost_number, qcomment_number) ;
	}
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	@Override
	public boolean modifyQuestionComment(QuestionCommentVO qcomment) {
		return questionCommentMapper.updateQuestionComment(qcomment) == 1 ;
		
	}
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(qcommentDeleteFlag를 1로 업데이트)
	@Override
	@Transactional
	public boolean modifyQcommentDeleteFlag(long qpost_number, long qcomment_number) {
		
		int deleteRowCnt = questionCommentMapper.updateQcommentDeleteFlag(qpost_number, qcomment_number) ;
		
//		questionBoardMapper.updateQreply_count(qpost_number, -1);
		
		return deleteRowCnt == 1 ;
		
//		return questionCommentMapper.updateQcommentDeleteFlag(qpost_number, qcomment_number) == 1;
	}
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@Override
	public int removeAllQuestionComment(long qpost_number) {
		return questionCommentMapper.deleteAllQuestionComment(qpost_number) ;
	}

}
