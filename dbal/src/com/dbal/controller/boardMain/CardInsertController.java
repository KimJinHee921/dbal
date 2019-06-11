package com.dbal.controller.boardMain;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.CardDAO;
import com.dbal.dto.CardDTO;

import net.sf.json.JSONObject;

public class CardInsertController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.setCharacterEncoding("utf-8");

		} catch (Exception e) {
			e.printStackTrace();
		}

		// 카드 이름, 리스트 ID 입력
		CardDTO cardDTO = new CardDTO(request.getParameter("card_name"), request.getParameter("list_id"));

		Map<String, Object> result = CardDAO.getInstance().insertCard(cardDTO);
		return FrontController.ajax + JSONObject.fromObject(result);
	}

}
