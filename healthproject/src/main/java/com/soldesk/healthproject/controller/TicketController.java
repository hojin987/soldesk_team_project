package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.domain.TicketVO;
import com.soldesk.healthproject.service.MemberService;
import com.soldesk.healthproject.service.TicketService;

@Controller
@RequestMapping("/ticket")
public class TicketController {
	private TicketService ticketService;
	
	public TicketController(TicketService ticketService) {
		this.ticketService = ticketService;
		System.out.println("ticketService의 모든 필드 초기화 생성자");
	}
	
	//회원권 목록 조회 GET
	@GetMapping("/list")
	public void showTicketList(Model model) {
		model.addAttribute("ticketList", ticketService.getTicketList());
	}
	
	//특정 회원권 조회 GET
	@GetMapping("/detail")
	public String showTicketDetail(@RequestParam("ticket_number") String ticket_number,
								   Model model) {
		model.addAttribute("ticket", ticketService.getTicket(ticket_number));
	
		return "ticket/detail";
	}
	
	//회원권 등록페이지 호출 GET
	@GetMapping("/register")
	public void showTicketRegister() {
	}
	
	//회원권 등록 POST
	@PostMapping("/register")
	public String registerTicket(TicketVO ticket, RedirectAttributes redirectAttr) {
		
		String ticket_number = ticketService.registerTicket(ticket);
		
		redirectAttr.addFlashAttribute("result", ticket_number);
		
		return "redirect:/ticket/list";
	}
	
	//회원권 구매 페이지 이동 GET
	@GetMapping("/buy")
	public String showTicketBuy(@RequestParam("ticket_number") String ticket_number,
			   Model model) {
	model.addAttribute("ticket", ticketService.getTicket(ticket_number));
	
	return "ticket/buy";
	}
	
	//회원권 구매 POST
	@PostMapping("/buy")
	public String buyTicket(MemberVO member, RedirectAttributes redirectAttr) {
		
		ticketService.setMemberTicket(member);
		
		return "redirect:/";
	}
	
	//회원권 수정-삭제 페이지 호출 GET
	@GetMapping("/modify")
	public String showTicketModify(@RequestParam("ticket_number") String ticket_number,
								   Model model) {
		model.addAttribute("ticket", ticketService.getTicket(ticket_number));
	
		return "ticket/modify";
	}
	
	//회원권 수정 POST
	@PostMapping("/modify")
	public String modifyTicket(TicketVO ticket, RedirectAttributes redirectAttr) {
		ticketService.modifyTicket(ticket);
		
		return "redirect:/ticket/detail?ticket_number=" + ticket.getTicket_number();
	}
	
	//회원권 삭제 POST
	@PostMapping("/remove")
	public String removeTicket(@RequestParam("ticket_number") String ticket_number, 
								RedirectAttributes redirectAttr) {
		ticketService.removeTicket(ticket_number);
		
		return "redirect:/ticket/list" ;
	}
	
	
}
