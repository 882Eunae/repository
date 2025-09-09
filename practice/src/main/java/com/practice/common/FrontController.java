package com.practice.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.practice.test.control.TestControl;

public class FrontController extends HttpServlet {

    private Map<String, Control> routes = new HashMap<>();

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config); // 안전하게 부모 init 호출
        // URL -> Control 매핑
        routes.put("/test.do", new TestControl());
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // /practice/test.do  에서  /test.do 추출
        String uri = req.getRequestURI();
        String ctx = req.getContextPath();
        String path = uri.substring(ctx.length());

        Control handler = routes.get(path);
        if (handler != null) {
            handler.exec(req, resp); // 여기서 TestControl이 실행되고, 내부에서 JSP로 forward
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}