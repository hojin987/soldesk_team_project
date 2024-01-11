package com.spring5.mypro00.test02_mapper;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/mybatis-context.xml"})
@Log4j
public class DataSourceTests {
	
	private DataSource dataSource ;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource ;
	}
	
//	@Setter(onMethod_ = @Autowired)
//	private DataSource dataSource ;
//	
	//@Test
//	public void testConnection() {
//		try {
//			Connection con = dataSource.getConnection() ;
//			log.info(con);
//			
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
//	@Setter(onMethod_ = @Autowired)
//	private SqlSessionFactory sqlSessionFactroy1 ;
//	
//	@Test
//	public void testMyBatis2() {
//
//		SqlSession sqlSession = sqlSessionFactroy1.openSession() ;
//		
//		log.info(sqlSession);
//		
//	}
	
	@Setter(onMethod_ = { @Autowired } )
	private SqlSessionTemplate sqlSession ;
	
	
	@Test
	public void testMyBatis() {
		
		//SqlSessionTemplate 까지 사용할 때
		Connection conn = sqlSession.getConnection() ;
		log.info(conn);
		log.info(sqlSession);
	}	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
