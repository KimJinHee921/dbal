package com.dbal.controller.card;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.CheckListDAO;

import net.sf.json.JSONObject;

public class CheckItemUpdateController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {

		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("item_id", request.getParameter("item_id"));
		data.put("checked", request.getParameter("checked").equals("checked") ? "T" : "F");
		
		return FrontController.ajax + JSONObject.fromObject(CheckListDAO.getInstance().updateCheckItem(data));
	}

}
