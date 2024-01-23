package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.FreeBoardPagingCreatorDTO;
import com.soldesk.healthproject.domain.FreeBoardAttachFileVO;
import com.soldesk.healthproject.domain.FreeBoardVO;
import com.soldesk.healthproject.mapper.FreeBoardAttachFileMapper;
import com.soldesk.healthproject.mapper.FreeBoardMapper;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {

	private FreeBoardMapper freeBoardMapper;
	private FreeBoardAttachFileMapper freeBoardAttachFileMapper;


	public void setFreeBoardMapper(FreeBoardMapper freeBoardMapper,
			                       FreeBoardAttachFileMapper freeBoardAttachFileMapper) {
		this.freeBoardMapper = freeBoardMapper;
		this.freeBoardAttachFileMapper = freeBoardAttachFileMapper ;
	}

	@Autowired
	public void setFreeBoardMapper(FreeBoardMapper freeBoardMapper) {
		this.freeBoardMapper = freeBoardMapper;
	}
	// 게시물 목록 조회

	@Override
	public FreeBoardPagingCreatorDTO getBoardList(BoardPagingDTO freeboardPaging) {

		String beginDate = freeboardPaging.getBeginDate();
		String endDate = freeboardPaging.getEndDate();

		Date _endDate = null;
		Calendar myCal = null;

		if ((beginDate != null && beginDate.length() != 0) && (endDate != null && endDate.length() != 0)) {
			if (beginDate.equals(endDate)) {

				SimpleDateFormat myDateFmt = new SimpleDateFormat("yyyy-MM-dd");
				try {
					_endDate = myDateFmt.parse(endDate);// Parses text from the beginning of the given string to produce
														// a date
					myCal = Calendar.getInstance();
					myCal.setTime(_endDate); // Sets this Calendar's time with the given Date

					myCal.add(Calendar.DAY_OF_MONTH, 1);

					endDate = myDateFmt.format(myCal.getTime()); // 문자열로 변환
					System.out.println("변환 후 endDate: " + endDate);

				} catch (ParseException e) {
					e.printStackTrace();
				}

				freeboardPaging.setEndDate(endDate);
			}

		}

		return new FreeBoardPagingCreatorDTO(freeBoardMapper.selectRowTotal(freeboardPaging), freeboardPaging,
				freeBoardMapper.selectFreeBoardList(freeboardPaging));
	}

	// 게시물 등록
//	@Override
//	public long registerFreeBoard(FreeBoardVO freeBoard) {
//		freeBoardMapper.insertFreeBoard(freeBoard);
//
//		return freeBoard.getFpost_number();
//	}


	// 게시물 등록
	@Override // 저장된 게시물의 fpost_number 값을 반환
	@Transactional
	public long registerFreeBoard(FreeBoardVO freeboard) {

		freeBoardMapper.insertFreeBoard(freeboard);

		List<FreeBoardAttachFileVO> attachFileList = freeboard.getAttachFileList();

		if (attachFileList != null && attachFileList.size() > 0) {

			attachFileList.forEach(

					attachFile -> {
						attachFile.setFpost_number(freeboard.getFpost_number());
						freeBoardAttachFileMapper.insertAttachFile(attachFile);

					}); // forEach-end

		}

		return freeboard.getFpost_number();
	}

	//특정 게시물 조회: 특정 게시물 하나의 데이터를 가져옴
	@Override
	@Transactional
	public FreeBoardVO getFreeBoard(long fpost_number, String result) {
		
		FreeBoardVO freeboard = freeBoardMapper.selectFreeBoard(fpost_number) ;
		
		if (result == null) {//목록페이지에서 조회요청 시에만
			freeBoardMapper.updateFviewCount(fpost_number) ;
		}
		
		System.out.println("freeBoard: " + freeboard);
		
		return freeboard ; 
		
	}
	
	//특정 게시물 수정 삭제 화면 호출 
	@Override
	public FreeBoardVO getFreeBoard2(long fpost_number) {
		
		FreeBoardVO freeboard = freeBoardMapper.selectFreeBoard2(fpost_number);
		System.out.println("freeBoard: " + freeboard);

		return freeboard ; 
		
	}

	//특정 게시물 수정
	@Override
	@Transactional
	public boolean modifyFreeBoard(FreeBoardVO freeboard) {
		
		//게시물 수정
		//첨부파일 정보 수정(기존 첨부파일정보 삭제 후, 수정페이지에서 전달된 파일정보를 입력)
		
		long fpost_number = freeboard.getFpost_number();

		boolean boardModifyResult = (freeBoardMapper.updateFreeBoard(freeboard) == 1);
		
		freeBoardAttachFileMapper.deleteAttachFiles(fpost_number); 
		
		List<FreeBoardAttachFileVO> attachFileList = freeboard.getAttachFileList() ;
		
		if (boardModifyResult && attachFileList != null) {
			for(FreeBoardAttachFileVO attachFile : attachFileList) {
				attachFile.setFpost_number(fpost_number);
				freeBoardAttachFileMapper.insertAttachFile(attachFile) ;	
			}
			
		}

		return boardModifyResult;
		

	}

//게시물삭제: 실제삭제(첨부파일 삭제 후, 게시물 삭제)
//게시물삭제: 블라인드 처리	
	@Override
	@Transactional
	public boolean modifyFdeleteFlag(long fpost_number) {
		
		int rows = freeBoardMapper.updateFdeleteFlag(fpost_number);

		return (rows == 1) ;
	}
	
	
	//특정 게시물의 첨부파일 목록 조회
	@Override
	public List<FreeBoardAttachFileVO> getAttachFileList(Long fpost_number) {
		return freeBoardAttachFileMapper.selectAttachFiles(fpost_number) ;
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
	
	//톰캣 서버의 업로드 파일 삭제 메서드
//	private void removeAttachFiles(List<FreeBoardAttachFileVO> attachFileList) {
//		
//		if(attachFileList == null || attachFileList.size() == 0) {
//			return ;
//		}
//		
//		System.out.println("삭제시작: 삭제파일 목록:======\n" + attachFileList.toString());
//		
////		attachFileList.forEach(
////				
////				attachFile -> {
////					//하나의 VO에 대한 실행코드를 작성, forEach 메서드가 반복함
////				}
////		);
//		
//		for(FreeBoardAttachFileVO attachFile : attachFileList) {
//			//하나의 VO에 대한 실행코드를 작성
//			Path filePath = Paths.get(attachFile.getRepoPath() ,
//								      attachFile.getUploadPath() ,
//								      attachFile.getUuid() + "_" + attachFile.getFileName()  );
//			
//			boolean deleteFileResult = false ;
//			
//			try {
//				deleteFileResult = Files.deleteIfExists(filePath) ;
//				
//				if(attachFile.getFileType().equals("I")) {
//					Path thumbnail = Paths.get(attachFile.getRepoPath() ,
//											   attachFile.getUploadPath() ,
//											   "s_" + attachFile.getUuid() + "_" + attachFile.getFileName()  );
//					
//					Files.deleteIfExists(thumbnail) ;
//							
//				}
//				
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			
//			
//		}
//		
//		
//	}

}
