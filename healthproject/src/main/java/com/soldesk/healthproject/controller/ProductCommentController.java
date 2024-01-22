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

import com.soldesk.healthproject.common.paging.domain.ProductCommentPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.ProductCommentPagingDTO;
import com.soldesk.healthproject.domain.ProductCommentVO;
import com.soldesk.healthproject.service.ProductCommentService;

@RestController
@RequestMapping("/productComment")
public class ProductCommentController {
	
	private ProductCommentService productCommentService ;

	public ProductCommentController(ProductCommentService productCommentService) {
		this.productCommentService = productCommentService;
	}
	
	//게시물에 대한 댓글 목록 조회	
//	@GetMapping("/list") 
//	public void showProductCommentList(Model model){
//		model.addAttribute("productCommentList", productCommentService.getProductCommentList());
//	}
	
	//게시물에 대한 댓글 목록 조회(페이징 고려)
	@GetMapping(value= "/{product_number}/page/{pageNum}",
				produces = {"application/json;charset=utf-8", "application/xml;charset=utf-8"})
	
	public ResponseEntity<ProductCommentPagingCreatorDTO> showProductCommentList(@PathVariable("product_number") String product_number,
																		   @PathVariable("pageNum") Integer pageNum) {
	
		ProductCommentPagingCreatorDTO productCommentPagingCreator =
				productCommentService.getProductCommentList(new ProductCommentPagingDTO(product_number, pageNum));
		
		ResponseEntity<ProductCommentPagingCreatorDTO> productResponseEntity =
				new ResponseEntity<ProductCommentPagingCreatorDTO>(productCommentPagingCreator, HttpStatus.OK);
		
		return productResponseEntity;
	}
	
	
	//게시물에 대한 댓글 등록(pcomment_number 반환) POST 		/{product_number}/new
	@PostMapping(value = "/{product_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
//	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerProductCommentForProduct(@PathVariable("product_number") String product_number ,
																  @RequestBody ProductCommentVO pcomment) {
		Long registered_pcomment_number = productCommentService.registerProductCommentForProductBoard(pcomment);
		String _registered_pcomment_number = null ;
		
		if (registered_pcomment_number != null) {
			_registered_pcomment_number = String.valueOf(registered_pcomment_number) ;
			
		} else {
			_registered_pcomment_number = String.valueOf(registered_pcomment_number) ;
		}
		
		System.out.println("_registered_pcomment_number: " + _registered_pcomment_number);
		
		return registered_pcomment_number != null ? new ResponseEntity<String>(_registered_pcomment_number, HttpStatus.OK) 
										  : new ResponseEntity<String>(_registered_pcomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//댓글의 답글 등록(pcomment_number 반환) POST 	/{product_number}/new
	@PostMapping(value = "/{product_number}/{pcomment_number}/new" , 
				 consumes = {"application/json;charset=utf-8"} ,//consumes:브라우저--> 메서드로 전송한 데이터 유형
				 produces = {"text/plain; charset=utf-8"} )		//produces:메서드--> 브라우저로 보내는 데이터 유형
//	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerProductCommentForProductComment(@PathVariable("product_number") String product_number ,
														@PathVariable("pcomment_number") long pcomment_number,
													    @RequestBody ProductCommentVO pcomment) {
	Long registered_pcomment_number = productCommentService.registerProductCommentForProductComment(pcomment);
	String _registered_pcomment_number = null ;
	
	if (registered_pcomment_number != null) {
		_registered_pcomment_number = String.valueOf(registered_pcomment_number) ;
		
	} else {
		_registered_pcomment_number = String.valueOf(registered_pcomment_number) ;
	}
	
	System.out.println("_registered_pcomment_number: " + _registered_pcomment_number);
	
	return registered_pcomment_number != null ? new ResponseEntity<String>(_registered_pcomment_number, HttpStatus.OK) 
								 	  : new ResponseEntity<String>(_registered_pcomment_number, HttpStatus.INTERNAL_SERVER_ERROR);
}
	
//게시물에 대한 특정 댓글 조회 GET 	
	@GetMapping(value="/{product_number}/{pcomment_number}" , 
				produces = "application/json;charset=utf-8")
	public ProductCommentVO showProductComment(@PathVariable("product_number") String product_number,
							   @PathVariable("pcomment_number") Long pcomment_number){

		return productCommentService.getProductComment(product_number, pcomment_number) ;
	}
	

//게시물에 대한 특정 댓글 수정 PUT 또는 PATCH 		/{product_number}/{pcomment_number}
	//Ajax에서의 요청 URI:
	@RequestMapping(value="/{product_number}/{pcomment_number}" , 
					method = {RequestMethod.PUT, RequestMethod.PATCH} ,
					consumes = "application/json;charset=utf-8" ,
					produces = "text/plain;charset=utf-8") 
//	@PreAuthorize("isAuthenticated() && principal.username == #productComment.pcomment_writer")
	public String modifyProductComment(@PathVariable("product_number") String product_number ,
							  @PathVariable("pcomment_number") Long pcomment_number ,
							  @RequestBody ProductCommentVO pcomment){
		System.out.println("컨트롤러에 전달된 pcomment: " + pcomment);
		
		if(productCommentService.modifyProductComment(pcomment)) {
			return "modifySuccess" ;
		} else {
			return "modifyFail" ;	
		}
	}
	
	
	//특정 게시물에 대한 특정 댓글/답글 삭제	/{product_number}/{pcomment_number}
	@DeleteMapping(value = "/{product_number}/{pcomment_number}" ,
				   consumes = "application/json; charset=utf-8",
				   produces = "text/plain;charset=utf-8")
//	@PreAuthorize("isAuthenticated() && principal.username == #productComment.pcomment_writer")
	public ResponseEntity<String> removeProductComment(@PathVariable("product_number") String product_number, 
											  		@PathVariable("pcomment_number") Long pcomment_number,
											  		@RequestBody ProductCommentVO pcomment) {
		
		return productCommentService.modifyPcommentDeleteFlag(product_number, pcomment_number)  
			   ? new ResponseEntity<String>("removeSuccess", HttpStatus.OK)
			   : new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR) ;
	}
	
	
//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@DeleteMapping(value = "/{product_number}" , produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> removeAllProductComment(@PathVariable("product_number") String product_number){
		
		int deleteRows = productCommentService.removeAllProductComment(product_number) ;
		
		return new ResponseEntity<String>(String.valueOf(deleteRows), HttpStatus.OK) ;
	}

}
