package com.soldesk.healthproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.domain.WorkoutVO;
import com.soldesk.healthproject.mapper.WorkoutMapper;

@Service
public class WorkoutServiceImpl implements WorkoutService {
	
	private WorkoutMapper workoutMapper;
	
	public WorkoutServiceImpl() {
	}
	
	@Autowired
	public void setWorkoutMapper(WorkoutMapper workoutMapper) {
		this.workoutMapper = workoutMapper;
	}
	
	//운동 목록 조회
	@Override
	public List<WorkoutVO> getWorkoutList() {
		return workoutMapper.selectWorkoutList();
	}
	
	//특정 운동 조회
	@Override
	public WorkoutVO getWorkout(String workout_code) {
		return workoutMapper.selectWorkout(workout_code);
	}
	
	//운동 등록
	@Override
	public String registerWorkout(WorkoutVO workout) {
		workoutMapper.insertWorkout(workout);
		return workout.getWorkout_code();
	}
	
	//운동 수정
	@Override
	public boolean modifyWorkout(WorkoutVO workout) {
		return workoutMapper.updateWorkout(workout) == 1;
	}
	
	//운동 삭제
	@Override
	public boolean removeWorkout(String workout_code) {
		return workoutMapper.deleteWorkout(workout_code) == 1;
	}
	
	

}
