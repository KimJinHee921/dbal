package com.dbal.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.dao.BoardDAO;
import com.dbal.dto.BoardDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class BoardCreateController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
//		String board_id =request.getParameter("board_id");
		String board_name = request.getParameter("board_name");
		String team_id = request.getParameter("team_id");

		/*
		 * if(board_id.isEmpty() || board_name.isEmpty()||team_id.isEmpty()) {
		 * request.setAttribute("error", "입력해주세요"); return "/"; }
		 */
		BoardDTO dto = new BoardDTO();
		dto.setBoard_name(board_name);
		dto.setTeam_id(team_id);
		HashMap<String, Object> map = null;
		try {
			 map = BoardDAO.getInstance().insert(dto);
			request.setAttribute("team_id", team_id);

			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return FrontController.ajax + JSONObject.fromObject(map);
	
	}

}