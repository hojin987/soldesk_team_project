package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.WorkoutVO;

public interface WorkoutMapper {
	
	//운동 목록 조회
	public List<WorkoutVO> selectWorkoutList(); 
	
	//특정 운동 조회
	public WorkoutVO selectWorkout(String workout_code);
	
	//운동 등록
	public long insertWorkout(WorkoutVO workout);
	
	//운동 수정
	public long updateWorkout(WorkoutVO workout);
	
	//운동 삭제
	public long deleteWorkout(String workout_code);
	
	
}
