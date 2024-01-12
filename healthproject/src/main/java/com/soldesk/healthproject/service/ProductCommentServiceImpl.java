package com.soldesk.healthproject.service;

import java.util.List;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soldesk.healthproject.common.paging.domain.ProductCommentPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.ProductCommentPagingDTO;
import com.soldesk.healthproject.domain.ProductCommentVO;
import com.soldesk.healthproject.mapper.ProductCommentMapper;

@Service
public class ProductCommentServiceImpl implements ProductCommentService {

	private ProductCommentMapper productCommentMapper ;
//	private ProductMapper productMapper ;
	
	public ProductCommentServiceImpl(ProductCommentMapper productCommentMapper
//								  	 ProductMapper productMapper) {
								  ) {
		this.productCommentMapper = productCommentMapper ;
//		this.productMapper = productMapper ;
	}
	
	
	//특정 게시물에 대한 댓글 목록 조회
		@Override
		public ProductCommentPagingCreatorDTO getProductCommentList(ProductCommentPagingDTO pcommentPaging) {
				
			long pcommentTotalCount = productCommentMapper.selectProductRowTotal(pcommentPaging.getProduct_number()) ;
			
			int productPageNum = pcommentPaging.getProductPageNum() ;
			
			if (productPageNum == -10) {
				
				productPageNum = (int) Math.ceil((double)pcommentTotalCount/pcommentPaging.getRowAmountPerProductPage()) ;
				pcommentPaging.setProductPageNum(productPageNum) ;
			}
			
			List<ProductCommentVO> pcommentList = productCommentMapper.selectProductCommentList(pcommentPaging);
			
			ProductCommentPagingCreatorDTO productCommentPagingCreatorDTO
					= new ProductCommentPagingCreatorDTO(pcommentList, pcommentTotalCount, pcommentPaging);
			
			return productCommentPagingCreatorDTO;			
		}
	
	//특정 게시물에 대한 댓글 등록(preply_number: null)
	@Transactional
	@Override
	public Long registerProductCommentForProductBoard(ProductCommentVO pcomment) {
		
		productCommentMapper.insertProductCommentForProduct(pcomment) ;
//		productMapper.updatePreply_count(pcomment.getProduct_number(), 1);
		return pcomment.getPcomment_number() ; 
	}
	
	//댓글에 대한 답글 등록(preply_number: 부모글의 pcomment_number 값)
	
	@Override
	@Transactional
	public Long registerProductCommentForProductComment(ProductCommentVO pcomment) {
		productCommentMapper.insertProductCommentForProductComment(pcomment) ;
//		productMapper.updatePreply_count(pcomment.getProduct_number(), 1);
		
		return pcomment.getPcomment_number() ; 
	}
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	@Override
	public ProductCommentVO getProductComment(long product_number, long pcomment_number) {
		return productCommentMapper.selectProductComment(product_number, pcomment_number) ;
	}
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	@Override
	public boolean modifyProductComment(ProductCommentVO pcomment) {
		return productCommentMapper.updateProductComment(pcomment) == 1 ;
		
	}
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(pcommentDeleteFlag를 1로 업데이트)
	@Override
	@Transactional
	public boolean modifyPcommentDeleteFlag(long product_number, long pcomment_number) {
		
		int deleteRowCnt = productCommentMapper.updatePcommentDeleteFlag(product_number, pcomment_number) ;
		
//		productMapper.updatePreply_count(product_number, -1);
		
		return deleteRowCnt == 1 ;
		
//		return productCommentMapper.updatePcommentDeleteFlag(product_number, pcomment_number) == 1;
	}
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@Override
	public int removeAllProductComment(long product_number) {
		return productCommentMapper.deleteAllProductComment(product_number) ;
	}

}
