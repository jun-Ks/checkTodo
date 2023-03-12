package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.ListVO;
import db.ListDAO;

@WebServlet("/update.do")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String _listNo = request.getParameter("listNo");
		int listNo = Integer.parseInt(_listNo);
		String todolist = request.getParameter("list");
		String id = request.getParameter("id");
		String todo_time = request.getParameter("time");
		
		ListDAO lDao = new ListDAO();
		ListVO lVo = new ListVO();
		
		lVo.setListNo(listNo);
		lVo.setId(id);
		lVo.setList(todolist);
		lVo.setTodo_time(todo_time);
		
		int result = lDao.update(lVo);
		
		PrintWriter out = response.getWriter();
		out.print(result);
	}

}
