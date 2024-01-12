package com.soldesk.healthproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.soldesk.healthproject.common.paging.domain.FreeCommentPagingDTO;
import com.soldesk.healthproject.domain.FreeCommentVO;


public interface FreeCommentMapper {

	//특정 게시물에 대한 댓글 목록 조회: (페이징 고려)
	public List<FreeCommentVO> selectFreeCommentList(FreeCommentPagingDTO freeCommentPagingDTO) ;
		
	//특정 게시물에 대한 댓글 총 개수
	public long selectFreeRowTotal(long fpost_number) ;
	
	//특정 게시물에 대한 댓글 등록(freply_num: null)
	public long insertFreeCommentForFreeBoard(FreeCommentVO fcomment) ;

	//댓글에 대한 답글 등록(freply_number: 부모글의 fcomment_number 값)
	public long insertFreeCommentForFreeComment(FreeCommentVO fcomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 조회
	public FreeCommentVO selectFreeComment(@Param("fpost_number") long fpost_number, @Param("fcomment_number") long fcomment_number) ;
		
	//특정 게시물에 대한 특정 댓글/답글 수정
	public int updateFreeComment(FreeCommentVO fcomment) ;
		
	//특정 게시물에 대한 특정 댓글/답글 삭제요청(fcomment_delete_flag를 1로 업데이트)
	public int updateFcommentDeleteFlag(@Param("fpost_number") long fpost_number, @Param("fcomment_number") long fcomment_number) ;
		
	//특정 게시물에 대한 모든 댓글 삭제
	public int deleteAllFreeComment(long fpost_number) ;
	
}
