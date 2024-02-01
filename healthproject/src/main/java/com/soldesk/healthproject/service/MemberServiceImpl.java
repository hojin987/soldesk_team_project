package com.soldesk.healthproject.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.soldesk.healthproject.common.paging.domain.BoardPagingDTO;
import com.soldesk.healthproject.common.paging.domain.MemberPagingCreatorDTO;
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
	
	//강사 권한 부여
	@Override
	public long registerTrainerAuthority(MemberVO member) {
		
		String member_id = member.getMember_id();
		String auth = "TRAINER";
				
		AuthorityVO memberAuthority = new AuthorityVO(member_id, auth);
				
		return memberMapper.insertMemberAuthority(memberAuthority);
	}
	
	//강사 권한 삭제
	@Override
	public long removeTrainerAuthority(MemberVO member) {
		
		String member_id = member.getMember_id();
		String auth = "TRAINER";
				
		AuthorityVO memberAuthority = new AuthorityVO(member_id, auth);
				
		return memberMapper.deleteMemberAuthority(memberAuthority);
	}
	
	//회원 정보 수정
	@Override
	public void modifyMember(MemberVO member) {
		
		//티켓 선택에 따른 시작/종료일, PT 횟수 설정
	    String ticketNumber = member.getTicket_number();
	    Date today = new Date();
	    Calendar calendar = Calendar.getInstance();
	    calendar.setTime(today);
	    
	    if(ticketNumber.equals("Ticket1")) {
	        calendar.add(Calendar.MONTH, 3); //3개월
	        member.setPt_count(0);
	    } else if(ticketNumber.equals("Ticket2")) {
	        calendar.add(Calendar.MONTH, 6); //6개월
	        member.setPt_count(0);
	    } else if(ticketNumber.equals("Ticket3")) {
	        calendar.add(Calendar.MONTH, 12); //12개월
	        member.setPt_count(0);
	    } else if(ticketNumber.equals("Ticket4")) {
	        calendar.add(Calendar.MONTH, 12); //12개월
	        member.setPt_count(10); //10회
	    } else if(ticketNumber.equals("Ticket5")) {
	        calendar.add(Calendar.MONTH, 12); //12개월
	        member.setPt_count(20); //20회
	    } else if(ticketNumber.equals("Ticket6")) {
	        calendar.add(Calendar.MONTH, 12); //12개월
	        member.setPt_count(30); //30회
	    } else if(ticketNumber.equals("Ticket7")) {
	        calendar.add(Calendar.MONTH, 3); //12개월
	        member.setPt_count(10); //30회
	    }

	    member.setTicket_start_date(new java.sql.Date(today.getTime())); //시작일은 오늘
	    member.setTicket_end_date(new java.sql.Date(calendar.getTime().getTime())); //종료일은 계산된 날짜
	    
		memberMapper.updateMember(member);
	}
	
	//회원 비밀번호 수정
	@Override
	public void modifyMemberPw(MemberVO member, String current_pw, String new_pw) {
		
		//기존 회원의 정보
		MemberVO registeredMember = memberMapper.selectMember(member.getMember_id());
		String registeredPw = registeredMember.getMember_pw();
		
		//입력한 비밀번호 확인
		if(!pwencoder.matches(current_pw, registeredPw)) {
		} else {
			if(!member.getMember_pw().equals(new_pw)) {

			}else {
				member.setMember_pw(pwencoder.encode(member.getMember_pw()));
				memberMapper.updateMemberPw(member);

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

	//회원 아이디 중복검사
	@Override
	public boolean checkDupMemberId(String member_id) {
		return memberMapper.checkDupMemberId(member_id) == 1 ? true : false;
	}
	
	//회원 비밀번호 일치검사
	@Override
	public boolean checkPassword(String member_id, String current_pw) {
		MemberVO member = memberMapper.selectMember(member_id);
		String member_pw = member.getMember_pw();
		
		//입력한 비밀번호 확인
		if(!pwencoder.matches(current_pw, member_pw)) {
			return false;
		} else {
			return true;
		}
	}
	
	
}
