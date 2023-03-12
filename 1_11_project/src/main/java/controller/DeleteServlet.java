package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.ListDAO;

@WebServlet("/delete.do")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String _listNo = request.getParameter("listNo");
		int listNo = Integer.parseInt(_listNo);
		
		ListDAO lDao = new ListDAO();
		int result = lDao.delete(listNo);
		
		PrintWriter out = response.getWriter();
		out.print(result);
	}

}
