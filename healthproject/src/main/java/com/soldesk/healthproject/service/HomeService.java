package com.soldesk.healthproject.service;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;

public interface HomeService {
	
	//메인화면에서 게시판, 회원 정보 모두 불러오기
	public void getAllBoard(BoardPagingDTO noticeBoardPaging,
							BoardPagingDTO freeBoardPaging);

}
