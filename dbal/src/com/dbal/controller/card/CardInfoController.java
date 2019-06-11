package com.dbal.controller.card;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.dao.CardDAO;
import net.sf.json.JSONArray;

public class CardInfoController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("utf-8");

			String card_id = request.getParameter("card_id");
			HashMap<String, Object> cardInfo = CardDAO.getInstance().selectCardInfo(card_id);

			request.setAttribute("cardInfo", cardInfo);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "../popup/cardDetail.jsp";
	}

}
