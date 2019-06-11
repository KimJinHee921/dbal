package com.dbal.controller.card;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.CardDAO;

import net.sf.json.JSONObject;

public class CardDeleteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		return FrontController.ajax + JSONObject.fromObject(CardDAO.getInstance().deteCard(request.getParameter("card_id")));
	}

}
