package com.soldesk.healthproject.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class WorkoutVO {
	
	private String workout_code;
	private String workout_name;
	private String workout_content;
	private String workout_target;
	private String workout_warning;
	
}
