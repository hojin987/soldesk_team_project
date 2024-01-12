package com.soldesk.healthproject.service;

import com.soldesk.healthproject.common.paging.domain.NoticeCommentPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeCommentPagingDTO;
import com.soldesk.healthproject.domain.NoticeCommentVO;

public interface NoticeCommentService {
	
	//특정 게시물에 대한 댓글 목록 조회
//	public List<NoticeCommentVO> getNoticeCommentList() ;
	
	//특정 게시물에 대한 댓글 목록 조회(페이징 고려)
	public NoticeCommentPagingCreatorDTO getNoticeCommentList(NoticeCommentPagingDTO ncommentPaging);
	
	//특정 게시물에 대한 댓글 등록(prno: null)
	public Long registerNoticeCommentForNoticeBoard(NoticeCommentVO ncomment) ;
	
	//댓글에 대한 답글 등록(prno: 부모글의 rno 값)
	public Long registerNoticeCommentForNoticeComment(NoticeCommentVO ncomment);
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	public NoticeCommentVO getNoticeComment(long npost_number, long ncomment_number) ;
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	public boolean modifyNoticeComment(NoticeCommentVO ncomment);
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
	public boolean modifyNcommentDeleteFlag(long npost_number, long ncomment_number) ;
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	public int removeAllNoticeComment(long npost_number) ;

}
