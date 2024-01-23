package com.soldesk.healthproject.service;

import java.util.List;

import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.domain.TicketVO;

public interface TicketService {
	
	//회원권 목록 조회
	public List<TicketVO> getTicketList();
		
	//특정 회원권 조회
	public TicketVO getTicket(String ticket_number);
	
	//회원권 상품 등록
	public String registerTicket(TicketVO ticket);
	
	//회원 회원권 등록
	public void setMemberTicket(MemberVO member);
	
	//회원권 수정
	public boolean modifyTicket(TicketVO ticket);
	
	//회원권 삭제
	public boolean removeTicket(String ticket_number);
	
}
