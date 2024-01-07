package com.soldesk.healthproject.service;

import java.util.List;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soldesk.healthproject.domain.NoticeCommentVO;
import com.soldesk.healthproject.mapper.NoticeCommentMapper;

@Service
public class NoticeCommentServiceImpl implements NoticeCommentService {

	private NoticeCommentMapper noticeCommentMapper ;
//	private NoticeBoardMapper noticeBoardMapper ;
	
	public NoticeCommentServiceImpl(NoticeCommentMapper noticeCommentMapper
//								  NoticeBoardMapper noticeBoardMapper) {
								  ) {
		this.noticeCommentMapper = noticeCommentMapper ;
//		this.noticeBoardMapper = noticeBoardMapper ;
	}
	
	
	//특정 게시물에 대한 댓글 목록 조회
	@Override
	public List<NoticeCommentVO> getNoticeCommentList() {
		
		return noticeCommentMapper.selectNoticeCommentList() ;			
	}
	
	//특정 게시물에 대한 댓글 등록(nreply_number: null)
	@Transactional
	@Override
	public Long registerNoticeCommentForNoticeBoard(NoticeCommentVO ncomment) {
		
		noticeCommentMapper.insertNoticeCommentForNoticeBoard(ncomment) ;
//		noticeBoardMapper.updateNreply_count(ncomment.getNpost_number(), 1);
		return ncomment.getNcomment_number() ; 
	}
	
	//댓글에 대한 답글 등록(nreply_number: 부모글의 ncomment_number 값)
	
	@Override
	@Transactional
	public Long registerNoticeCommentForNoticeComment(NoticeCommentVO ncomment) {
		noticeCommentMapper.insertNoticeCommentForNoticeComment(ncomment) ;
//		noticeBoardMapper.updateNreply_count(ncomment.getNpost_number(), 1);
		
		return ncomment.getNcomment_number() ; 
	}
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	@Override
	public NoticeCommentVO getNoticeComment(long npost_number, long ncomment_number) {
		return noticeCommentMapper.selectNoticeComment(npost_number, ncomment_number) ;
	}
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	@Override
	public boolean modifyNoticeComment(NoticeCommentVO ncomment) {
		return noticeCommentMapper.updateNoticeComment(ncomment) == 1 ;
		
	}
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
	@Override
	@Transactional
	public boolean modifyNcommentDeleteFlag(long npost_number, long ncomment_number) {
		
		int deleteRowCnt = noticeCommentMapper.updateNcommentDeleteFlag(npost_number, ncomment_number) ;
		
//		noticeBoardMapper.updateNreply_count(npost_number, -1);
		
		return deleteRowCnt == 1 ;
		
//		return noticeCommentMapper.updateNcommentDeleteFlag(npost_number, ncomment_number) == 1;
	}
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@Override
	public int removeAllNoticeComment(long npost_number) {
		return noticeCommentMapper.deleteAllNoticeComment(npost_number) ;
	}

}
