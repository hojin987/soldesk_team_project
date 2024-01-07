package com.soldesk.healthproject.common.security;

import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.soldesk.healthproject.domain.MemberVO;

import lombok.Getter;

@Getter
public class MemberUser extends User {
	
	private MemberVO member;
	
	public MemberUser(MemberVO member) {
		super(member.getMember_id(),
			  member.getMember_pw(),
			  member.getAuthorityList()
			  		.stream()
			  		.map(auth -> new SimpleGrantedAuthority(auth.getAuthority()))
			  		.collect(Collectors.toList())
			 );
		
		this.member = member;
		
	}
	
	

}
