package com.soldesk.healthproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.domain.FreeBoardVO;

public interface FreeBoardMapper {
	
	//게시물 목록 조회
	public List<FreeBoardVO> selectFreeBoardList(BoardPagingDTO freeBoardPaging);
	
	//게시물 총수(READ)
	public long selectRowTotal(BoardPagingDTO freeboardPaging) ;
		
	//게시물 등록
	public Integer insertFreeBoard(FreeBoardVO freeBoard);
	
	//특정 게시물 조회
	public FreeBoardVO selectFreeBoard(Long fpost_number);
	
	//특정 게시물 삭제 요청
	public int updateFdeleteFlag(Long fpost_number);
	
	//특정 게시물 삭제 - 실제 삭제
	public int deleteFreeBoard(Long fpost_number);
	
	//게시물 삭제(관리자) 
	public int AllFreeBoardFlag();
	
	//특정 게시물 수정
	public int updateFreeBoard(FreeBoardVO freeBoard);
	
	//특정 게시물 조회수 증가
	public void updateFviewCount(Long fpost_number);
	
	//특정 게시물 댓글/답글 수 변경
	public void updateFreplyCount(@Param("fpost_number") long fpost_number, @Param("amount") int amount);
}
