package com.soldesk.healthproject.service;

import com.soldesk.healthproject.common.paging.domain.QuestionBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.domain.QuestionBoardVO;

public interface QuestionBoardService {
	
	//게시물 목록 조회 서비스 - 페이징 고려
	public QuestionBoardPagingCreatorDTO getBoardList(BoardPagingDTO questionboardPaging) ;
	
	//게시물 등록
	public long registerQuestionBoard(QuestionBoardVO questionBoard);
	
	//게시물 조회
	public QuestionBoardVO getQuestionBoard(long qpost_number);
	
	//게시물 수정
	public boolean modifyQuestionBoard(QuestionBoardVO questionBoard);
	
	//게시물 삭제 플래그 + 1
	public boolean setQuestionBoardDeleted(long qpost_number);
	
	//게시물 삭제 - 실제 삭제
	public boolean removeQuestionBoard(long qpost_number);
	
	//게시물 삭제(관리자)

}
