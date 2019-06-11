package com.dbal.controller.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.MemberListDAO;

import net.sf.json.JSONObject;

public class MemberDeleteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		return FrontController.ajax + JSONObject.fromObject(MemberListDAO.getInstance().deleteMember(request.getParameter("member_id"), request.getParameter("team_id")));
	}

}
