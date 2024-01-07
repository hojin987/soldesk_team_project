package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.NoticeBoardVO;

public interface NoticeBoardMapper {
	
	//게시물 조회 - 목록
	public List<NoticeBoardVO> selectNoticeBoardList();
	
	//게시물 등록
	public Integer insertNoticeBoard(NoticeBoardVO noticeBoard);
	
	//특정 게시물 조회
	public NoticeBoardVO selectNoticeBoard(Long npost_number);
	
	//특정 게시물 삭제 요청
	public int updateNdeleteFlag(Long npost_number);
	
	//특정 게시물 삭제 - 실제 삭제
	public int deleteNoticeBoard(Long npost_number);
	
	//게시물 삭제(관리자) 
	public int AllNoticeBoardFlag();
	
	//특정 게시물 수정
	public int updateNoticeBoard(NoticeBoardVO noticeBoard);
	
	//특정 게시물 조회수 증가
	public void updateNviewCount(Long npost_number);
}
