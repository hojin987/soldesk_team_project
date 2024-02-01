package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.domain.ApplyAttachFileVO;
import com.soldesk.healthproject.domain.ApplyBoardVO;
import com.soldesk.healthproject.mapper.ApplyAttachFileMapper;
import com.soldesk.healthproject.mapper.ApplyBoardMapper;

@Service
public class ApplyBoardServiceImpl implements ApplyBoardService {
	
	private ApplyBoardMapper applyBoardMapper;	
	private ApplyAttachFileMapper applyAttachFileMapper;
	
	public ApplyBoardServiceImpl(ApplyBoardMapper applyBoardMapper, ApplyAttachFileMapper applyAttachFileMapper) {
		this.applyBoardMapper = applyBoardMapper;
		this.applyAttachFileMapper = applyAttachFileMapper;
	}
	
	
	//게시물 목록 조회

	@Override
	public ApplyBoardPagingCreatorDTO getBoardList(BoardPagingDTO applyboardPaging) {
					
		String beginDate = applyboardPaging.getBeginDate() ;
		String endDate = applyboardPaging.getEndDate() ;
		
		Date _endDate = null ;
		Calendar myCal = null ;
		
		if((beginDate != null && beginDate.length() != 0) 
				&& (endDate != null && endDate.length() != 0)) {
			if(beginDate.equals(endDate)) {
				
				SimpleDateFormat myDateFmt = new SimpleDateFormat("yyyy-MM-dd");
				try {
					_endDate = myDateFmt.parse(endDate);//Parses text from the beginning of the given string to produce a date
					myCal = Calendar.getInstance() ;
					myCal.setTime(_endDate); 			//Sets this Calendar's time with the given Date
					
					myCal.add(Calendar.DAY_OF_MONTH, 1);
					
					endDate = myDateFmt.format(myCal.getTime()) ; //문자열로 변환
					System.out.println("변환 후 endDate: " + endDate);
					
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				applyboardPaging.setEndDate(endDate);
			}
			
		}
		
		return new ApplyBoardPagingCreatorDTO(applyBoardMapper.selectRowTotal(applyboardPaging), 
				                           applyboardPaging, 
				                           applyBoardMapper.selectApplyBoardList(applyboardPaging)) ;
	}
	
	//게시물 등록
	@Transactional
	@Override
	public long registerApplyBoard(ApplyBoardVO applyBoard) {
				
		applyBoardMapper.insertApplyBoard(applyBoard);
		
		//첨부파일이 없는 경우, 메서드 종료
		if (applyBoard.getAttachFileList() == null || applyBoard.getAttachFileList().size() <= 0) {
			return applyBoard.getApost_number() ;
		}
		
		//첨부파일이 있는 경우, applyBoard의 apost_number 값을 첨부파일 정보 VO에 저장 후, apply_attachfiles 테이블에 입력
		applyBoard.getAttachFileList().forEach(attachFile -> {
			attachFile.setApost_number(applyBoard.getApost_number());
			applyAttachFileMapper.insertAttachFile(attachFile);
		});
		
		return applyBoard.getApost_number();
	}
	
	//게시물 조회
	@Override
	public ApplyBoardVO getApplyBoard(long apost_number) {
		applyBoardMapper.updateAviewCount(apost_number);
		return applyBoardMapper.selectApplyBoard(apost_number);
	}
	
	//게시물 수정
	@Transactional
	@Override
	public boolean modifyApplyBoard(ApplyBoardVO applyBoard) {
		System.out.println("BoardService.modify()에 전달된 ApplyBoardVO: " + applyBoard);
		
		long apost_number = applyBoard.getApost_number();
		
		//게시물 변경 시, 기존 첨부파일이 삭제와 새로운 첨부파일 추가를 모두 고려하여, 기존 DB의 정보를 모두 삭제 후,
		//첨부파일 정보를 DB에 다시 추가하는 방식으로 처리
		applyAttachFileMapper.deleteAttachFiles(apost_number);
		
		//게시물 수정: tbl_myboard 테이블에 수정
		boolean boardModifyResult = applyBoardMapper.updateApplyBoard(applyBoard) == 1 ;
		
		//게시물 수정이 성공하고, 첨부파일이 있는 경우에만 다음작업 수행
		//첨부파일 정보 저장: tbl_myAttachFiles 테이블에 저장
		if (boardModifyResult && (applyBoard.getAttachFileList().size() > 0)) {
			applyBoard.getAttachFileList().forEach(
				attachFile -> {
					attachFile.setApost_number(apost_number);
					applyAttachFileMapper.insertAttachFile(attachFile);
					}
			);
		}
		
		return boardModifyResult;
	}
	
	//게시물 삭제 - 삭제플래그 1로 수정
	@Override
	public boolean setApplyBoardDeleted(long apost_number) {
		return applyBoardMapper.updateAdeleteFlag(apost_number) == 1;
	}

	//게시물 삭제 - 실제 삭제
	@Transactional
	@Override
	public boolean removeApplyBoard(long apost_number) {
		applyAttachFileMapper.deleteAttachFiles(apost_number);
		return applyBoardMapper.deleteApplyBoard(apost_number) == 1;
	}
	
	//게시물의 첨부파일 조회
	@Override
	public List<ApplyAttachFileVO> getAttachFileList(long apost_number){
		return applyAttachFileMapper.selectAttachFiles(apost_number);
	}
}
