package com.soldesk.healthproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.domain.AuthorityVO;
import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberRegisterServiceImpl implements MemberRegisterService {
	
	private MemberMapper memberMapper;
	
	@Autowired
	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}
	
	public MemberRegisterServiceImpl() {
		System.out.println("MemberRegisterServiceImpl의 기본생성자");
	}
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	//회원정보조회
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

}
