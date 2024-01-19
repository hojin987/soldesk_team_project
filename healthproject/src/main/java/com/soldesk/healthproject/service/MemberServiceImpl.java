package com.soldesk.healthproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.domain.AuthorityVO;
import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {
	
	private MemberMapper memberMapper;
	
	@Autowired
	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}
	
	public MemberServiceImpl() {
		System.out.println("MemberRegisterServiceImpl의 기본생성자");
	}
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	//회원 목록 조회
	@Override
	public List<MemberVO> getMemberList(){
		return memberMapper.selectMemberList();
	}
	
	
	//회원 정보 조회
	@Override
	public MemberVO getMember(String member_id) {
		return memberMapper.selectMember(member_id);
	}
	
	//회원 등록
	@Override
	public String registerMember(MemberVO member) {
		
		//비밀번호 암호화
		member.setMember_pw(pwencoder.encode(member.getMember_pw()));
		
		//회원 정보 등록
		memberMapper.insertMember(member);
		
		//회원 권한 부여
		String member_id = member.getMember_id();
		String authority = "ROLE_USER";
		
		AuthorityVO memberAuthority = new AuthorityVO(member_id, authority);
		
		memberMapper.insertMemberAuthority(memberAuthority);
		
		return member.getMember_id();
	}
	
	//회원 권한 부여
	@Override
	public long registerMemberAuthority(AuthorityVO authority) {
		return memberMapper.insertMemberAuthority(authority);
	}
	
	//회원 정보 수정
	@Override
	public void modifyMember(MemberVO member) {
		memberMapper.updateMember(member);
	}
	
	//회원 탈퇴(delete_flag = 'Y')
	@Override
	public void setMemberDelete(String member_id) {
		memberMapper.deleteMember(member_id);
	}
	
	//회원 권한 삭제
	@Override
	public void removeMemberAuthority(String member_id) {
		memberMapper.removeMemberAuthority(member_id);
	}
	
	//회원 삭제(DB에서 삭제)
	@Override
	public void removeMember(String member_id) {
		memberMapper.removeMember(member_id);
	}

	
	
	
}
