package com.soldesk.healthproject.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TicketVO {
	
	private String ticket_number ;
	private String ticket_content ;
	private Date ticket_start_date ;
	private Date ticket_end_date ;
	private int pt_count;
	private long ticket_price ;

}
