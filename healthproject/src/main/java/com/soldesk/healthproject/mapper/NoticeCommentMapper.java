package com.soldesk.healthproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.soldesk.healthproject.common.paging.domain.NoticeCommentPagingDTO;
import com.soldesk.healthproject.domain.NoticeCommentVO;


public interface NoticeCommentMapper {

	//특정 게시물에 대한 댓글 목록 조회: (페이징 고려)
	public List<NoticeCommentVO> selectNoticeCommentList(NoticeCommentPagingDTO noticeCommentPagingDTO) ;
	
	//특정 게시물에 대한 댓글 총 개수
	public long selectNoticeRowTotal(long npost_number) ;
	
	//특정 게시물에 대한 댓글 등록(nreply_number: null)
	public long insertNoticeCommentForNoticeBoard(NoticeCommentVO ncomment) ;

	//댓글에 대한 답글 등록(nreply_number: 부모글의 ncomment_number 값)
	public long insertNoticeCommentForNoticeComment(NoticeCommentVO ncomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 조회
	public NoticeCommentVO selectNoticeComment(@Param("npost_number") long npost_number, @Param("ncomment_number") long ncomment_number) ;
		
	//특정 게시물에 대한 특정 댓글/답글 수정
	public int updateNoticeComment(NoticeCommentVO ncomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 삭제요청(ncomment_delete_flag를 1로 업데이트)
	public int updateNcommentDeleteFlag(@Param("npost_number") long npost_number, @Param("ncomment_number") long ncomment_number) ;
		
	//특정 게시물에 대한 모든 댓글 삭제
	public int deleteAllNoticeComment(long npost_number) ;
	
}
