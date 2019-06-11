package com.dbal.controller.card;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.CardDAO;

import net.sf.json.JSONObject;

public class CardNameUpdateController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		
		String card_id = request.getParameter("card_id");
		String card_name = request.getParameter("card_name");
		HashMap<String, Object> cardNameList;
		cardNameList = CardDAO.getInstance().updateCardName(card_id, card_name);
		return FrontController.ajax + JSONObject.fromObject(cardNameList);
	}

}
