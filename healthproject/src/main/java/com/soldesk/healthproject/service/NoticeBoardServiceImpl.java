package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingCreatorDTO;
import com.soldesk.healthproject.domain.NoticeBoardVO;
import com.soldesk.healthproject.mapper.NoticeBoardMapper;

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
	public NoticeBoardPagingCreatorDTO getBoardList(BoardPagingDTO noticeboardPaging) {
					
		String beginDate = noticeboardPaging.getBeginDate() ;
		String endDate = noticeboardPaging.getEndDate() ;
		
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
				
				noticeboardPaging.setEndDate(endDate);
			}
			
		}
		
		return new NoticeBoardPagingCreatorDTO(noticeBoardMapper.selectRowTotal(noticeboardPaging), 
										   noticeboardPaging, 
										   noticeBoardMapper.selectNoticeBoardList(noticeboardPaging)) ;
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
		noticeBoardMapper.updateNviewCount(npost_number);
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
