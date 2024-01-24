package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.domain.FreeBoardVO;
import com.soldesk.healthproject.service.FreeBoardService;


@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {
//	@Setter(onMethod_ = @Autowired )
	private FreeBoardService freeBoardService ;
	
	//(단일 생성자를 이용한 주입: 생성자가 여러개 이고, 기본 생성자가 포함되어 있으면, 무조건 기본 생성자를 사용함)
	public FreeBoardController(FreeBoardService freeBoardService) {
		this.freeBoardService = freeBoardService ;
	}
	
    //게시물 조회(페이징 고려)
	@GetMapping("/list")
	public String showBoardList(BoardPagingDTO freeboardPaging,  
							    Model model) {
		FreeBoardPagingCreatorDTO pagingCreator =  freeBoardService.getBoardList(freeboardPaging) ;
		
		model.addAttribute("pagingCreator", pagingCreator) ;
		
		return "/freeBoard/list" ;
	}

	//등록 페이지 호출 GET /freeBoard/register
	@GetMapping("/register")
	public void showFreeBoardRegisterPage() {
		System.out.println("컨트롤러 - 게시물 등록 페이지 호출");
	}
	
	//등록 처리 POST /freeBoard/register 
	@PostMapping("/register")
	public String registerNewFreeBoard(FreeBoardVO freeBoard, RedirectAttributes redirectAttr) {
		long fpost_number = freeBoardService.registerFreeBoard(freeBoard);
		
		redirectAttr.addFlashAttribute("result", fpost_number);
		
		return "redirect:/freeBoard/list";
	}


	//특정 게시물 조회 GET /freeBoard/detail 
	@GetMapping("/detail")
	public String showFreeBoardDetail(@RequestParam("fpost_number") Long fpost_number,
									  BoardPagingDTO boardPaging,
			 						  Model model){
		model.addAttribute("freeBoard", freeBoardService.getFreeBoard(fpost_number));
		model.addAttribute("boardPaging", boardPaging);
		
		return "freeBoard/detail";
	}
	
	//특정 게시물 수정삭제 페이지 호출 GET /freeBoard/modify 
	@GetMapping("/modify")
	public String showFreeBoardModify(@RequestParam("fpost_number") Long fpost_number,
			   Model model){
		model.addAttribute("freeBoard", freeBoardService.getFreeBoard(fpost_number));
		
		return "freeBoard/modify";
	}
	
	//특정 게시물 수정 POST /freeBoard/modify 
	@PostMapping("/modify")
	public String modifyFreeBoard(FreeBoardVO freeBoard, RedirectAttributes redirectAttr) {
		if(freeBoardService.modifyFreeBoard(freeBoard)) {
			redirectAttr.addFlashAttribute("result", "succesModify");
		}
		
		return "redirect:/freeBoard/detail?fpost_number=" + freeBoard.getFpost_number();
	}
	
	//특정 게시물 삭제 POST /freeBoard/remove
	@PostMapping("/remove")
	public String removeBoard(@RequestParam("fpost_number") Long fpost_number, 
							   RedirectAttributes redirectAttr) {
		
		if(freeBoardService.setFreeBoardDeleted(fpost_number)) {
			redirectAttr.addFlashAttribute("result", "succesRemove");
		}
		
		return "redirect:/freeBoard/list";
	}

}
