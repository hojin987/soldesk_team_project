package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.ProductVO;

public interface ProductMapper {

	//상품 목록 조회
	public List<ProductVO> selectProductList() ;
	
	//특정 상품 조회
	public ProductVO selectProduct(String product_number) ; 
	
	//상품 등록
	public long insertProduct(ProductVO product) ;
	
	//상품 수정
	public long updateProduct(ProductVO product) ;
	
	//상품 삭제
	public long deleteProduct(String product_number) ;
	
	
}
