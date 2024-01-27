package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.domain.FreeBoardVO;
import com.soldesk.healthproject.mapper.FreeBoardMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	private FreeBoardMapper freeBoardMapper;
	
	public FreeBoardServiceImpl() {
		System.out.println("FreeBoardServiceImpl의 기본생성자");
	}
	
	@Autowired
	public void setFreeBoardMapper(FreeBoardMapper freeBoardMapper) {
		this.freeBoardMapper = freeBoardMapper;
	}
	
	
	//게시물 목록 조회

	@Override
	public FreeBoardPagingCreatorDTO getBoardList(BoardPagingDTO freeboardPaging) {
					
		String beginDate = freeboardPaging.getBeginDate() ;
		String endDate = freeboardPaging.getEndDate() ;
		
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
				
				freeboardPaging.setEndDate(endDate);
			}
			
		}
		
		return new FreeBoardPagingCreatorDTO(freeBoardMapper.selectRowTotal(freeboardPaging), 
										   freeboardPaging, 
										   freeBoardMapper.selectFreeBoardList(freeboardPaging)) ;
	}
	//게시물 등록
	@Override
	public long registerFreeBoard(FreeBoardVO freeBoard) {
		freeBoardMapper.insertFreeBoard(freeBoard);
		
		return freeBoard.getFpost_number();
	}
	
	//게시물 조회
	@Override
	public FreeBoardVO getFreeBoard(long fpost_number) {
		freeBoardMapper.updateFviewCount(fpost_number);
		return freeBoardMapper.selectFreeBoard(fpost_number);
	}
	
	//게시물 수정
	@Override
	public boolean modifyFreeBoard(FreeBoardVO freeBoard) {
		return freeBoardMapper.updateFreeBoard(freeBoard) == 1;
	}
	
	//게시물 삭제 - 삭제플래그 1로 수정
	@Override
	public boolean setFreeBoardDeleted(long fpost_number) {
		return freeBoardMapper.updateFdeleteFlag(fpost_number) == 1;
	}

	@Override
	public boolean removeFreeBoard(long fpost_number) {
		return freeBoardMapper.deleteFreeBoard(fpost_number) == 1;
	}
	

	
}
