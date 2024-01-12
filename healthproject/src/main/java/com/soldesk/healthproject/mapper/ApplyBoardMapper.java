package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingDTO;
import com.soldesk.healthproject.domain.ApplyBoardVO;

public interface ApplyBoardMapper {
	
	//게시물 목록 조회
	public List<ApplyBoardVO> selectApplyBoardList(ApplyBoardPagingDTO applyBoardPaging);
	
	//게시물 총수(READ)
	public long selectRowTotal(ApplyBoardPagingDTO applyboardPaging) ;
	
	//게시물 등록
	public Integer insertApplyBoard(ApplyBoardVO applyBoard);
	
	//특정 게시물 조회
	public ApplyBoardVO selectApplyBoard(Long apost_number);
	
	//특정 게시물 삭제 요청
	public int updateAdeleteFlag(Long apost_number);
	
	//특정 게시물 삭제 - 실제 삭제
	public int deleteApplyBoard(Long apost_number);
	
	//게시물 삭제(관리자) 
	public int AllApplyBoardFlag();
	
	//특정 게시물 수정
	public int updateApplyBoard(ApplyBoardVO applyBoard);
	
	//특정 게시물 조회수 증가
	public void updateAviewCount(Long apost_number);
}
