package com.practice.test.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;


import com.practice.common.Control;
import com.practice.common.DataSource;
import com.practice.test.mapper.TestMapper;
import com.practice.test.vo.MemberVO;

public class TestControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("실행됨");
		
		SqlSession session = DataSource.getInstance().openSession(true);
		TestMapper mapper = session.getMapper(TestMapper.class);
		
		 List<MemberVO> memberList = mapper.memberList();
		 
		 for(MemberVO test : memberList) {
			 System.out.println(test.getUserId());
		 }
		 
		 req.setAttribute("test", memberList);	 
		 req.getRequestDispatcher("/index.jsp").forward(req, resp);
		 
		 
		 
	}
	
	public static void main(String[] args) {
		System.out.println("session받아오기전");
		SqlSession session = DataSource.getInstance().openSession(true);
		System.out.println("세션받아온후");
		TestMapper mapper = session.getMapper(TestMapper.class);
		System.out.println("mapper 잘받아옴");
		 List<MemberVO> memberList = mapper.memberList();
		
		 System.out.println("멤버값 받아오는지 확인중....");
		 for(MemberVO test : memberList) {
			 System.out.println(test.getUserId());
		 }
	}
	
}
