package com.soldesk.healthproject.service;

import java.util.List;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.domain.FreeBoardAttachFileVO;
import com.soldesk.healthproject.domain.FreeBoardVO;

public interface FreeBoardService {
	
	//게시물 목록 조회 서비스 - 페이징 고려
	public FreeBoardPagingCreatorDTO getBoardList(BoardPagingDTO freeboardPaging) ;
	
	//게시물 등록
	public long registerFreeBoard(FreeBoardVO freeBoard);
	
	//게시물 조회
	public FreeBoardVO getFreeBoard(long fpost_number);
	
	//게시물 수정
	public boolean modifyFreeBoard(FreeBoardVO freeBoard);
	
	//게시물 삭제 플래그 + 1
	public boolean setFreeBoardDeleted(long fpost_number);
	
	//게시물 삭제 - 실제 삭제
	public boolean removeFreeBoard(long fpost_number);
	
	//특정 게시물의 첨부파일 목록 조회
	public List<FreeBoardAttachFileVO> getAttachFileList(Long fpost_number) ;
	
	//특정 게시물의 서버 업로드 파일 삭제
	//public void removeAttachFiles(List<FreeBoardAttachFileVO> attachFileList) ;
}
