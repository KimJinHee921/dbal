package com.dbal.controller.card;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.CardDAO;

import net.sf.json.JSONObject;

public class updateDescriptionController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String card_id = request.getParameter("card_id");
		String description = request.getParameter("description");
		HashMap<String, Object> cardDescription;
		cardDescription = CardDAO.getInstance().updateDescription(card_id, description);
		return FrontController.ajax + JSONObject.fromObject(cardDescription);
	}

}
