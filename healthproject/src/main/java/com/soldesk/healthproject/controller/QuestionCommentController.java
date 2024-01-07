package com.soldesk.healthproject.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
//import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.soldesk.healthproject.domain.QuestionCommentVO;
import com.soldesk.healthproject.service.QuestionCommentService;

@RestController
@RequestMapping("/questionComment")
public class QuestionCommentController {
	
	private QuestionCommentService questionCommentService ;

	public QuestionCommentController(QuestionCommentService questionCommentService) {
		this.questionCommentService = questionCommentService;
	}
	
	//게시물에 대한 댓글 목록 조회	
	@GetMapping("/list") 
	public void showQuestionCommentList(Model model){
		model.addAttribute("questionCommentList", questionCommentService.getQuestionCommentList());
	}
	
	
	//게시물에 대한 댓글 등록(qcomment_number 반환) POST 		/{qpost_number}/new
	@PostMapping(value = "/{qpost_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerQuestionCommentForQuestionBoard(@PathVariable("qpost_number") long qpost_number ,
																  @RequestBody QuestionCommentVO qcomment) {
		Long registered_qcomment_number = questionCommentService.registerQuestionCommentForQuestionBoard(qcomment);
		String _registered_qcomment_number = null ;
		
		if (registered_qcomment_number != null) {
			_registered_qcomment_number = String.valueOf(registered_qcomment_number) ;
			
		} else {
			_registered_qcomment_number = String.valueOf(registered_qcomment_number) ;
		}
		
		System.out.println("_registered_qcomment_number: " + _registered_qcomment_number);
		
		return registered_qcomment_number != null ? new ResponseEntity<String>(_registered_qcomment_number, HttpStatus.OK) 
										  : new ResponseEntity<String>(_registered_qcomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//댓글의 답글 등록(qcomment_number 반환) POST 	/{qpost_number}/new
	@PostMapping(value = "/{qpost_number}/{qcomment_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerQuestionCommentForQuestionComment(@PathVariable("qpost_number") long qpost_number ,
														@PathVariable("qcomment_number") long qcomment_number,
													    @RequestBody QuestionCommentVO qcomment) {
	Long registered_qcomment_number = questionCommentService.registerQuestionCommentForQuestionComment(qcomment);
	String _registered_qcomment_number = null ;
	
	if (registered_qcomment_number != null) {
		_registered_qcomment_number = String.valueOf(registered_qcomment_number) ;
		
	} else {
		_registered_qcomment_number = String.valueOf(registered_qcomment_number) ;
	}
	
	System.out.println("_registered_qcomment_number: " + _registered_qcomment_number);
	
	return registered_qcomment_number != null ? new ResponseEntity<String>(_registered_qcomment_number, HttpStatus.OK) 
								 	  : new ResponseEntity<String>(_registered_qcomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
}
	
//게시물에 대한 특정 댓글 조회 GET 	
	@GetMapping(value="/{qpost_number}/{qcomment_number}" , 
				produces = "application/json;charset=utf-8")
	public QuestionCommentVO showQuestionComment(@PathVariable("qpost_number") Long qpost_number,
							   @PathVariable("qcomment_number") Long qcomment_number){

		return questionCommentService.getQuestionComment(qpost_number, qcomment_number) ;
	}
	

//게시물에 대한 특정 댓글 수정 PUT 또는 PATCH 		/{qpost_number}/{qcomment_number}
	//Ajax에서의 요청 URI:
	@RequestMapping(value="/{qpost_number}/{qcomment_number}" , 
					method = {RequestMethod.PUT, RequestMethod.PATCH} ,
					consumes = "application/json;charset=utf-8" ,
					produces = "text/plain;charset=utf-8") 
//	@PreAuthorize()
	public String modifyQuestionComment(@PathVariable("qpost_number") Long qpost_number ,
							  @PathVariable("qcomment_number") Long qcomment_number ,
							  @RequestBody QuestionCommentVO qcomment){
		System.out.println("컨트롤러에 전달된 qcomment: " + qcomment);
		
		if(questionCommentService.modifyQuestionComment(qcomment)) {
			return "modifySuccess" ;
		} else {
			return "modifyFail" ;	
		}
	}
	
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(qcommentDeleteFlag를 1로 업데이트)	/{qpost_number}/{qcomment_number}
	@DeleteMapping(value = "/{qpost_number}/{qcomment_number}" ,
				   consumes = "application/json; charset=utf-8",
				   produces = "text/plain;charset=utf-8")
//	@PreAuthorize()
	public ResponseEntity<String> removeQuestionComment(@PathVariable("qpost_number") Long qpost_number, 
											  		@PathVariable("qcommnet_number") Long qcomment_number,
											  		@RequestBody QuestionCommentVO qcomment) {
		
		return questionCommentService.modifyQcommentDeleteFlag(qpost_number, qcomment_number)  
			   ? new ResponseEntity<String>("removeSuccess", HttpStatus.OK)
			   : new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR) ;
	}
	
	
//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@DeleteMapping(value = "/{qpost_number}" , produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> removeAllQuestionComment(@PathVariable("qpost_number") Long qpost_number){
		
		int deleteRows = questionCommentService.removeAllQuestionComment(qpost_number) ;
		
		return new ResponseEntity<String>(String.valueOf(deleteRows), HttpStatus.OK) ;
	}

}
