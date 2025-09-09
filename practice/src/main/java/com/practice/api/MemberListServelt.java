package com.practice.api;

import java.io.IOException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.practice.common.DataSource;
import com.practice.test.mapper.TestMapper;
import com.practice.test.vo.MemberVO;
@WebServlet("/api/members")
public class MemberListServelt extends HttpServlet  {
	  @Override
	  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	    resp.setContentType("application/json; charset=UTF-8");
	    try (SqlSession session = DataSource.getInstance().openSession(true)) {
	      List<MemberVO> list = session.getMapper(TestMapper.class).memberList();
	      String json = new Gson().toJson(list);
	      resp.getWriter().write(json);
	    }
	  }
}
