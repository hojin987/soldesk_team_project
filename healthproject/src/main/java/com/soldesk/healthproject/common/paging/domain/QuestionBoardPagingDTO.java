package com.soldesk.healthproject.common.paging.domain;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@EqualsAndHashCode
public class QuestionBoardPagingDTO {
	private int pageNum;
	private int rowAmountPerPage;
	private String scope; // 검색범위(scope - ftitle: T, fcontent: C, fwriter: W)
	private String keyword; // 검색어

	// @DateTimeFormat(pattern = "yyyy-MM-dd") //java.util.Date
	private String beginDate;

	// @DateTimeFormat(pattern = "yyyy-MM-dd") //java.util.Date
	private String endDate;

	// 마이바티스 Setter
	public String[] getMyScopeArr() {
		return scope == null ? new String[] {} : scope.split(""); // ["T", "W"]

	}

	public QuestionBoardPagingDTO(Integer pageNum, Integer rowAmountPerPage) {
		
		if (pageNum == null || pageNum <= 0) {
			this.pageNum = 1 ;
			
		} else {
			this.pageNum = pageNum;
		}
		
		if (rowAmountPerPage == null) {
			this.rowAmountPerPage = 10 ;
		
		} else {
			this.rowAmountPerPage = rowAmountPerPage;
		
		}
		
	}

}