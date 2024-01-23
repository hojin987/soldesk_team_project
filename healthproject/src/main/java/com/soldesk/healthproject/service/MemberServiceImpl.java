package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.MemberPagingCreatorDTO;
import com.soldesk.healthproject.common.paging.domain.NoticeBoardPagingCreatorDTO;
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
	public MemberPagingCreatorDTO getMemberList(BoardPagingDTO memberPaging){
		
		String beginDate = memberPaging.getBeginDate();
		String endDate = memberPaging.getEndDate();
		
		Date _endDate = null ;
		Calendar myCal = null ;
		
		if((beginDate != null && beginDate.length() != 0) 
			&& (endDate != null && endDate.length() != 0)) {
				
			SimpleDateFormat myDateFmt = new SimpleDateFormat("yyyy-MM-dd");
			try {
				_endDate = myDateFmt.parse(endDate);
				myCal = Calendar.getInstance() ;
				myCal.setTime(_endDate); 			//Sets this Calendar's time with the given Date
				
				myCal.add(Calendar.DAY_OF_MONTH, 1);
				
				endDate = myDateFmt.format(myCal.getTime()) ; //문자열로 변환
				System.out.println("변환 후 endDate: " + endDate);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			memberPaging.setEndDate(endDate);
			
			
		}
		
		return new MemberPagingCreatorDTO(memberMapper.selectRowTotal(memberPaging), 
										  memberPaging, 
										  memberMapper.selectMemberList(memberPaging)) ;
		
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
	
	//회원 비밀번호 수정
	@Override
	public void modifyMemberPw(MemberVO member, String current_pw, String new_pw) {
		
		//현재 입력한 비밀번호(current_pw)
		//새로 입력한 비밀번호(new_pw)
		
		//기존 회원의 정보
		MemberVO registeredMember = memberMapper.selectMember(member.getMember_id());
		String registeredPw = registeredMember.getMember_pw();
		System.out.println("기존 회원의 비밀번호: " + registeredMember.getMember_pw());
		
		//입력한 비밀번호 확인
		if(!pwencoder.matches(current_pw, registeredPw)) {
			System.out.println("비밀번호가 다릅니다.");
		} else {
			if(!member.getMember_pw().equals(new_pw)) {
				System.out.println("새로운 비밀번호 확인값이 다릅니다.");
			}else {
				member.setMember_pw(pwencoder.encode(member.getMember_pw()));
				memberMapper.updateMemberPw(member);
				System.out.println("비밀번호 변경완료");
			}
			
		}
		
	}
	
	//회원 탈퇴(delete_flag = 'Y')
	@Override
	public void setMemberDelete(String member_id) {
		memberMapper.deleteMember(member_id);
	}
	
	//회원 탈퇴(delete_flag = 'N')
	@Override
	public void setMemberCancel(String member_id) {
		memberMapper.cancelMember(member_id);
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