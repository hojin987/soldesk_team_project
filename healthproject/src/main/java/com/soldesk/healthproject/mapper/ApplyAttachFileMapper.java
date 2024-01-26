package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.ApplyAttachFileVO;

public interface ApplyAttachFileMapper {
	
	//첨부파일 등록
	public void insertAttachFile(ApplyAttachFileVO attachFile);
	
	//첨부파일 조회
	public List<ApplyAttachFileVO> selectAttachFiles(Long apost_number);
	
	//첨부파일 삭제
	public void deleteAttachFile(String uuid);
	
	public void deleteAttachFiles(Long apost_number);
	
}
