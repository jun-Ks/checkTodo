package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.ListVO;
import db.ListDAO;

@WebServlet("/regList.do")
public class RegListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String todoInput = request.getParameter("todoInput");
		String id = request.getParameter("reg_id");
		String time = request.getParameter("todo_time");
		
		
		ListDAO lDao = new ListDAO();
		ListVO lVo = new ListVO();
		lVo.setId(id);
		lVo.setList(todoInput);
		lVo.setTodo_time(time);
		
		int result = lDao.insert(lVo);
		
		request.setAttribute("result", result);
		request.getRequestDispatcher("regToday.jsp").forward(request, response);
	}

}
