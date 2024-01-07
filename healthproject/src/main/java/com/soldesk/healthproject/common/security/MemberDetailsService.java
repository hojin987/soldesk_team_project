package com.soldesk.healthproject.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class MemberDetailsService implements UserDetailsService {
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper MemberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("Load User By UserName: " + username);
		
		MemberVO member = MemberMapper.selectMember(username);
		log.warn("MyMemberMapper에 의해서 반환된 MemberVO: " + member);
		
		return member == null? null : new MemberUser(member);
	}
	
	
	
	
}
