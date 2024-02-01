package com.soldesk.healthproject.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.domain.ApplyAttachFileVO;
import com.soldesk.healthproject.domain.ApplyBoardVO;
import com.soldesk.healthproject.domain.FreeBoardVO;
import com.soldesk.healthproject.service.ApplyBoardService;

@Controller
@RequestMapping("/applyBoard")
public class ApplyBoardController {
	private ApplyBoardService applyBoardService ;
	
	//(단일 생성자를 이용한 주입: 생성자가 여러개 이고, 기본 생성자가 포함되어 있으면, 무조건 기본 생성자를 사용함)
	public ApplyBoardController(ApplyBoardService applyBoardService) {
		this.applyBoardService = applyBoardService ;
	}
	
    //게시물 조회(페이징 고려)
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public String showBoardList(BoardPagingDTO applyboardPaging,  
							    Model model) {
		ApplyBoardPagingCreatorDTO pagingCreator =  applyBoardService.getBoardList(applyboardPaging) ;
		
		model.addAttribute("pagingCreator", pagingCreator) ;
		
		return "applyBoard/list" ;
	}
	

	//등록 페이지 호출 GET /applyBoard/register
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void showApplyBoardRegisterPage() {
	}
	
	//등록 처리 POST /applyBoard/register
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String registerNewApplyBoard(ApplyBoardVO applyBoard, RedirectAttributes redirectAttr) {
		
		List<ApplyAttachFileVO> attachFileList = applyBoard.getAttachFileList() ;
		
		if(attachFileList != null) {
			attachFileList
				   .forEach(applyAttachFile -> System.out.println(applyAttachFile.toString())) ;
		} else {
		}
		
		long apost_number = applyBoardService.registerApplyBoard(applyBoard);
		
		redirectAttr.addFlashAttribute("result", apost_number);
		
		return "redirect:/applyBoard/list";
	}
	
	//특정 게시물 조회 GET /applyBoard/detail
	@GetMapping("/detail")
	public String showApplyBoardDetail(@RequestParam("apost_number") Long apost_number,
									   BoardPagingDTO boardPaging,
									   Model model){
		model.addAttribute("applyBoard", applyBoardService.getApplyBoard(apost_number));
		model.addAttribute("boardPaging", boardPaging);
		
		return "applyBoard/detail";
	}
	
	//특정 게시물 수정삭제 페이지 호출 GET /applyBoard/modify
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public String showApplyBoardModify(@RequestParam("apost_number") Long apost_number,
			   Model model){
		model.addAttribute("applyBoard", applyBoardService.getApplyBoard(apost_number));
		
		return "applyBoard/modify";
	}
	
	//특정 게시물 수정 POST /applyBoard/modify 
	@PreAuthorize("isAuthenticated() && principal.username == #applyBoard.awriter")
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
		
		//첨부파일 정보를 저장할 리스트 객체 생성
		List<ApplyAttachFileVO> attachFileList = applyBoardService.getAttachFileList(apost_number); //추가
		
		if(applyBoardService.setApplyBoardDeleted(apost_number)) {
			removeAttachFiles(attachFileList);
			redirectAttr.addFlashAttribute("result", "succesRemove");
			
		} else { 
			redirectAttr.addFlashAttribute("result", "failRemove");
		}
		
		return "redirect:/applyBoard/list";
	}
	
	//특정 게시물의 조회 페이지 호출 후, 특정 게시물의 첨부파일 정보를 JSON으로 전달
	@GetMapping(value = "/getFiles", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public ResponseEntity<List<ApplyAttachFileVO>> showAttachFiles(long apost_number){
		
		return new ResponseEntity<List<ApplyAttachFileVO>>(applyBoardService.getAttachFileList(apost_number), HttpStatus.OK);
	}
	
	//게시물의 모든 첨부파일을 서버에서 삭제
	private void removeAttachFiles(List<ApplyAttachFileVO> attachFileList) {
		
		if(attachFileList == null || attachFileList.size() == 0) {
			return;
		}
		
		attachFileList
		.forEach(attachFile -> {
			try {
				Path file = Paths.get(attachFile.getRepoPath() + "/" + //"C:\\upload\\" +
									  attachFile.getUploadPath() + "/" +
									  attachFile.getUuid() + "_" +
									  attachFile.getFileName() );
				Files.deleteIfExists(file);
		
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get( attachFile.getRepoPath() + "/" + //"C:\\upload\\" +
												attachFile.getUploadPath() + "/s_" +
												attachFile.getUuid() + "_" +
												attachFile.getFileName() );
					Files.delete(thumbNail);
				}
			} catch(Exception e) {
				
				}//end catch
		});//end forEach
	}//end Method
	
	//게시물 실제삭제
	@PreAuthorize("isAuthenticated() && hasAuthority('ADMIN') ")
	@PostMapping("/erase")
	public String eraseBoard(@RequestParam("apost_number") Long apost_number, ApplyBoardVO applyBoard) {
		
		applyBoardService.removeApplyBoard(apost_number);
		
		return "redirect:/applyBoard/list";
	}
	
}
