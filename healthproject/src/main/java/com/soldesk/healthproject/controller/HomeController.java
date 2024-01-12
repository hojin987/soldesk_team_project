package com.soldesk.healthproject.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingDTO;
import com.soldesk.healthproject.service.FreeBoardService;
import com.soldesk.healthproject.service.HomeService;
import com.soldesk.healthproject.service.NoticeBoardService;
import com.soldesk.healthproject.service.ProductService;
import com.soldesk.healthproject.service.TicketService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private HomeService homeService;
	private NoticeBoardService noticeBoardService;
	private FreeBoardService freeBoardService;
	private TicketService ticketService;
	private ProductService productService;
	
	public HomeController(NoticeBoardService noticeBoardService,
						  FreeBoardService freeBoardService,
						  TicketService ticketService,
						  ProductService productService) {
		this.noticeBoardService = noticeBoardService;
		this.freeBoardService = freeBoardService;
		this.ticketService = ticketService;
		this.productService = productService;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, 
					   NoticeBoardPagingDTO noticeBoardPaging, 
					   FreeBoardPagingDTO freeBoardPaging) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("noticeBaord", noticeBoardService.getBoardList(noticeBoardPaging));
		model.addAttribute("freeBoard", freeBoardService.getBoardList(freeBoardPaging));
		model.addAttribute("ticket", ticketService.getTicketList());
		model.addAttribute("product", productService.getProductList());
		
		return "myboard/main";
	}
	
}
