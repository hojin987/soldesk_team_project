package com.soldesk.healthproject.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingDTO;
import com.soldesk.healthproject.mapper.FreeBoardMapper;
import com.soldesk.healthproject.mapper.NoticeBoardMapper;
import com.soldesk.healthproject.mapper.ProductMapper;
import com.soldesk.healthproject.mapper.TicketMapper;

@Service
public class HomeServiceImpl implements HomeService {
	
	private NoticeBoardMapper noticeBoardMapper;
	private FreeBoardMapper freeBoardMapper;
	private TicketMapper ticketMapper;
	private ProductMapper productMapper;
	
	public HomeServiceImpl(NoticeBoardMapper noticeBoardMapper,
						   FreeBoardMapper freeBoardMapper,
						   TicketMapper ticketMapper,
						   ProductMapper productMapper) {
		this.noticeBoardMapper = noticeBoardMapper ;
		this.freeBoardMapper = freeBoardMapper ;
		this.ticketMapper = ticketMapper ;
		this.productMapper = productMapper ;
	}

	@Override
	@Transactional
	public void getAllBoard(NoticeBoardPagingDTO noticeBoardPaging,
							FreeBoardPagingDTO freeBoardPaging) {
		noticeBoardMapper.selectNoticeBoardList(noticeBoardPaging);
		freeBoardMapper.selectFreeBoardList(freeBoardPaging);
		ticketMapper.selectTicketList();
		productMapper.selectProductList();
		
	}

}
