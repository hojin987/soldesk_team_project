package com.soldesk.healthproject.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingCreatorDTO;
import com.soldesk.healthproject.service.FreeBoardService;
import com.soldesk.healthproject.service.MemberService;
import com.soldesk.healthproject.service.NoticeBoardService;
import com.soldesk.healthproject.service.TicketService;
import com.soldesk.healthproject.service.WorkoutService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private NoticeBoardService noticeBoardService;
	private FreeBoardService freeBoardService;
	private TicketService ticketService;
	private WorkoutService workoutService;
	private MemberService memberService;
	
	public HomeController(NoticeBoardService noticeBoardService,
						  FreeBoardService freeBoardService,
						  TicketService ticketService,
						  WorkoutService workoutService,
						  MemberService memberService) {
		this.noticeBoardService = noticeBoardService;
		this.freeBoardService = freeBoardService;
		this.ticketService = ticketService;
		this.workoutService = workoutService;
		this.memberService = memberService;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, 
					   BoardPagingDTO noticeBoardPaging, 
					   BoardPagingDTO freeBoardPaging,
					   Principal principal) {
		
		NoticeBoardPagingCreatorDTO noticeBoard = noticeBoardService.getBoardList(noticeBoardPaging);
		FreeBoardPagingCreatorDTO freeBoard = freeBoardService.getBoardList(freeBoardPaging);
		
		model.addAttribute("noticeBoard", noticeBoard);
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("ticket", ticketService.getTicketList());
		model.addAttribute("workoutList", workoutService.getWorkoutList());
		if(principal !=null && principal.getName() != null) {
			model.addAttribute("member", memberService.getMember(principal.getName()));
		}
		List<String> images = Arrays.asList("body1.jpg", "body2.jpg", "body3.jpg", "body4.jpg");
        Random rand = new Random();
        String randomImage = images.get(rand.nextInt(images.size()));
        model.addAttribute("randomImage", randomImage);

        return "myboard/main";
    }
}