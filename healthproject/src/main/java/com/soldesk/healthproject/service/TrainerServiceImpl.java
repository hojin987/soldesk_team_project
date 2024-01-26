package com.soldesk.healthproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.domain.TrainerVO;
import com.soldesk.healthproject.mapper.TrainerMapper;

@Service
public class TrainerServiceImpl implements TrainerService {
	
	private TrainerMapper trainerMapper;
	
	public TrainerServiceImpl() {
		
	}
	
	@Autowired
	public void setTrainerMapper(TrainerMapper trainerMapper) {
		this.trainerMapper = trainerMapper;
	}
	
	//강사 경력 조회
	@Override
	public List<TrainerVO> getTrainerRecordList() {
		return trainerMapper.selectTainerRecordList();
	}
	
	//특정 강사 경력 조회
	@Override
	public List<TrainerVO> getTrainerRecord(String member_id) {
		return trainerMapper.selectTrainerRecord(member_id);
	}
	
	//강사 경력 등록
	@Override
	public void registerRecord(TrainerVO trainer) {
		trainerMapper.insertTrainerRecord(trainer);
	}
	
	//강사 경력 수정
	@Override
	public void modifyRecord(TrainerVO trainer) {
		trainerMapper.updateTrainerRecord(trainer);
	}
	
	//강사 경력 삭제
	@Override
	public void removeRecord(String member_id) {
		trainerMapper.deleteTrainerRecord(member_id);
	}
	
}
