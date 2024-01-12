package com.soldesk.healthproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soldesk.healthproject.domain.ProductVO;
import com.soldesk.healthproject.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	private ProductService productService;
	
	public ProductController(ProductService productService) {
		this.productService = productService;
		System.out.println("productService의 모든 필드 초기화 생성자");
	}
	
	//상품 목록 조회 GET
	@GetMapping("/list")
	public void showProductList(Model model) {
		model.addAttribute("productList", productService.getProductList());
	}
	
	//특정 상품 조회 GET
	@GetMapping("/detail")
	public String showProductDetail(@RequestParam("product_number") String product_number,
								   Model model) {
		model.addAttribute("product", productService.getProduct(product_number));
	
		return "product/detail";
	}
	
	//상품 등록페이지 호출 GET
	@GetMapping("/register")
	public void showProductRegister() {
		System.out.println("=====상품 등록 페이지 호출=====");
	}
	
	//상품 등록 POST
	@PostMapping("/register")
	public String registerProduct(ProductVO product, RedirectAttributes redirectAttr) {
		
		String product_number = productService.registerProduct(product);
		
		redirectAttr.addFlashAttribute("result", product_number);
		
		return "redirect:/product/list";
	}
	
	//상품 수정-삭제 페이지 호출 GET
	@GetMapping("/modify")
	public String showProductModify(@RequestParam("product_number") String product_number,
								   Model model) {
		model.addAttribute("product", productService.getProduct(product_number));
	
		return "product/modify";
	}
	
	//상품 수정 POST
	@PostMapping("/modify")
	public String modifyProduct(ProductVO product, RedirectAttributes redirectAttr) {
		productService.modifyProduct(product);
		
		return "redirect:/product/detail?product_number=" + product.getProduct_number();
	}
	
	//상품 삭제 POST
	@PostMapping("/remove")
	public String removeProduct(@RequestParam("product_number") String product_number, 
								RedirectAttributes redirectAttr) {
		productService.removeProduct(product_number);
		
		return "redirect:/product/list" ;
	}
	
	
}
