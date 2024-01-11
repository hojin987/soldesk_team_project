package com.spring5.mypro00.test02_mapper;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.soldesk.healthproject.domain.MemberVO;
import com.soldesk.healthproject.mapper.MemberMapper;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration      //폴더 구분자로 \\ 사용 시 오류 발생. /를 사용하세요.
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/mybatis-context.xml" ,
                       "file:src/main/webapp/WEB-INF/spring/security-context.xml" ,
                       "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@NoArgsConstructor
public class MyMemberMapperTests {

    //사용자 패스워드 암호화 
//    @Setter(onMethod_ = @Autowired)
//    private PasswordEncoder pwencoder;
//    
//    @Setter(onMethod_ = @Autowired)
//    private MemberMapper myMemberMapper;
//
//    //회원 등록 테스트: 테스트(1)
//    @Test
//    public void testInsertMyMember() {
//    	
//        MemberVO member = new MemberVO();
//        
//        Date toDate = new Date(19980101);
//        
//        for(int i = 6; i < 99; i++) {
//        	
//        	member.setMember_pw(pwencoder.encode("pw" + i));
//        	member.setMember_email("user" + i + "@example.com");
//        	member.setMember_birth(toDate);
//        	member.setMember_phonenumber("010-0000-00" + i);
//
//            if(i <= 70) {
//            	member.setMember_id("user" + i);
//            	member.setMember_name("일반사용자" + i);
//            
//            } else if (i <= 80) {
//            	member.setMember_id("member" + i);
//            	member.setMember_name("중급사용자" + i);
//                
//            } else if (i <= 90) {
//            	member.setMember_id("manager" + i);
//            	member.setMember_name("운영자" + i);
//                
//            } else {
//            	member.setMember_id("admin" + i);
//            	member.setMember_name("관리자" + i);
//            }
//            
//            log.info(member);            
//            myMemberMapper.insertMember(member);
//        } //for-End
//    }
    
//    //회원 권한 등록 테스트: 테스트(2)
//    @Test
//    public void testInsertMyMemAuthority() {
//		
//        MyAuthorityVO myAuthority = new MyAuthorityVO();
//        
//        for(int i = 0; i < 100; i++) {
//
//            if(i <= 70) {
//                myAuthority.setUserId("user" + i);
//                myAuthority.setAuthority("ROLE_USER");
//                
//            } else if (i <= 80) {
//                myAuthority.setUserId("member" + i);
//                myAuthority.setAuthority("ROLE_MEMBER");
//                
//            } else if (i <= 90) {
//                myAuthority.setUserId("manager" + i);
//                myAuthority.setAuthority("ROLE_MANAGER");
//                
//            } else {
//                myAuthority.setUserId("admin" + i);
//                myAuthority.setAuthority("ADMIN");
//                
//            }
//            log.info(myAuthority);
//            myMemberMapper.insertMyMemAuthority(myAuthority) ;
//        } //for-End
//        
//        myAuthority.setUserId("admin99");
//        myAuthority.setAuthority("ROLE_MANAGER");
//        myMemberMapper.insertMyMemAuthority(myAuthority);
//        
//        myAuthority.setUserId("admin99");
//        myAuthority.setAuthority("ROLE_MEMBER");
//        myMemberMapper.insertMyMemAuthority(myAuthority);
//        
//        myAuthority.setUserId("admin91");
//        myAuthority.setAuthority("ROLE_MANAGER");
//        myMemberMapper.insertMyMemAuthority(myAuthority);
//    }
//    
    //회원 정보 조회 테스트: 테스트(3) 
//    @Test
//    public void testRead() {
//        MyMemberVO member = myMemberMapper.selectMyMember("admin99");
//        log.info(member);
//        
//        member.getAuthorityList().forEach(authority -> log.info(authority));
//    }

} //class-end

