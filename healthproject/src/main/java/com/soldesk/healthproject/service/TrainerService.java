package com.soldesk.healthproject.service;

import java.util.List;

import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.domain.TicketVO;
import com.soldesk.healthproject.domain.TrainerVO;

public interface TrainerService {
	
	//강사 경력 조회
	public List<TrainerVO> getTrainerRecordList();
	
	//특정 강사 경력 조회
	public List<TrainerVO> getTrainerRecord(String member_id);
	
	//강사 경력 등록
	public void registerRecord(TrainerVO trainer);
	
	//경력 수정
	public void modifyRecord(TrainerVO trainer);
	
	//경력 삭제
	public void removeRecord(String member_id);
	
}
