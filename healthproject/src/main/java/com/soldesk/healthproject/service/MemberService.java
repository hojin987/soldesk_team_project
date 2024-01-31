package com.soldesk.healthproject.service;

import java.util.List;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.MemberPagingCreatorDTO;
import com.soldesk.healthproject.domain.AuthorityVO;
import com.soldesk.healthproject.domain.MemberVO;

public interface MemberService {
	
	//회원 목록 조회
	public MemberPagingCreatorDTO getMemberList(BoardPagingDTO memberPaging);
	
	//회원 조회: 회원 권한도 함께 조회됨(스프링 시큐리티 사용)
	public MemberVO getMember(String member_id);
	
	//회원 등록: 회원 등록 시 회원 권한 추가도 같이 수행
	public String registerMember(MemberVO member);
	
	//회원(강사) 권한 추가
	public long registerTrainerAuthority(MemberVO member);
	
	//강사 권한 삭제
	public long removeTrainerAuthority(MemberVO member);
	
	//회원 수정
	public void modifyMember(MemberVO member);
	
	//회원 비밀번호 수정
	public void modifyMemberPw(MemberVO member, String current_pw, String new_pw);

	//회원 탈퇴(delete_flag = 'Y')
	public void setMemberDelete(String member_id);
	
	//회원 탈퇴(delete_flag = 'N')
	public void setMemberCancel(String member_id);
	
	//회원 권한 삭제
	public void removeMemberAuthority(String member_id);
	
	//회원 삭제
	public void removeMember(String member_id);
	
	//회원 아이디 중복검사
	public boolean checkDupMemberId(String member_id);
	
}
