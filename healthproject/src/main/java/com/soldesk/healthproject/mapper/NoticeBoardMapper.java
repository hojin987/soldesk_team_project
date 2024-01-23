package com.soldesk.healthproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.domain.NoticeBoardVO;

public interface NoticeBoardMapper {
	
	//게시물 목록 조회
	public List<NoticeBoardVO> selectNoticeBoardList(BoardPagingDTO noitceBoardPaging);
	
	//게시물 총수(READ)
	public long selectRowTotal(BoardPagingDTO noitceboardPaging) ;
	
	//게시물 등록
	public Integer insertNoticeBoard(NoticeBoardVO noticeBoard);
	
	//특정 게시물 조회
	public NoticeBoardVO selectNoticeBoard(long npost_number);
	
	//특정 게시물 삭제 요청
	public int updateNdeleteFlag(long npost_number);
	
	//특정 게시물 삭제 - 실제 삭제
	public int deleteNoticeBoard(long npost_number);
	
	//게시물 삭제(관리자) 
	public int AllNoticeBoardFlag();
	
	//특정 게시물 수정
	public int updateNoticeBoard(NoticeBoardVO noticeBoard);
	
	//특정 게시물 조회수 증가
	public void updateNviewCount(long npost_number);
	
	//특정 게시물 댓글/답글 수 변경
	public void updateNreplyCount(@Param("npost_number") long npost_number, @Param("amount") int amount);
}
