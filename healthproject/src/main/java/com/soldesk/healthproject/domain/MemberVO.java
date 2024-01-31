package com.soldesk.healthproject.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	
	private String member_id;
	private String member_pw;
	private String member_email;
	private String member_name;
	private Date member_birth;
	private String member_phonenumber;
	private Timestamp member_register_date;
	private String member_delete_flag;
	private String member_enabled;
	private long member_height;
	private long member_weight;
	private String member_muscle_percent;
	private String member_fat_percent;
	private String member_goal;
	private String ticket_number;
	private Date ticket_start_date;
	private Date ticket_end_date;
	private int pt_count;
	
	private List<AuthorityVO> authorityList;
}
