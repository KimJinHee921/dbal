package com.dbal.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbal.dao.MemberDAO;
import com.dbal.dao.TeamInfoDAO;
import com.dbal.dto.TeamInfoDTO;

public class LoginController implements Controller {
	private static final long serialVersionUID = 1L;

	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String member_id = request.getParameter("member_id");
		String passwd = request.getParameter("passwd");
		boolean result = MemberDAO.getInstance().loginCheck(member_id, passwd);
		
		if (result == true) {
			HttpSession session = request.getSession();
			session.setAttribute("member_id", member_id);
			//TeamInfoDTO dto  = TeamInfoDAO.getInstance().select(member_id);
			//session.setAttribute("team_id",dto.getTeam_id() );
			return FrontController.redirect + "/dbal/main/userHome.do";

		} else {
			try {
				PrintWriter out = response.getWriter();
				out.print("<script>");
				out.print("alert('login id error');");
				out.print("location='login.jsp';");
				out.print("</script>");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;

		}
	}
}