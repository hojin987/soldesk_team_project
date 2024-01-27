package com.soldesk.healthproject.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingCreatorDTO;
import com.soldesk.healthproject.domain.NoticeBoardVO;
import com.soldesk.healthproject.service.NoticeBoardService;

@Controller
@RequestMapping("/noticeBoard")
public class NoticeBoardController {
	private NoticeBoardService noticeBoardService;
	
	public NoticeBoardController(NoticeBoardService noticeBoardService) {
		this.noticeBoardService = noticeBoardService;
		System.out.println("NoticeBoardController의 모든 필드 초기화 생성자 입니다.");
	}
    //게시물 조회(페이징 고려)
	@GetMapping("/list")
	public String showBoardList(BoardPagingDTO noticeboardPaging,  
							    Model model) {
		System.out.println("noticeboardPaging: " + noticeboardPaging);
		NoticeBoardPagingCreatorDTO pagingCreator =  noticeBoardService.getBoardList(noticeboardPaging) ;
		System.out.println("컨트롤러에 전달된 noticeboardPagingCreator: \n" + pagingCreator);
		
		model.addAttribute("pagingCreator", pagingCreator) ;
		
		return "noticeBoard/list" ;
	}
	
	//등록 페이지 호출 GET /noticeboard/register
	@GetMapping("/register")
	public void showNoticeBoardRegisterPage() {
		System.out.println("컨트롤러 - 게시물 등록 페이지 호출");
	}
	
	//등록 처리 POST /noticeboard/register 
	@PostMapping("/register")
	public String registerNewNoticeBoard(NoticeBoardVO noticeBoard, RedirectAttributes redirectAttr) {
		long npost_number = noticeBoardService.registerNoticeBoard(noticeBoard);
		
		redirectAttr.addFlashAttribute("result", npost_number);
		
		return "redirect:/noticeBoard/list";
	}
	
	//특정 게시물 조회 GET /myboard/detail 
	@GetMapping("/detail")
	public String showNoticeBoardDetail(@RequestParam("npost_number") Long npost_number,
										BoardPagingDTO boardPaging,
			 						    Model model){
		
		model.addAttribute("noticeBoard", noticeBoardService.getNoticeBoard(npost_number));
		model.addAttribute("boardPaging", boardPaging);
		
		return "noticeBoard/detail";
	}
	
	//특정 게시물 수정삭제 페이지 호출 GET /myboard/modify 
	@GetMapping("/modify")
	public String showNoticeBoardModify(@RequestParam("npost_number") Long npost_number,
			   Model model){
		model.addAttribute("noticeBoard", noticeBoardService.getNoticeBoard(npost_number));
		
		return "noticeBoard/modify";
	}
	
	//특정 게시물 수정 POST /myboard/modify
	@PreAuthorize("isAuthenticated() && principal.username == #applyBoard.awriter")
	@PostMapping("/modify")
	public String modifyNoticeBoard(NoticeBoardVO noticeBoard, RedirectAttributes redirectAttr) {
		if(noticeBoardService.modifyNoticeBoard(noticeBoard)) {
			redirectAttr.addFlashAttribute("result", "succesModify");
		}
		
		return "redirect:/noticeBoard/detail?npost_number=" + noticeBoard.getNpost_number();
	}
	
	//특정 게시물 삭제 POST /myboard/remove
	@PostMapping("/remove")
	public String removeBoard(@RequestParam("npost_number") Long npost_number, 
							   RedirectAttributes redirectAttr) {
		
		if(noticeBoardService.setNoticeBoardDeleted(npost_number)) {
			redirectAttr.addFlashAttribute("result", "succesRemove");
		}
		
		return "redirect:/noticeBoard/list";
	}
	
	
}
