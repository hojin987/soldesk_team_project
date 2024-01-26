package com.soldesk.healthproject.domain;

import java.sql.Date;

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
public class TrainerVO {
	
	private String member_id;
	private String trainer_record;
	private Date trainer_record_get_date;
}
