package com.soldesk.healthproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.domain.ProductVO;
import com.soldesk.healthproject.mapper.ProductMapper;


@Service
public class ProductServiceImpl implements ProductService {
	
	private ProductMapper productMapper;
	
	public ProductServiceImpl() {
		System.out.println("ProductServiceImpl의 기본생성자");
	}
	
	@Autowired
	public void setProductMapper(ProductMapper productMapper) {
		this.productMapper = productMapper;
	}
	
	//상품 목록 조회
	@Override
	public List<ProductVO> getProductList() {
		return productMapper.selectProductList();
	}
	
	//특정 상품 조회
	@Override
	public ProductVO getProduct(String product_number) {
		return productMapper.selectProduct(product_number);
	}
	
	//상품 등록
	@Override
	public String registerProduct(ProductVO product) {
		productMapper.insertProduct(product);
		return product.getProduct_number();
	}
	
	//상품 수정
	@Override
	public boolean modifyProduct(ProductVO product) {
		return productMapper.updateProduct(product) == 1;
	}
	
	//상품 삭제
	@Override
	public boolean removeProduct(String product_number) {
		return productMapper.deleteProduct(product_number) == 1;
	}

}
