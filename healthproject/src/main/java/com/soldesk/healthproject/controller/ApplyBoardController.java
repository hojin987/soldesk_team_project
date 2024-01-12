package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingDTO;
import com.soldesk.healthproject.domain.ApplyBoardVO;
import com.soldesk.healthproject.service.ApplyBoardService;

@Controller
@RequestMapping("/applyBoard")
public class ApplyBoardController {
	private ApplyBoardService applyBoardService ;
	
	//(단일 생성자를 이용한 주입: 생성자가 여러개 이고, 기본 생성자가 포함되어 있으면, 무조건 기본 생성자를 사용함)
	public ApplyBoardController(ApplyBoardService applyBoardService) {
		this.applyBoardService = applyBoardService ;
		System.out.println("ApplyBoardController의 모든 필드 초기화 생성자 입니다.");
	}
	
    //게시물 조회(페이징 고려)
	@GetMapping("/list")
	public String showBoardList(ApplyBoardPagingDTO applyboardPaging,  
							    Model model) {
		System.out.println("applyboardPaging: " + applyboardPaging);
		ApplyBoardPagingCreatorDTO pagingCreator =  applyBoardService.getBoardList(applyboardPaging) ;
		System.out.println("컨트롤러에 전달된 applyboardPagingCreator: \n" + pagingCreator);
		
		model.addAttribute("pagingCreator", pagingCreator) ;
		
		return "applyBoard/list" ;
	}
	

	//등록 페이지 호출 GET /applyBoard/register
	@GetMapping("/register")
	public void showApplyBoardRegisterPage() {
		System.out.println("컨트롤러 - 게시물 등록 페이지 호출");
	}
	
	//등록 처리 POST /applyBoard/register 
	@PostMapping("/register")
	public String registerNewApplyBoard(ApplyBoardVO applyBoard, RedirectAttributes redirectAttr) {
		long apost_number = applyBoardService.registerApplyBoard(applyBoard);
		
		redirectAttr.addFlashAttribute("result", apost_number);
		
		return "redirect:/applyBoard/list";
	}
	
	//특정 게시물 조회 GET /applyBoard/detail 
	@GetMapping("/detail")
	public String showApplyBoardDetail(@RequestParam("apost_number") Long apost_number,
			 						   Model model){
		model.addAttribute("applyBoard", applyBoardService.getApplyBoard(apost_number));
		
		return "applyBoard/detail";
	}
	
	//특정 게시물 수정삭제 페이지 호출 GET /applyBoard/modify 
	@GetMapping("/modify")
	public String showApplyBoardModify(@RequestParam("apost_number") Long apost_number,
			   Model model){
		model.addAttribute("applyBoard", applyBoardService.getApplyBoard(apost_number));
		
		return "applyBoard/modify";
	}
	
	//특정 게시물 수정 POST /applyBoard/modify 
	@PostMapping("/modify")
	public String modifyApplyBoard(ApplyBoardVO applyBoard, RedirectAttributes redirectAttr) {
		if(applyBoardService.modifyApplyBoard(applyBoard)) {
			redirectAttr.addFlashAttribute("result", "succesModify");
		}
		
		return "redirect:/applyBoard/detail?apost_number=" + applyBoard.getApost_number();
	}
	
	//특정 게시물 삭제 POST /applyBoard/remove
	@PostMapping("/remove")
	public String removeBoard(@RequestParam("apost_number") Long apost_number, 
							   RedirectAttributes redirectAttr) {
		
		if(applyBoardService.setApplyBoardDeleted(apost_number)) {
			redirectAttr.addFlashAttribute("result", "succesRemove");
		}
		
		return "redirect:/applyBoard/list";
	}
	

}
