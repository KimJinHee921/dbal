package com.dbal.controller.boardMain;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;

public class CheckListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		// 카드 ID를 받아와서 체크리스트 조회
		String card_id = request.getParameter("card_id");
		
		
		
		return null;
	}

}
