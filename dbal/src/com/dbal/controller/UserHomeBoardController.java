package com.dbal.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.dao.BoardDAO;
import com.dbal.dao.MemberListDAO;
import com.dbal.dto.BoardDTO;
import com.dbal.dto.MemberDTO;
import com.sun.javafx.collections.MappingChange.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class UserHomeBoardController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String team_id = request.getParameter("team_id");
		//BoardDTO dto;
		ArrayList<BoardDTO> Boardlist;
		Boardlist = BoardDAO.getInstance().select(team_id);
		
		System.out.println(Boardlist);
		return FrontController.ajax + JSONArray.fromObject(Boardlist);
	}

}
