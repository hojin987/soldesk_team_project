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

import com.soldesk.healthproject.common.paging.domain.NoticeCommentPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeCommentPagingDTO;
import com.soldesk.healthproject.domain.NoticeCommentVO;
import com.soldesk.healthproject.service.NoticeCommentService;

@RestController
@RequestMapping("/noticeComment")
public class NoticeCommentController {
	
	private NoticeCommentService noticeCommentService ;

	public NoticeCommentController(NoticeCommentService noticeCommentService) {
		this.noticeCommentService = noticeCommentService;
	}
	
	//게시물에 대한 댓글 목록 조회(페이징 고려)
	@GetMapping(value= "/{npost_number}/page/{pageNum}",
				produces = {"application/json;charset=utf-8", "application/xml;charset=utf-8"})
	
	public ResponseEntity<NoticeCommentPagingCreatorDTO> showNoticeCommentList(@PathVariable("npost_number") long npost_number,
																		   @PathVariable("pageNum") Integer pageNum) {
	
		NoticeCommentPagingCreatorDTO noticeCommentPagingCreator =
				noticeCommentService.getNoticeCommentList(new NoticeCommentPagingDTO(npost_number, pageNum));
		
		ResponseEntity<NoticeCommentPagingCreatorDTO> noticeResponseEntity =
				new ResponseEntity<NoticeCommentPagingCreatorDTO>(noticeCommentPagingCreator, HttpStatus.OK);
		
		return noticeResponseEntity;
	}
	
	@PostMapping(value = "/{npost_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerNoticeCommentForNoticeBoard(@PathVariable("npost_number") long npost_number ,
																  @RequestBody NoticeCommentVO ncomment) {
		Long registered_ncomment_number = noticeCommentService.registerNoticeCommentForNoticeBoard(ncomment);
		String _registered_ncomment_number = null ;
		
		if (registered_ncomment_number != null) {
			_registered_ncomment_number = String.valueOf(registered_ncomment_number) ;
			
		} else {
			_registered_ncomment_number = String.valueOf(registered_ncomment_number) ;
		}
		
		
		return registered_ncomment_number != null ? new ResponseEntity<String>(_registered_ncomment_number, HttpStatus.OK) 
										  : new ResponseEntity<String>(_registered_ncomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글의 답글 등록(ncomment_number 반환) POST
	@PostMapping(value = "/{npost_number}/{ncomment_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerNoticeCommentForNoticeComment(@PathVariable("npost_number") long npost_number ,
														@PathVariable("ncomment_number") long ncomment_number,
													    @RequestBody NoticeCommentVO ncomment) {
	Long registered_ncomment_number = noticeCommentService.registerNoticeCommentForNoticeComment(ncomment);
	String _registered_ncomment_number = null ;
	
	if (registered_ncomment_number != null) {
		_registered_ncomment_number = String.valueOf(registered_ncomment_number) ;
		
	} else {
		_registered_ncomment_number = String.valueOf(registered_ncomment_number) ;
	}
	
	System.out.println("_registered_ncomment_number: " + _registered_ncomment_number);
	
	return registered_ncomment_number != null ? new ResponseEntity<String>(_registered_ncomment_number, HttpStatus.OK) 
								 	  : new ResponseEntity<String>(_registered_ncomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
}
	
	//게시물에 대한 특정 댓글 조회 GET 	
	@GetMapping(value="/{npost_number}/{ncomment_number}" , 
				produces = "application/json;charset=utf-8")
	public NoticeCommentVO showNoticeComment(@PathVariable("npost_number") Long npost_number,
							   @PathVariable("ncomment_number") Long ncomment_number){

		return noticeCommentService.getNoticeComment(npost_number, ncomment_number) ;
	}
	

	//게시물에 대한 특정 댓글 수정 PUT 또는 PATCH 		/{npost_number}/{ncomment_number}
	//Ajax에서의 요청 URI:
	@RequestMapping(value="/{npost_number}/{ncomment_number}" , 
					method = {RequestMethod.PUT, RequestMethod.PATCH} ,
					consumes = "application/json;charset=utf-8" ,
					produces = "text/plain;charset=utf-8") 
	public String modifyNoticeComment(@PathVariable("npost_number") Long npost_number ,
							  @PathVariable("ncomment_number") Long ncomment_number ,
							  @RequestBody NoticeCommentVO ncomment){
		System.out.println("컨트롤러에 전달된 ncomment: " + ncomment);
		
		if(noticeCommentService.modifyNoticeComment(ncomment)) {
			return "modifySuccess" ;
		} else {
			return "modifyFail" ;	
		}
	}
	
	
	//특정 게시물에 대한 특정 댓글/답글 삭제	/{npost_number}/{ncomment_number}
	@DeleteMapping(value = "/{npost_number}/{ncomment_number}" ,
				   consumes = "application/json; charset=utf-8",
				   produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> removeNoticeComment(@PathVariable("npost_number") Long npost_number, 
											  		@PathVariable("ncomment_number") Long ncomment_number,
											  		@RequestBody NoticeCommentVO ncomment) {
		
		return noticeCommentService.modifyNcommentDeleteFlag(npost_number, ncomment_number)  
			   ? new ResponseEntity<String>("removeSuccess", HttpStatus.OK)
			   : new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR) ;
	}
	
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@DeleteMapping(value = "/{npost_number}" , produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> removeAllNoticeComment(@PathVariable("npost_number") Long npost_number){
		
		int deleteRows = noticeCommentService.removeAllNoticeComment(npost_number) ;
		
		return new ResponseEntity<String>(String.valueOf(deleteRows), HttpStatus.OK) ;
	}

}
