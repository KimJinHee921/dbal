package com.dbal.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.dao.TeamDAO;
import com.dbal.dao.TeamInfoDAO;
import com.dbal.dto.TeamDTO;
import com.dbal.dto.TeamInfoDTO;

import net.sf.json.JSONArray;

public class TeamCreateController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		//String team_id = request.getParameter("team_id");
		String member_id = (String) (request.getSession().getAttribute("member_id"));
		String team_name = request.getParameter("team_name");
		
		/*if(team_name.isEmpty()) {
			request.setAttribute("error", "팀이름을 입력해 주세요");
		return "/main/userHome.jsp";
		}*/
		
		TeamDTO dto = new TeamDTO();
		
		dto.setTeam_name(team_name);
		
		//int team_id = TeamDAO.getInstance().insert(dto);
		
		TeamDAO.getInstance().insert(dto);
		String team_id = dto.getTeam_id();
		System.out.println(team_id);
		
		int result = 0;
		result = TeamInfoDAO.getInstance().insert(team_id, member_id);
		if (result != 0)
			System.out.println("입력성공");
		
		request.setAttribute("team_name", team_name);
		String homeTeam = "<script>"
				+ "opener.location.reload();"
				+ "window.close();"
				+ "</script>";
		return FrontController.ajax + (homeTeam);
		
	}

}
