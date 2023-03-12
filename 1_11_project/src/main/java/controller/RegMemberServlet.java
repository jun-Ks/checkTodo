package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MemberVO;
import db.MemberDAO;

@WebServlet("/regMem.do")
public class RegMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	MemberDAO mDao = new MemberDAO();
	MemberVO mVo = new MemberVO();

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("reg_id");
		String pw = request.getParameter("reg_pw");
		String nickname = request.getParameter("reg_nickname");
		
		mVo.setId(id);
		mVo.setPw(pw);
		mVo.setNickName(nickname);
		
		int result = mDao.insert(mVo);
		
		request.setAttribute("reg_result", result);
		request.getRequestDispatcher("main.jsp").forward(request, response);
		
	}

}
