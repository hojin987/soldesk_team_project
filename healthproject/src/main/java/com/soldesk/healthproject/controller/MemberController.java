package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.service.MemberRegisterService;

@Controller
@RequestMapping("/user")
public class MemberController {
	private MemberRegisterService memberRegisterService;
	
	public MemberController(MemberRegisterService memberRegisterService) {
		this.memberRegisterService = memberRegisterService;
		System.out.println("memberRegisterService의 모든 필드 초기화 생성자");
	}
	
	//회원 조회
//	public void showMember() {
//		
//	}
	
	//회원 등록
	@GetMapping("/memberRegister")
	public void showMemberRegisterPage() {
		System.out.println("컨트롤러 - 회원등록 페이지 호출");
	}
	
	@PostMapping("/memberRegister")
	public String memberRegister(MemberVO member, RedirectAttributes redirectAttr) {
		String member_id = memberRegisterService.registerMember(member);
		
		redirectAttr.addFlashAttribute("result", member_id);
		
		System.out.println("<<<<<<<<<<<회원등록>>>>>>>>>>>");
		
		return "myboard/main";
	}
	
	
}
