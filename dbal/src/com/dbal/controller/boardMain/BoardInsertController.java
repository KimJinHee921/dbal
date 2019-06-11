package com.dbal.controller.boardMain;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.BoardListDAO;
import net.sf.json.JSONObject;

public class BoardInsertController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {

		response.setContentType("text/html; charset=UTF-8");

		HashMap<String, String> boardList = new HashMap<String, String>();
		boardList.put("board_id", request.getParameter("board_id"));
		boardList.put("list_name", request.getParameter("list_name"));

		return FrontController.ajax + JSONObject.fromObject(BoardListDAO.getInstance().insertList(boardList));

	}

}
