package com.soldesk.healthproject.service;

import java.util.List;

import com.soldesk.healthproject.domain.WorkoutVO;

public interface WorkoutService {
	
	//운동 목록 조회
	public List<WorkoutVO> getWorkoutList();
	
	//특정 운동 조회
	public WorkoutVO getWorkout(String workout_code);
	
	//운동 등록
	public String registerWorkout(WorkoutVO workout);
	
	//운동 수정
	public boolean modifyWorkout(WorkoutVO workout);
	
	//운동 삭제
	public boolean removeWorkout(String workout_code);
	
}
