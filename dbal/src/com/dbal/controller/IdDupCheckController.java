package com.dbal.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.dao.MemberDAO;
import com.dbal.dto.MemberDTO;

public class IdDupCheckController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		MemberDTO dto = new MemberDTO();
		dto.setMember_id(request.getParameter("member_id"));
		MemberDTO result = MemberDAO.getInstance().selectOne(dto);
		
		if(result.getMember_id() == null) {
			return FrontController.ajax + "available";
		} else {
			return FrontController.ajax + "unavailable";
		}
	}
}
