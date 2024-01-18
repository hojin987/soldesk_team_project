package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.domain.WorkoutVO;
import com.soldesk.healthproject.service.WorkoutService;

@Controller
@RequestMapping("/workout")
public class WorkoutController {
	private WorkoutService workoutService;
	
	public WorkoutController(WorkoutService workoutService) {
		this.workoutService = workoutService;
		System.out.println("workoutService의 모든 필드 초기화 생성자");
	}
	
	//운동 목록 조회 GET
	@GetMapping("/list")
	public void showWorkoutList(Model model) {
		model.addAttribute("workoutList", workoutService.getWorkoutList());
	}
	
	//특정 운동 조회 GET
	@GetMapping("/detail")
	public String showWorkoutServiceDetail(@RequestParam("workout_code") String workout_code,
								   Model model) {
		model.addAttribute("workout", workoutService.getWorkout(workout_code));
	
		return "workout/detail";
	}
	
	//운동 등록페이지 호출 GET
	@GetMapping("/register")
	public void showWorkoutRegister() {
	}
	
	//운동 등록 POST
	@PostMapping("/register")
	public String registerWorkout(WorkoutVO workout, RedirectAttributes redirectAttr) {
		
		String workout_code = workoutService.registerWorkout(workout);
		
		redirectAttr.addFlashAttribute("result", workout_code);
		
		return "redirect:/workout/list";
	}
	
	//운동 수정-삭제 페이지 호출 GET
	@GetMapping("/modify")
	public String showWorkoutModify(@RequestParam("workout_code") String workout_code,
								   Model model) {
		model.addAttribute("workout", workoutService.getWorkout(workout_code));
	
		return "workout/modify";
	}
	
	//운동 수정 POST
	@PostMapping("/modify")
	public String modifyWorkout(WorkoutVO workout, RedirectAttributes redirectAttr) {
		workoutService.modifyWorkout(workout);
		System.out.println("workout: " + workout);
		System.out.println("workout_code: " + workout.getWorkout_code());
		return "redirect:/workout/detail?workout_code=" + workout.getWorkout_code();
	}
	
	//운동 삭제 POST
	@PostMapping("/remove")
	public String removeWorkout(@RequestParam("workout_code") String workout_code, 
								RedirectAttributes redirectAttr) {
		workoutService.removeWorkout(workout_code);
		
		return "redirect:/workout/list" ;
	}
	
	
}
