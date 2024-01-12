package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.ApplyBoardPagingDTO;
import com.soldesk.healthproject.domain.ApplyBoardVO;
import com.soldesk.healthproject.mapper.ApplyBoardMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ApplyBoardServiceImpl implements ApplyBoardService {
	
	private ApplyBoardMapper applyBoardMapper;
	
	public ApplyBoardServiceImpl() {
		System.out.println("ApplyBoardServiceImpl의 기본생성자");
	}
	
	@Autowired
	public void setApplyBoardMapper(ApplyBoardMapper applyBoardMapper) {
		this.applyBoardMapper = applyBoardMapper;
	}
	
	
	//게시물 목록 조회

	@Override
	public ApplyBoardPagingCreatorDTO getBoardList(ApplyBoardPagingDTO applyboardPaging) {
					
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
	@Override
	public long registerApplyBoard(ApplyBoardVO applyBoard) {
		applyBoardMapper.insertApplyBoard(applyBoard);
		
		return applyBoard.getApost_number();
	}
	
	//게시물 조회
	@Override
	public ApplyBoardVO getApplyBoard(long apost_number) {
		applyBoardMapper.updateAviewCount(apost_number);
		return applyBoardMapper.selectApplyBoard(apost_number);
	}
	
	//게시물 수정
	@Override
	public boolean modifyApplyBoard(ApplyBoardVO applyBoard) {
		return applyBoardMapper.updateApplyBoard(applyBoard) == 1;
	}
	
	//게시물 삭제 - 삭제플래그 1로 수정
	@Override
	public boolean setApplyBoardDeleted(long apost_number) {
		return applyBoardMapper.updateAdeleteFlag(apost_number) == 1;
	}

	@Override
	public boolean removeApplyBoard(long apost_number) {
		return applyBoardMapper.deleteApplyBoard(apost_number) == 1;
	}
	
}
