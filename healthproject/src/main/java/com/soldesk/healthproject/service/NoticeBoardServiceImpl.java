package com.soldesk.healthproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.domain.NoticeBoardVO;
import com.soldesk.healthproject.mapper.NoticeBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
	
	private NoticeBoardMapper noticeBoardMapper;
	
	public NoticeBoardServiceImpl() {
		System.out.println("NoticeBoardServiceImpl의 기본생성자");
	}
	
	@Autowired
	public void setNoticeBoardMapper(NoticeBoardMapper noticeBoardMapper) {
		this.noticeBoardMapper = noticeBoardMapper;
	}
	
	
	//게시물 목록 조회
	@Override
	public List<NoticeBoardVO> getNoticeBoardList() {
		log.info("NoticeBoardService.getNoticeBoardList() 실행");
		return noticeBoardMapper.selectNoticeBoardList();
	}
	
	//게시물 등록
	@Override
	public long registerNoticeBoard(NoticeBoardVO noticeBoard) {
		noticeBoardMapper.insertNoticeBoard(noticeBoard);
		
		return noticeBoard.getNpost_number();
	}
	
	//게시물 조회
	@Override
	public NoticeBoardVO getNoticeBoard(long npost_number) {
//		noticeBoardMapper.updateNviewCount(npost_number);
		return noticeBoardMapper.selectNoticeBoard(npost_number);
	}
	
	//게시물 수정
	@Override
	public boolean modifyNoticeBoard(NoticeBoardVO noticeBoard) {
		return noticeBoardMapper.updateNoticeBoard(noticeBoard) == 1;
	}
	
	//게시물 삭제 - 삭제플래그 1로 수정
	@Override
	public boolean setNoticeBoardDeleted(long npost_number) {
		return noticeBoardMapper.updateNdeleteFlag(npost_number) == 1;
	}

	@Override
	public boolean removeNoticeBoard(long npost_number) {
		return noticeBoardMapper.deleteNoticeBoard(npost_number) == 1;
	}
	
}
