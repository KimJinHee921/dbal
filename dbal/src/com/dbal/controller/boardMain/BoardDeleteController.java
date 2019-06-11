package com.dbal.controller.boardMain;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.BoardDAO;

public class BoardDeleteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
			BoardDAO.getInstance().delete(request.getParameter("board_id"));
			return  FrontController.redirect + "../main/userHome.do";
	}
	
}
