package com.soldesk.healthproject.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.MemberPagingCreatorDTO;
import com.soldesk.healthproject.domain.AuthorityVO;
import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.domain.TrainerVO;
import com.soldesk.healthproject.service.MemberService;
import com.soldesk.healthproject.service.TrainerService;

@Controller
@RequestMapping("/member")
public class MemberController {
	private MemberService memberService;
	private TrainerService trainerService;
	
	public MemberController(MemberService memberService,
							TrainerService trainerService) {
		this.memberService = memberService;
		this.trainerService = trainerService;
	}
	
	//회원 목록 조회
//	@PreAuthorize("isAuthenticated() && principal.username == 'admin' ")
	@GetMapping("/list")
	public String showMemberList(Model model, BoardPagingDTO memberPaging) {
		MemberPagingCreatorDTO pagingCreator = memberService.getMemberList(memberPaging);
		model.addAttribute("pagingCreator", pagingCreator);
		
		return "member/list";
	}
	
	//특정 회원 조회
	@GetMapping("/detail")
	public String showTicketDetail(@RequestParam("member_id") String member_id,
								   BoardPagingDTO boardPaging,
								   Model model) {
		model.addAttribute("member", memberService.getMember(member_id));
		model.addAttribute("boardPaging", boardPaging);
	
		return "member/detail";
	}
	
	//회원 등록
	@GetMapping("/memberRegister")
	public void showMemberRegisterPage() {
	}
	
	@PostMapping("/memberRegister")
	public String memberRegister(MemberVO member) {
		
		memberService.registerMember(member);
		return "redirect:/";
	}
	
	//강사 권한 부여
//	@PreAuthorize("isAuthenticated() && principal.username == 'admin' ")
	@PostMapping("/auth")
	public String registerAuth(MemberVO member) {
		
		memberService.registerTrainerAuthority(member);
		
		return "redirect:/member/list";
	}
	
	//강사 권한 삭제
//	@PreAuthorize("isAuthenticated() && principal.username == 'admin' ")
	@PostMapping("/authcancel")
	public String removeAuth(MemberVO member) {
		
		memberService.removeTrainerAuthority(member);
		
		return "redirect:/member/list";
	}
	
	//회원 수정페이지 호출
	@GetMapping("/modify")
	public String showMemberModifyPage(@RequestParam("member_id") String member_id,
									 Model model) {
		model.addAttribute("member", memberService.getMember(member_id));
		
		return "member/modify";
	}
	
	//회원 수정 처리
//	@PreAuthorize("isAuthenticated() && principal.username == #member.member_id ")
	@PostMapping("/modify")
	public String memberModify(MemberVO member, AuthorityVO authority) {
		
		memberService.modifyMember(member);
		return "redirect:/member/detail?member_id="+ member.getMember_id();
		
	}
	
	//회원 비밀번호수정 페이지 호출
	@GetMapping("/modifyPw")
	public String showMemberModifyPwPage(@RequestParam("member_id") String member_id,
									Model model) {
		model.addAttribute("member", memberService.getMember(member_id));
		
		return "member/modifyPw";
	}
	
	//회원 비밀번호수정 처리
//	@PreAuthorize("isAuthenticated() && principal.username == #member.member_id ")
	@PostMapping("/modifyPw")
	public String memberPwModify(MemberVO member, @RequestParam("current_pw") String current_pw,
												  @RequestParam("new_pw") String new_pw) {
		
		memberService.modifyMemberPw(member, current_pw, new_pw);
		
		return "redirect:/member/detail?member_id="+ member.getMember_id();
	}
	
	//회원 탈퇴(delete_flag = 'Y')
//	@PreAuthorize("isAuthenticated() && principal.username == #member.member_id ")
	@PostMapping("/delete")
	public String deleteMember(String member_id) {
		memberService.setMemberDelete(member_id);
		
		return "redirect:/";
	}
	
	//회원 탈퇴 취소(delete_flag = 'N')
//	@PreAuthorize("isAuthenticated() && principal.username == 'admin' ")
	@PostMapping("/cancel")
	public String cancelMember(String member_id) {
		memberService.setMemberCancel(member_id);
		
		return "redirect:/member/list";
	}
	
	//회원 삭제(DB에서 삭제)
//	@PreAuthorize("isAuthenticated() && principal.username == 'admin' ")
	@PostMapping("/remove")
	@Transactional
	public String removeMember(String member_id, Model model, 
							   BoardPagingDTO memberPaging) {
		
		trainerService.removeRecord(member_id);
		memberService.removeMemberAuthority(member_id);
		memberService.removeMember(member_id);
		
		MemberPagingCreatorDTO pagingCreator = memberService.getMemberList(memberPaging);
		model.addAttribute("pagingCreator", pagingCreator);
		
		return "redirect:/member/list";
	}
	
	
	//강사경력 관련 CRUD
	//트레이너 조회
	@GetMapping("/trainer")
	public String showTrainterList(Model model, BoardPagingDTO memberPaging) {
		
		memberPaging.setRowAmountPerPage(100);
		MemberPagingCreatorDTO pagingCreator = memberService.getMemberList(memberPaging);
		
		model.addAttribute("pagingCreator", pagingCreator);
		model.addAttribute("trainerRecord", trainerService.getTrainerRecordList());
		
		return "member/trainer";
	}
	
//	@PreAuthorize("isAuthenticated() && hasAnyAuthority('TRAINER', 'ADMIN') ")
	//강사 경력 등록페이지 호출
	@GetMapping("/recordRegister")
	public String showRecordRegisterPage() {
		return "member/recordRegister";
	}
	
	//강사 경력 등록
//	@PreAuthorize("isAuthenticated() && hasAnyAuthority('TRAINER', 'ADMIN') ")
	@PostMapping("/recordRegister")
	public String recordRegister(TrainerVO trainer) {
		trainerService.registerRecord(trainer);
		return "redirect:/member/trainer";
	}
	
	//강사 경력 수정페이지 호출
//	@PreAuthorize("isAuthenticated() && hasAnyAuthority('TRAINER', 'ADMIN') ")
	@GetMapping("/recordModify")
	public String showRecordModifyPage(@RequestParam("member_id") String member_id,
									   Model model) {
		TrainerVO trainerRecord = trainerService.getTrainerRecord(member_id);
		model.addAttribute("trainerRecord", trainerRecord);
		
		return "member/recordModify";
	}
	
	//강사 경력 수정
//	@PreAuthorize("isAuthenticated() && hasAnyAuthority('TRAINER', 'ADMIN') ")
	@PostMapping("/recordModify")
	public String recordModify(TrainerVO frmModify) {
		
		trainerService.modifyRecord(frmModify);
		return "redirect:/member/trainer";
	}
	
}
