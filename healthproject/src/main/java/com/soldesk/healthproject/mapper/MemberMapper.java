package com.soldesk.healthproject.mapper;

import java.util.List;

import com.soldesk.healthproject.domain.AuthorityVO;
import com.soldesk.healthproject.domain.MemberVO;

public interface MemberMapper {
	
	//회원 목록 조회
	public List<MemberVO> selectMemberList();
	
	//회원 조회: 회원 권한도 함께 조회됨(스프링 시큐리티 사용)
	public MemberVO selectMember(String member_id);
	
	//회원 등록: 회원 등록 시 회원 권한 추가도 같이 수행
	public Integer insertMember(MemberVO member);
	
	//회원 권한 추가
	public Integer insertMemberAuthority(AuthorityVO authority);
	
	//회원 정보 수정
	public long updateMember(MemberVO member);
	
	//회원 탈퇴 (delete_flag = 'Y')
	public long deleteMember(String member_id);
	
	//회원 권한 삭제
	public long removeMemberAuthority(String member_id);
	
	//회원 삭제 (db에서 삭제)
	public long removeMember(String member_id);
}
