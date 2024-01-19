package com.soldesk.healthproject.service;

import com.soldesk.healthproject.common.paging.domain.ProductCommentPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.ProductCommentPagingDTO;
import com.soldesk.healthproject.domain.ProductCommentVO;

public interface ProductCommentService {
	
	//특정 게시물에 대한 댓글 목록 조회
//	public List<ProductCommentVO> getProductCommentList() ;
	
	//특정 게시물에 대한 댓글 목록 조회(페이징 고려)
	public ProductCommentPagingCreatorDTO getProductCommentList(ProductCommentPagingDTO pcommentPaging);
	
	//특정 게시물에 대한 댓글 등록(preply_number: null)
	public Long registerProductCommentForProductBoard(ProductCommentVO pcomment) ;
	
	//댓글에 대한 답글 등록(preply_number: 부모글의 pcomment_number 값)
	public Long registerProductCommentForProductComment(ProductCommentVO pcomment);
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	public ProductCommentVO getProductComment(String product_number, long pcomment_number) ;
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	public boolean modifyProductComment(ProductCommentVO pcomment);
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(productDeleteFlag를 1로 업데이트)
	public boolean modifyPcommentDeleteFlag(String product_number, long pcomment_number) ;
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	public int removeAllProductComment(String product_number) ;

}
