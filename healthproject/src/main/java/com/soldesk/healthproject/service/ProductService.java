package com.soldesk.healthproject.service;

import java.util.List;

import com.soldesk.healthproject.domain.ProductVO;

public interface ProductService {
	
	//상품 목록 조회
	public List<ProductVO> getProductList();
		
	//특정 상품 조회
	public ProductVO getProduct(String product_number);
	
	//상품 등록
	public String registerProduct(ProductVO product);
	
	//상품 수정
	public boolean modifyProduct(ProductVO product);
	
	//상품 삭제
	public boolean removeProduct(String product_number);
	
}
