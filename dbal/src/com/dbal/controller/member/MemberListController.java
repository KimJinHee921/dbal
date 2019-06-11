package com.dbal.controller.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.dao.MemberListDAO;
import com.dbal.dto.MemberDTO;

public class MemberListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// 파라메터로 조회할 팀 ID 받아오기
		String team_id = request.getParameter("team_id");
		
		// 사용자 목록 조회
		//ArrayList<MemberDTO> memberList = MemberListDAO.getInstance().selectAll(team_id);
		List<HashMap<String, Object>> memberList;
		try {
			memberList = MemberListDAO.getInstance().selectTeamMember(team_id);
			request.setAttribute("memberList", memberList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 결과 페이지 리턴
		
		
		return "../popup/memberList.jsp";
	}

}
