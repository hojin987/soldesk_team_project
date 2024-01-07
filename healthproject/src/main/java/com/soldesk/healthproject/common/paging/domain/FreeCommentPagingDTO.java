package com.soldesk.healthproject.common.paging.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeCommentPagingDTO {
	
	private long fpost_number ;
	private int freePageNum ;
	private int rowAmountPerFreePage ;

	
//	public FreeBoardPagingDTO() {
//		this.pageNum = 1 ;
//		this.rowAmountPerPage = 10 ;
//	}

	//생성자: 목록 화면에서 사용자가 표시할 행수를 선택하고 페이징 번호 클릭 시,
	//페이지번호와 행수를 각각 사용자가 선택한 페이징번호와 표시행수로 전달
	public FreeCommentPagingDTO(Long fpost_number, Integer freePageNum) {
		
		this.fpost_number = fpost_number ;
		
		if (freePageNum == null) {
			this.freePageNum = 1 ;
			
		} else {
			this.freePageNum = freePageNum;
		}
		
		this.rowAmountPerFreePage = 10 ;
		
	}
	

	

}
