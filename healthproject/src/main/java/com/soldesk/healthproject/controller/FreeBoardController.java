package com.soldesk.healthproject.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingDTO;
import com.soldesk.healthproject.domain.FreeBoardAttachFileVO;
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
	public String showBoardList(FreeBoardPagingDTO freeboardPaging,  
							    Model model) {
		FreeBoardPagingCreatorDTO pagingCreator =  freeBoardService.getBoardList(freeboardPaging) ;
		
		model.addAttribute("pagingCreator", pagingCreator) ;
		
		return "/freeBoard/list" ;
	}

//	//등록 페이지 호출 GET /freeBoard/register
//	@GetMapping("/register")
//	public void showFreeBoardRegisterPage() {
//		System.out.println("컨트롤러 - 게시물 등록 페이지 호출");
//	}
//	
//	//등록 처리 POST /freeBoard/register 
//	@PostMapping("/register")
//	public String registerNewFreeBoard(FreeBoardVO freeBoard, RedirectAttributes redirectAttr) {
//		long fpost_number = freeBoardService.registerFreeBoard(freeBoard);
//		
//		redirectAttr.addFlashAttribute("result", fpost_number);
//		
//		return "redirect:/freeBoard/list";
//	}
	
//	등록 페이지 호출
	@GetMapping("/register")
	public String showBoardRegisterPage() {
		System.out.println("등록페이지 호출.......");
		
		return "freeBoard/register" ;
	}


	//게시물 등록 처리
	
	@PostMapping("/register")
	public String registerNewBoard(FreeBoardVO freeboard,
			                       RedirectAttributes redirectAttr) {
		
		List<FreeBoardAttachFileVO> freeAttachFileList = freeboard.getAttachFileList() ;
		
		if(freeAttachFileList != null) {
			freeAttachFileList
				   .forEach(attachFile -> System.out.println(attachFile.toString())) ;
		} else {
			System.out.println("<<<<<<<<<<<<<<<<<<< 첨부파일 없음 >>>>>>>>>>>>>>>>>>>>>");
		}
		System.out.println();
		
		
		long fpost_number = freeBoardService.registerFreeBoard(freeboard) ;
		
		redirectAttr.addFlashAttribute("result", fpost_number) ;
		System.out.println("result: " + redirectAttr.getFlashAttributes());
		
		return "redirect:/freeBoard/list";
		
	}

	//특정 게시물 조회 페이지, 수정 후 조회 페이지
	@GetMapping("/detail")
	public String showBoardDetail(Long fpost_number, Model model, String result,
			 					  @ModelAttribute("freeboardPaging") FreeBoardPagingDTO freeboardPaging) {
		
		FreeBoardVO freeboard = null ;

		System.out.println("Detail.jsp-수정삭제 후: result: " + result) ;
		System.out.println("Detail.jsp-수정삭제 후: fpost_number: " + fpost_number);
		
		freeboard = freeBoardService.getFreeBoard(fpost_number, result) ;
		
		model.addAttribute("freeboard", freeboard) ;
		model.addAttribute("result", result) ;
		
		System.out.println("model: " + model);
		
		return "freeBoard/detail" ;
	}
	
	//특정 게시물 수정삭제 페이지 호출
	@GetMapping("/modify")
	@PreAuthorize("isAuthenticated() && principal.username == #freeboard.fwriter")
	public String showBoardModify(Long fpost_number, Model model, 
								  FreeBoardPagingDTO freeboardPaging) {
		FreeBoardVO freeboard = freeBoardService.getFreeBoard2(fpost_number) ;
		
		model.addAttribute("freeboard", freeboard) ;
			
		return "freeBoard/modify" ;
	}
	
//	특정 게시물 수정
	@PostMapping("/modify")
	@PreAuthorize("isAuthenticated() && principal.username == #myboard.bwriter")
	public String modifyBoard(FreeBoardVO freeboard,
						      RedirectAttributes redirectAttr,
						      FreeBoardPagingDTO freeboardPaging) {
		
		boolean modifyResult = freeBoardService.modifyFreeBoard(freeboard) ;
		
		if(modifyResult) {
			redirectAttr.addAttribute("result", "successModify") ;
			
		} else {
			redirectAttr.addAttribute("result", "failModify") ;
		}
		
		redirectAttr.addAttribute("fpost_number", freeboard.getFpost_number()) ;
		redirectAttr.addAttribute("pageNum", freeboardPaging.getPageNum());
		redirectAttr.addAttribute("rowAmountPerPage", freeboardPaging.getRowAmountPerPage()) ;
		redirectAttr.addAttribute("scope", freeboardPaging.getScope()) ;
		redirectAttr.addAttribute("keyword", freeboardPaging.getKeyword()) ;
		redirectAttr.addAttribute("beginDate", freeboardPaging.getBeginDate()) ;
		redirectAttr.addAttribute("endDate", freeboardPaging.getEndDate()) ;
		
		return "redirect:/freeBoard/detail" ;
	}
	
	
	
//	특정 게시물 삭제 POST /myboard/remove
	@PostMapping("/remove")
	@PreAuthorize("isAuthenticated() && principal.username == #freeboard.fwriter")
	public String removeBoard(FreeBoardVO freeboard,  
							  RedirectAttributes redirectAttr,
							  FreeBoardPagingDTO freeboardPaging ) {
		
		if (freeBoardService.modifyFdeleteFlag(freeboard.getFpost_number())) {  //게시물 블라인드처리 시 사용
			redirectAttr.addFlashAttribute("result","successRemove") ;
			
		} else {
			redirectAttr.addFlashAttribute("result","failRemove") ;
		}
		
		redirectAttr.addAttribute("pageNum", freeboardPaging.getPageNum()) ;
		redirectAttr.addAttribute("rowAmountPerPage", freeboardPaging.getRowAmountPerPage()) ;
		redirectAttr.addAttribute("scope", freeboardPaging.getScope()) ;
		redirectAttr.addAttribute("keyword", freeboardPaging.getKeyword()) ;
		redirectAttr.addAttribute("beginDate", freeboardPaging.getBeginDate()) ;
		redirectAttr.addAttribute("endDate", freeboardPaging.getEndDate()) ;
		
		return "redirect:/freeBoard/list" ;
	}
	
	
	//특정 게시물의 첨부파일 정보를 JSON으로 전달(특정 게시물의 수정페이지에서 사용) ###########################
	@GetMapping(value = "/getFiles" , produces = {"application/json; charset=utf-8"})
	public @ResponseBody ResponseEntity<List<FreeBoardAttachFileVO>> showAttachFiles(Long fpost_number) {
		return new ResponseEntity<List<FreeBoardAttachFileVO>>(freeBoardService.getAttachFileList(fpost_number), HttpStatus.OK);
	}

}
	