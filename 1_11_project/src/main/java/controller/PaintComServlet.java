package controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/paint.do")
public class PaintComServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String id = request.getParameter("id");
		String yearMonth = year + "-" + month;
		
		ListDAO lDao = new ListDAO();
		
		ArrayList<ListVO> list = lDao.paintCom(id, yearMonth);
		PrintWriter out = response.getWriter();
		ArrayList<String> sdf_list = new ArrayList<>();
		for(int i = 0; i < list.size(); i++) {
			char zero = list.get(i).getReg_date().toString().charAt(8);
			
			if(zero == '0') {
				Date date = list.get(i).getReg_date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
				
				String sdf_date = sdf.format(date);
				sdf_list.add(sdf_date);
				
			}else {
				Date date2 = list.get(i).getReg_date();
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-M-d");
				String sdf_date2 = sdf2.format(date2);
				
				sdf_list.add(sdf_date2);
			}
			
		}
		System.out.println(sdf_list);
		JSONArray jarr = new JSONArray(sdf_list);
		out.print(jarr);
	}

}
