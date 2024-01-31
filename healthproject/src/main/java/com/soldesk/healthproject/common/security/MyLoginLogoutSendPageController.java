package com.soldesk.healthproject.common.security;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.soldesk.healthproject.service.MemberService;

@Controller
public class MyLoginLogoutSendPageController {
	private MemberService memberService;
	
	public MyLoginLogoutSendPageController(MemberService memberService) {
		this.memberService = memberService;
	}

	@GetMapping("/myLogin")
	public String sendLoginPage(String error, String logout, Model model) {
		
		if(error != null) {
	        model.addAttribute("error", "로그인오류. 계정명 또는 암호를 확인하세요");
	           
		} else if(logout != null) {
			model.addAttribute("logout", "정상적으로 로그아웃 됨.") ;
		
		} else {
			model.addAttribute("normal", "사용자가 로그인 페이지 호출") ;
		}
		
		return "common/myLogin" ; 
	}
	
	@GetMapping("/myLogout")
	public String sendLogoutPage() {
		
		return "common/myLogout";
	}
}
