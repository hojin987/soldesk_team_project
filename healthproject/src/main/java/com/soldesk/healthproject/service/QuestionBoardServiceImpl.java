package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.common.paging.domain.QuestionBoardPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.QuestionBoardPagingDTO;
import com.soldesk.healthproject.domain.QuestionBoardVO;
import com.soldesk.healthproject.mapper.QuestionBoardMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class QuestionBoardServiceImpl implements QuestionBoardService {
	
	private QuestionBoardMapper questionBoardMapper;
	
	public QuestionBoardServiceImpl() {
		System.out.println("QuestionBoardServiceImpl의 기본생성자");
	}
	
	@Autowired
	public void setQuestionBoardMapper(QuestionBoardMapper questionBoardMapper) {
		this.questionBoardMapper = questionBoardMapper;
	}
	

	//게시물 목록 조회

	@Override
	public QuestionBoardPagingCreatorDTO getBoardList(QuestionBoardPagingDTO questionboardPaging) {
					
		String beginDate = questionboardPaging.getBeginDate() ;
		String endDate = questionboardPaging.getEndDate() ;
		
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
				
				questionboardPaging.setEndDate(endDate);
			}
			
		}
		
		return new QuestionBoardPagingCreatorDTO(questionBoardMapper.selectRowTotal(questionboardPaging), 
											   questionboardPaging, 
											   questionBoardMapper.selectQuestionBoardList(questionboardPaging)) ;
	}
	//게시물 등록
	@Override
	public long registerQuestionBoard(QuestionBoardVO questionBoard) {
		questionBoardMapper.insertQuestionBoard(questionBoard);
		
		return questionBoard.getQpost_number();
	}
	
	//게시물 조회
	@Override
	public QuestionBoardVO getQuestionBoard(long qpost_number) {
		questionBoardMapper.updateQviewCount(qpost_number);
		return questionBoardMapper.selectQuestionBoard(qpost_number);
	}
	
	//게시물 수정
	@Override
	public boolean modifyQuestionBoard(QuestionBoardVO questionBoard) {
		return questionBoardMapper.updateQuestionBoard(questionBoard) == 1;
	}
	
	//게시물 삭제 - 삭제플래그 1로 수정
	@Override
	public boolean setQuestionBoardDeleted(long qpost_number) {
		return questionBoardMapper.updateQdeleteFlag(qpost_number) == 1;
	}

	@Override
	public boolean removeQuestionBoard(long qpost_number) {
		return questionBoardMapper.deleteQuestionBoard(qpost_number) == 1;
	}
	
}
