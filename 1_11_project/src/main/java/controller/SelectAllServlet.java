package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import common.ListVO;
import db.ListDAO;

@WebServlet("/selectAll.do")
public class SelectAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		ListDAO lDao = new ListDAO();
		
		ArrayList<ListVO> list = lDao.selectAll(id);

		JSONArray jArr = new JSONArray(list);
		
		PrintWriter out = response.getWriter();
		
		out.print(jArr.toString());
	}


}
