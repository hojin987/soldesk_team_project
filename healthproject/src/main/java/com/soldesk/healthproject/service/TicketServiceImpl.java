package com.soldesk.healthproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.domain.TicketVO;
import com.soldesk.healthproject.mapper.TicketMapper;

@Service
public class TicketServiceImpl implements TicketService {
	
	private TicketMapper ticketMapper;
	
	public TicketServiceImpl() {
		System.out.println("TicketServiceImpl의 기본생성자");
	}
	
	@Autowired
	public void setTicketMapper(TicketMapper ticketMapper) {
		this.ticketMapper = ticketMapper;
	}
	
	//회원권 목록 조회
	@Override
	public List<TicketVO> getTicketList() {
		return ticketMapper.selectTicketList();
	}
	
	//특정 회원권 조회
	@Override
	public TicketVO getTicket(String ticket_number) {
		return ticketMapper.selectTicket(ticket_number);
	}
	
	//회원권 등록
	@Override
	public String registerTicket(TicketVO ticket) {
		ticketMapper.insertTicket(ticket);
		return ticket.getTicket_number();
	}
	
	//회원권 수정
	@Override
	public boolean modifyTicket(TicketVO ticket) {
		return ticketMapper.updateTicket(ticket) == 1;
	}
	
	//회원권 삭제
	@Override
	public boolean removeTicket(String ticket_number) {
		return ticketMapper.deleteTicket(ticket_number) == 1;
	}

}
