package com.soldesk.healthproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.soldesk.healthproject.common.paging.domain.ProductCommentPagingDTO;
import com.soldesk.healthproject.domain.ProductCommentVO;


public interface ProductCommentMapper {

	//특정 게시물에 대한 댓글 목록 조회: (페이징 고려 아직 안함)
	public List<ProductCommentVO> selectProductCommentList(ProductCommentPagingDTO productCommentPagingDTO) ;
		
	//특정 게시물에 대한 댓글 총 개수
	public long selectProductRowTotal(long product_number) ;
	
	//특정 게시물에 대한 댓글 등록(preply_number: null)
	public long insertProductCommentForProduct(ProductCommentVO pcomment) ;

	//댓글에 대한 답글 등록(preply_number: 부모글의 pcomment_number 값)
	public long insertProductCommentForProductComment(ProductCommentVO pcomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 조회
	public ProductCommentVO selectProductComment(@Param("product_number") long product_number, @Param("pcomment_number") long pcomment_number) ;
		
	//특정 게시물에 대한 특정 댓글/답글 수정
	public int updateProductComment(ProductCommentVO pcomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 삭제요청(fcomment_delete_flag를 1로 업데이트)
	public int updatePcommentDeleteFlag(@Param("product_number") long product_number, @Param("pcomment_number") long pcomment_number) ;
		
	//특정 게시물에 대한 모든 댓글 삭제
	public int deleteAllProductComment(long product_number) ;
	
}
