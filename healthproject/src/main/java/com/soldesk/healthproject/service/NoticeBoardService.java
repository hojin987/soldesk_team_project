package com.soldesk.healthproject.service;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingCreatorDTO;
import com.soldesk.healthproject.domain.NoticeBoardVO;

public interface NoticeBoardService {
	
	//게시물 목록 조회 서비스 - 페이징 고려
	public NoticeBoardPagingCreatorDTO getBoardList(BoardPagingDTO noticeboardPaging) ;
	
	//게시물 등록
	public long registerNoticeBoard(NoticeBoardVO noticeBoard);
	
	//게시물 조회
	public NoticeBoardVO getNoticeBoard(long npost_number);
	
	//게시물 수정
	public boolean modifyNoticeBoard(NoticeBoardVO noticeBoard);
	
	//게시물 삭제 플래그 + 1
	public boolean setNoticeBoardDeleted(long npost_number);
	
	//게시물 삭제 - 실제 삭제
	public boolean removeNoticeBoard(long npost_number);
	
	//게시물 삭제(관리자)

}
