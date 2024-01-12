package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.common.paging.domain.QuestionBoardPagingDTO;
import com.soldesk.healthproject.domain.QuestionBoardVO;

public interface QuestionBoardMapper {
	
	//게시물 목록 조회
	public List<QuestionBoardVO> selectQuestionBoardList(QuestionBoardPagingDTO questionBoardPaging);
	
	//게시물 총수(READ)
	public long selectRowTotal(QuestionBoardPagingDTO questionboardPaging) ;
	
	//게시물 등록
	public Integer insertQuestionBoard(QuestionBoardVO questionBoard);
	
	//특정 게시물 조회
	public QuestionBoardVO selectQuestionBoard(Long qpost_number);
	
	//특정 게시물 삭제 요청
	public int updateQdeleteFlag(Long qpost_number);
	
	//특정 게시물 삭제 - 실제 삭제
	public int deleteQuestionBoard(Long qpost_number);
	
	//게시물 삭제(관리자) 
	public int AllQuestionBoardFlag();
	
	//특정 게시물 수정
	public int updateQuestionBoard(QuestionBoardVO questionBoard);
	
	//특정 게시물 조회수 증가
	public void updateQviewCount(Long qpost_number);
}
