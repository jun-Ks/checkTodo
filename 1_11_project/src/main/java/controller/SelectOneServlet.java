package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import common.ListVO;
import db.ListDAO;

@WebServlet("/selectOne.do")
public class SelectOneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String id = request.getParameter("id");
		String list_date = year + "-" + month + "-" + day;
		
		ListDAO lDao = new ListDAO();
		
		ArrayList<ListVO> list = lDao.selectOne(id, list_date);
		JSONArray jarr = new JSONArray(list);
		
		PrintWriter out = response.getWriter();
		out.print(jarr);
	}


}
