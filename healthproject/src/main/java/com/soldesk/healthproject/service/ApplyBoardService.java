package com.soldesk.healthproject.service;

import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingDTO;
import com.soldesk.healthproject.domain.ApplyBoardVO;

public interface ApplyBoardService {
	
	//게시물 목록 조회 서비스 - 페이징 고려
	public ApplyBoardPagingCreatorDTO getBoardList(ApplyBoardPagingDTO applyboardPaging) ;
	
	//게시물 등록
	public long registerApplyBoard(ApplyBoardVO applyBoard);
	
	//게시물 조회
	public ApplyBoardVO getApplyBoard(long apost_number);
	
	//게시물 수정
	public boolean modifyApplyBoard(ApplyBoardVO applyBoard);
	
	//게시물 삭제 플래그 + 1
	public boolean setApplyBoardDeleted(long apost_number);
	
	//게시물 삭제 - 실제 삭제
	public boolean removeApplyBoard(long apost_number);
	
	//게시물 삭제(관리자)

}
