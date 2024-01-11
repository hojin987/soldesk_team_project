package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.TicketVO;

public interface TicketMapper {
	
	//회원권 목록 조회
	public List<TicketVO> selectTicketList(); 
	
	//특정 회원권 조회
	public TicketVO selectTicket(String ticket_number);
	
	//회원권 등록
	public long insertTicket(TicketVO ticket);
	
	//회원권 수정
	public long updateTicket(TicketVO ticket);
	
	//회원권 삭제
	public long deleteTicket(String ticket_number);
	
	
}
