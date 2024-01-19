package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingDTO;
import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.service.FreeBoardService;
import com.soldesk.healthproject.service.MemberService;
import com.soldesk.healthproject.service.NoticeBoardService;
import com.soldesk.healthproject.service.ProductService;
import com.soldesk.healthproject.service.TicketService;
import com.soldesk.healthproject.service.WorkoutService;

@Controller
@RequestMapping("/member")
public class MemberController {
	private MemberService memberService;
	private NoticeBoardService noticeBoardService;
	private FreeBoardService freeBoardService;
	private TicketService ticketService;
	private ProductService productService;
	private WorkoutService workoutService;
	
	public MemberController(MemberService memberService,
							NoticeBoardService noticeBoardService,
							FreeBoardService freeBoardService,
							TicketService ticketService,
							ProductService productService,
							WorkoutService workoutService) {
		this.memberService = memberService;
		this.noticeBoardService = noticeBoardService;
		this.freeBoardService = freeBoardService;
		this.ticketService = ticketService;
		this.productService = productService;
		this.workoutService = workoutService;
	}
	
	//회원 목록 조회
	@GetMapping("/list")
	public void showMemberList(Model model) {
		model.addAttribute("memberList", memberService.getMemberList());
	}
	
	//특정 회원 조회
	@GetMapping("/detail")
	public String showTicketDetail(@RequestParam("member_id") String member_id,
								   Model model) {
		model.addAttribute("member", memberService.getMember(member_id));
	
		return "member/detail";
	}
	
	//회원 등록
	@GetMapping("/memberRegister")
	public void showMemberRegisterPage() {
	}
	
	@PostMapping("/memberRegister")
	public String memberRegister(MemberVO member, Model model, 
								 NoticeBoardPagingDTO noticeBoardPaging, 
								 FreeBoardPagingDTO freeBoardPaging) {
		
		memberService.registerMember(member);
		
		NoticeBoardPagingCreatorDTO noticeBoard = noticeBoardService.getBoardList(noticeBoardPaging);
		FreeBoardPagingCreatorDTO freeBoard = freeBoardService.getBoardList(freeBoardPaging);
		
		model.addAttribute("noticeBoard", noticeBoard);
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("ticket", ticketService.getTicketList());
		model.addAttribute("product", productService.getProductList());
		model.addAttribute("workoutList", workoutService.getWorkoutList());
		
		return "myboard/main";
	}
	
	//회원 수정
	@GetMapping("/modify")
	public String showMemberModifyPage(@RequestParam("member_id") String member_id,
									 Model model) {
		model.addAttribute("member", memberService.getMember(member_id));
		
		return "member/modify";
	}
	
	@PostMapping("/modify")
	public String memberModify(MemberVO member, RedirectAttributes redirectAttr) {
		
		memberService.modifyMember(member);
		return "redirect:/member/detail?member_id="+ member.getMember_id();
	}
	
	//회원 탈퇴(delete_flag = 'Y')
	@PostMapping("/delete")
	public String deleteMember(String member_id) {
		memberService.setMemberDelete(member_id);
		
		return "myboard/main";
	}
	
	//회원 삭제(DB에서 삭제)
	@PostMapping("/remove")
	public String removeMember(String member_id) {
		memberService.removeMemberAuthority(member_id);
		memberService.removeMember(member_id);
		
		return "member/list";
	}
	
	
}
