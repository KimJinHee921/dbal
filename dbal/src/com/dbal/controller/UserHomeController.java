package com.dbal.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbal.dao.TeamDAO;

public class UserHomeController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {

		String member_id = null;
		boolean isLoginSuccess = false;

		// 사용자 로그인 Session 정보 확인
		HttpSession session = request.getSession();
		if (session != null) {
			member_id = (String) session.getAttribute("member_id");
			// 로그인 사용자 ID 값 확인 
			if (member_id != null) {
				isLoginSuccess = true;
			} 
		}
		
		// 로그인 성공 유무에 따라서 화면 이동 다름
		if (isLoginSuccess) {
			List<HashMap<String, Object>> team_list = TeamDAO.getInstance().selectnavinfo(member_id);
			request.setAttribute("team_list", team_list);
			return "/main/userHome.jsp";
		} else {
			return FrontController.redirect + "../member/login.jsp";
		}
	}
}
