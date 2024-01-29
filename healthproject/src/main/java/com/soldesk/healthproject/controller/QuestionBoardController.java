package com.soldesk.healthproject.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.common.paging.domain.QuestionBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.domain.QuestionBoardVO;
import com.soldesk.healthproject.service.QuestionBoardService;

@Controller
@RequestMapping("/questionBoard")
public class QuestionBoardController {
//	@Setter(onMethod_ = @Autowired )
	private QuestionBoardService questionBoardService ;
	
	//(단일 생성자를 이용한 주입: 생성자가 여러개 이고, 기본 생성자가 포함되어 있으면, 무조건 기본 생성자를 사용함)
	public QuestionBoardController(QuestionBoardService questionBoardService) {
		this.questionBoardService = questionBoardService ;
		System.out.println("QuestionBoardController의 모든 필드 초기화 생성자 입니다.");
	}
	
    //게시물 조회(페이징 고려)
	@GetMapping("/list")
	public String showBoardList(BoardPagingDTO questionboardPaging,  
							    Model model) {
		System.out.println("questionboardPaging: " + questionboardPaging);
		QuestionBoardPagingCreatorDTO pagingCreator =  questionBoardService.getBoardList(questionboardPaging) ;
		System.out.println("컨트롤러에 전달된 questionboardPagingCreator: \n" + pagingCreator);
		
		model.addAttribute("pagingCreator", pagingCreator) ;
		
		return "questionBoard/list" ;
	}
	

	//등록 페이지 호출 GET /questionBoard/register
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void showQuestionBoardRegisterPage() {
		System.out.println("컨트롤러 - 게시물 등록 페이지 호출");
	}
	
	//등록 처리 POST /questionBoard/register 
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String registerNewQuestionBoard(QuestionBoardVO questionBoard, RedirectAttributes redirectAttr) {
		long qpost_number = questionBoardService.registerQuestionBoard(questionBoard);
		
		redirectAttr.addFlashAttribute("result", qpost_number);
		
		return "redirect:/questionBoard/list";
	}
	
	//특정 게시물 조회 GET /questionBoard/detail 
	@GetMapping("/detail")
	public String showQuestionBoardDetail(@RequestParam("qpost_number") Long qpost_number,
										  BoardPagingDTO boardPaging,
			 						      Model model){
		
		model.addAttribute("questionBoard", questionBoardService.getQuestionBoard(qpost_number));
		model.addAttribute("boardPaging", boardPaging);
		
		return "questionBoard/detail";
	}
	
	//특정 게시물 수정삭제 페이지 호출 GET /questionBoard/modify
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public String showQuestionBoardModify(@RequestParam("qpost_number") Long qpost_number,
			   Model model){
		model.addAttribute("questionBoard", questionBoardService.getQuestionBoard(qpost_number));
		
		return "questionBoard/modify";
	}
	
	//특정 게시물 수정 POST /questionBoard/modify
	@PreAuthorize("isAuthenticated() && principal.username == #questionBoard.qwriter")
	@PostMapping("/modify")
	public String modifyQuestionBoard(QuestionBoardVO questionBoard, RedirectAttributes redirectAttr) {
		if(questionBoardService.modifyQuestionBoard(questionBoard)) {
			redirectAttr.addFlashAttribute("result", "succesModify");
		}
		
		return "redirect:/questionBoard/detail?qpost_number=" + questionBoard.getQpost_number();
	}
	
	//특정 게시물 삭제 POST /questionBoard/remove
	@PreAuthorize("isAuthenticated() && principal.username == #questionBoard.qwriter")
	@PostMapping("/remove")
	public String removeBoard(@RequestParam("qpost_number") Long qpost_number, 
							   RedirectAttributes redirectAttr) {
		
		if(questionBoardService.setQuestionBoardDeleted(qpost_number)) {
			redirectAttr.addFlashAttribute("result", "succesRemove");
		}
		
		return "redirect:/questionBoard/list";
	}

}
