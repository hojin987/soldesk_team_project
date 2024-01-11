package com.soldesk.healthproject.service;

import com.soldesk.healthproject.domain.AuthorityVO;
import com.soldesk.healthproject.domain.MemberVO;

public interface MemberRegisterService {
	
	//회원 목록 조회
	
	//회원 조회: 회원 권한도 함께 조회됨(스프링 시큐리티 사용)
	public MemberVO getMember(String member_id);
	
	//회원 등록: 회원 등록 시 회원 권한 추가도 같이 수행
	public String registerMember(MemberVO member);
	
	//회원 권한 추가
	public long registerMemberAuthority(AuthorityVO authority);
	
}
