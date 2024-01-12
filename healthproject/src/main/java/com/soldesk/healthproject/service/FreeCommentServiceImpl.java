package com.soldesk.healthproject.service;

import java.util.List;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soldesk.healthproject.common.paging.domain.FreeCommentPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.FreeCommentPagingDTO;
import com.soldesk.healthproject.domain.FreeCommentVO;
import com.soldesk.healthproject.mapper.FreeCommentMapper;

@Service
public class FreeCommentServiceImpl implements FreeCommentService {

	private FreeCommentMapper freeCommentMapper ;
//	private FreeBoardMapper freeBoardMapper ;
	
	public FreeCommentServiceImpl(FreeCommentMapper freeCommentMapper
//								  FreeBoardMapper freeBoardMapper) {
								  ) {
		this.freeCommentMapper = freeCommentMapper ;
//		this.freeBoardMapper = freeBoardMapper ;
	}
	
	
	//특정 게시물에 대한 댓글 목록 조회
	@Override
	public FreeCommentPagingCreatorDTO getFreeCommentList(FreeCommentPagingDTO fcommentPaging) {
			
		long fcommentTotalCount = freeCommentMapper.selectFreeRowTotal(fcommentPaging.getFpost_number()) ;
		
		int freePageNum = fcommentPaging.getFreePageNum() ;
		
		if (freePageNum == -10) {
			
			freePageNum = (int) Math.ceil((double)fcommentTotalCount/fcommentPaging.getRowAmountPerFreePage()) ;
			fcommentPaging.setFreePageNum(freePageNum) ;
		}
		
		List<FreeCommentVO> fcommentList = freeCommentMapper.selectFreeCommentList(fcommentPaging);
		
		FreeCommentPagingCreatorDTO freeCommentPagingCreatorDTO
				= new FreeCommentPagingCreatorDTO(fcommentList, fcommentTotalCount, fcommentPaging);
		
		return freeCommentPagingCreatorDTO;			
	}
	
	//특정 게시물에 대한 댓글 등록(freply_number: null)
	@Transactional
	@Override
	public Long registerFreeCommentForFreeBoard(FreeCommentVO fcomment) {
		
		freeCommentMapper.insertFreeCommentForFreeBoard(fcomment) ;
//		freeBoardMapper.updateFreply_count(fcomment.getFpost_number(), 1);
		return fcomment.getFcomment_number() ; 
	}
	
	//댓글에 대한 답글 등록(freply_number: 부모글의 fcomment_number 값)
	
	@Override
	@Transactional
	public Long registerFreeCommentForFreeComment(FreeCommentVO fcomment) {
		freeCommentMapper.insertFreeCommentForFreeComment(fcomment) ;
//		freeBoardMapper.updateFreply_count(fcomment.getFpost_number(), 1);
		
		return fcomment.getFcomment_number() ; 
	}
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	@Override
	public FreeCommentVO getFreeComment(long fpost_number, long fcomment_number) {
		return freeCommentMapper.selectFreeComment(fpost_number, fcomment_number) ;
	}
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	@Override
	public boolean modifyFreeComment(FreeCommentVO fcomment) {
		return freeCommentMapper.updateFreeComment(fcomment) == 1 ;
		
	}
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
	@Override
	@Transactional
	public boolean modifyFcommentDeleteFlag(long fpost_number, long fcomment_number) {
		
		int deleteRowCnt = freeCommentMapper.updateFcommentDeleteFlag(fpost_number, fcomment_number) ;
		
//		freeBoardMapper.updateFreply_count(fpost_number, -1);
		
		return deleteRowCnt == 1 ;
		
//		return freeCommentMapper.updateFcommentDeleteFlag(fpost_number, fcomment_number) == 1;
	}
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@Override
	public int removeAllFreeComment(long fpost_number) {
		return freeCommentMapper.deleteAllFreeComment(fpost_number) ;
	}

}
