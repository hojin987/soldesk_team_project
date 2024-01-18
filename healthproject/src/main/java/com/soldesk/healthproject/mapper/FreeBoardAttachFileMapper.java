package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.FreeBoardAttachFileVO;

public interface FreeBoardAttachFileMapper {
	//기본 CRUD 처리 메서드 정의
	//특정 게시물의 첨부파일 목록 조회
	public List<FreeBoardAttachFileVO> selectAttachFiles(Long fpost_number) ;
	
	//첨부파일 추가
	public void insertAttachFile(FreeBoardAttachFileVO attachFile) ;
	
	//특정 첨부파일 삭제
	public void deleteAttachFile(String uuid) ;
	
	//특정 게시물의 모든 첨부파일 삭제
	//게시물 삭제 시, 해당 게시물의 모든 첨부파일을 삭제해야 게시물이 삭제됨
	//(on delete cascade 옵션이 없는 F.K인 경우),  
	public int deleteAttachFiles(Long fpost_number) ;
	
	
	
}
