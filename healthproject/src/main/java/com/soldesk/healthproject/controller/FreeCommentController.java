package com.soldesk.healthproject.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.soldesk.healthproject.common.paging.domain.FreeCommentPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.FreeCommentPagingDTO;
import com.soldesk.healthproject.domain.FreeCommentVO;
import com.soldesk.healthproject.service.FreeCommentService;

@RestController
@RequestMapping("/freeComment")
public class FreeCommentController {
	
	private FreeCommentService freeCommentService ;

	public FreeCommentController(FreeCommentService freeCommentService) {
		this.freeCommentService = freeCommentService;
	}
	
	//게시물에 대한 댓글 목록 조회	
//	@GetMapping("/list") 
//	public void showFreeCommentList(Model model){
//		model.addAttribute("freeCommentList", freeCommentService.getFreeCommentList());
//	}
	
	//게시물에 대한 댓글 목록 조회(페이징 고려)
	@GetMapping(value= "/{fpost_number}/page/{freePageNum}",
				produces = {"application/json;charset=utf-8", "application/xml;charset=utf-8"})
	
	public ResponseEntity<FreeCommentPagingCreatorDTO> showFreeCommentList(@PathVariable("fpost_number") Long fpost_number,
																		   @PathVariable("freePageNum") Integer freePageNum) {
	
		FreeCommentPagingCreatorDTO freeCommentPagingCreator =
				freeCommentService.getFreeCommentList(new FreeCommentPagingDTO(fpost_number, freePageNum));
		
		ResponseEntity<FreeCommentPagingCreatorDTO> freeResponseEntity =
				new ResponseEntity<FreeCommentPagingCreatorDTO>(freeCommentPagingCreator, HttpStatus.OK);
		
		return freeResponseEntity;
	}
	
	
	//게시물에 대한 댓글 등록(fcomment_number 반환) POST 		/{fpost_number}/new
	@PostMapping(value = "/{fpost_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerFreeCommentForFreeBoard(@PathVariable("fpost_number") long fpost_number ,
																  @RequestBody FreeCommentVO fcomment) {
		Long registered_fcomment_number = freeCommentService.registerFreeCommentForFreeBoard(fcomment);
		String _registered_fcomment_number = null ;
		
		if (registered_fcomment_number != null) {
			_registered_fcomment_number = String.valueOf(registered_fcomment_number) ;
			
		} else {
			_registered_fcomment_number = String.valueOf(registered_fcomment_number) ;
		}
		
		System.out.println("_registered_fcomment_number: " + _registered_fcomment_number);
		
		return registered_fcomment_number != null ? new ResponseEntity<String>(_registered_fcomment_number, HttpStatus.OK) 
										  : new ResponseEntity<String>(_registered_fcomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//댓글의 답글 등록(fcomment_number 반환) POST 	/{fpost_number}/new
	@PostMapping(value = "/{fpost_number}/{fcomment_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerFreeCommentForFreeComment(@PathVariable("fpost_number") long fpost_number ,
														@PathVariable("fcomment_number") long fcomment_number,
													    @RequestBody FreeCommentVO fcomment) {
	Long registered_fcomment_number = freeCommentService.registerFreeCommentForFreeComment(fcomment);
	String _registered_fcomment_number = null ;
	
	if (registered_fcomment_number != null) {
		_registered_fcomment_number = String.valueOf(registered_fcomment_number) ;
		
	} else {
		_registered_fcomment_number = String.valueOf(registered_fcomment_number) ;
	}
	
	System.out.println("_registered_fcomment_number: " + _registered_fcomment_number);
	
	return registered_fcomment_number != null ? new ResponseEntity<String>(_registered_fcomment_number, HttpStatus.OK) 
								 	  : new ResponseEntity<String>(_registered_fcomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
}
	
//게시물에 대한 특정 댓글 조회 GET 	
	@GetMapping(value="/{fpost_number}/{fcomment_number}" , 
				produces = "application/json;charset=utf-8")
	public FreeCommentVO showFreeComment(@PathVariable("fpost_number") Long fpost_number,
							   @PathVariable("fcomment_number") Long fcomment_number){

		return freeCommentService.getFreeComment(fpost_number, fcomment_number) ;
	}
	

//게시물에 대한 특정 댓글 수정 PUT 또는 PATCH 		/{fpost_number}/{fcomment_number}
	//Ajax에서의 요청 URI:
	@RequestMapping(value="/{fpost_number}/{fcomment_number}" , 
					method = {RequestMethod.PUT, RequestMethod.PATCH} ,
					consumes = "application/json;charset=utf-8" ,
					produces = "text/plain;charset=utf-8") 
//	@PreAuthorize()
	public String modifyFreeComment(@PathVariable("fpost_number") Long fpost_number ,
							  @PathVariable("fcomment_number") Long fcomment_number ,
							  @RequestBody FreeCommentVO fcomment){
		System.out.println("컨트롤러에 전달된 fcomment: " + fcomment);
		
		if(freeCommentService.modifyFreeComment(fcomment)) {
			return "modifySuccess" ;
		} else {
			return "modifyFail" ;	
		}
	}
	
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)	/{fpost_number}/{fcomment_number}
	@DeleteMapping(value = "/{fpost_number}/{fcomment_number}" ,
				   consumes = "application/json; charset=utf-8",
				   produces = "text/plain;charset=utf-8")
//	@PreAuthorize()
	public ResponseEntity<String> removeFreeComment(@PathVariable("fpost_number") Long fpost_number, 
											  		@PathVariable("fcommnet_number") Long fcomment_number,
											  		@RequestBody FreeCommentVO fcomment) {
		
		return freeCommentService.modifyFcommentDeleteFlag(fpost_number, fcomment_number)  
			   ? new ResponseEntity<String>("removeSuccess", HttpStatus.OK)
			   : new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR) ;
	}
	
	
//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@DeleteMapping(value = "/{fpost_number}" , produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> removeAllFreeComment(@PathVariable("fpost_number") Long fpost_number){
		
		int deleteRows = freeCommentService.removeAllFreeComment(fpost_number) ;
		
		return new ResponseEntity<String>(String.valueOf(deleteRows), HttpStatus.OK) ;
	}

}
