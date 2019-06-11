package com.dbal.controller.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.MemberInviteDAO;
import com.dbal.dto.TeamInfoDTO;

import net.sf.json.JSONObject;

public class MemberInviteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String team_id = request.getParameter("team_id");
		String member_id = request.getParameter("member_id");

		TeamInfoDTO dto = new TeamInfoDTO();
		dto.setTeam_id(team_id);
		dto.setMember_id(member_id);

		Map<String, Object> result = MemberInviteDAO.getInstance().memberInvite(dto);
		return FrontController.ajax + JSONObject.fromObject(result);
	}

}
