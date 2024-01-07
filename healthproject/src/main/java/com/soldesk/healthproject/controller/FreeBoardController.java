package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingDTO;
import com.soldesk.healthproject.service.FreeBoardService;

@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {
	
//	@Setter(onMethod_ = @Autowired )
	private FreeBoardService freeBoardService ;
	
	//(단일 생성자를 이용한 주입: 생성자가 여러개 이고, 기본 생성자가 포함되어 있으면, 무조건 기본 생성자를 사용함)
	public FreeBoardController(FreeBoardService freeBoardService) {
		this.freeBoardService = freeBoardService ;
		System.out.println("FreeBoardController의 모든 필드 초기화 생성자 입니다.");
	}
	
    //게시물 조회(페이징 고려)
	@GetMapping("/list")
	public String showBoardList(FreeBoardPagingDTO freeboardPaging,  
							    Model model) {
		System.out.println("freeboardPaging: " + freeboardPaging);
		FreeBoardPagingCreatorDTO pagingCreator =  freeBoardService.getBoardList(freeboardPaging) ;
		System.out.println("컨트롤러에 전달된 freeboardPagingCreator: \n" + pagingCreator);
		
		model.addAttribute("pagingCreator", pagingCreator) ;
		
		return "freeboard/list" ;
	}

}
	