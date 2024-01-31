package com.soldesk.healthproject.common.paging.domain;

import java.util.List;

import com.soldesk.healthproject.domain.ApplyBoardVO;

import lombok.Getter;
import lombok.ToString;
@Getter
@ToString
public class ApplyBoardPagingCreatorDTO {
	
	private BoardPagingDTO applyboardPaging ;
	
	private int startPagingNum ;
	private int endPagingNum ;
	private boolean prev ;
	private boolean next ;
	private long rowTotal ; //행의 총 개수
	private int pagingNumCnt ; //기본 10
	private int lastPageNum ;
	private List<ApplyBoardVO> applyboardList ;
	
	public ApplyBoardPagingCreatorDTO(long rowTotal, 
			                       BoardPagingDTO applyboardPaging,
			                       List<ApplyBoardVO> applyboardList) {
		
		this.rowTotal = rowTotal ;
		this.applyboardPaging = applyboardPaging ;
		this.applyboardList = applyboardList ;
		this.pagingNumCnt = 10 ;
		
		//계산된 끝 페이징 번호:
		this.endPagingNum = (int) Math.ceil((double) applyboardPaging.getPageNum()/this.pagingNumCnt) * this.pagingNumCnt;
		
		//계산된 시작 페이징 번호:
		this.startPagingNum = this.endPagingNum - (this.pagingNumCnt -1) ;
		
		//총 페이지 수 = 맨 마지막 페이징번호
		this.lastPageNum = (int) Math.ceil((double)this.rowTotal / this.applyboardPaging.getRowAmountPerPage());
		
		//맨 마지막 페이지번호를 endPagingNum에 대입
		if (this.lastPageNum < this.endPagingNum) {
			this.endPagingNum = this.lastPageNum ;
		}
		
		//이전 버튼 표시(true) 여부
		this.prev = this.startPagingNum > 1 ;
		
		//다음 버튼 표시(true) 여부
		this.next = this.endPagingNum < this.lastPageNum ;
	}

}