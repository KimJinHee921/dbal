package com.dbal.controller.card;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.CheckListDAO;

import net.sf.json.JSONObject;

public class CheckItemInsertController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("item_name", request.getParameter("item_name"));
		data.put("check_id", request.getParameter("check_id"));
		data.put("card_id", request.getParameter("card_id"));
		
		return FrontController.ajax + JSONObject.fromObject(CheckListDAO.getInstance().insertCheckItem(data));
	}

}
