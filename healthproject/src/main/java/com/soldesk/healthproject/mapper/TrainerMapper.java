package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.TrainerVO;

public interface TrainerMapper {
	
	//강사 경력 조회
	public List<TrainerVO> selectTainerRecordList();
	
	//특정 강사 경력 조회
	public TrainerVO selectTrainerRecord(String member_id);
	
	//강사 경력 등록
	public long insertTrainerRecord(TrainerVO ticket);
	
	//경력 수정
	public long updateTrainerRecord(TrainerVO ticket);
	
	//경력 삭제
	public long deleteTrainerRecord(String member_id);
	
	
}
