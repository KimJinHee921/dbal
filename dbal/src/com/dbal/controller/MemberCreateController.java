package com.dbal.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dbal.dao.MemberDAO;
import com.dbal.dto.MemberDTO;

public class MemberCreateController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String member_id = request.getParameter("member_id");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String passwd = request.getParameter("passwd");
				
		if (member_id.isEmpty() || email.isEmpty() || name.isEmpty() || passwd.isEmpty()) {
			request.setAttribute("error", "입력해주세요");
			return "/MemberCreate.jsp";
		}

		MemberDTO dto = new MemberDTO();
		dto.setMember_id(member_id);
		dto.setEmail(email);
		dto.setName(name);
		dto.setPasswd(passwd);
		

		MemberDAO.getInstance().MemberCreate(dto);
		request.setAttribute("member_id", member_id);
		return "/member/login.jsp";
	}
}