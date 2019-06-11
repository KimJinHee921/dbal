package com.dbal.controller.card;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.CheckListDAO;

import net.sf.json.JSONObject;

public class CheckItemDeleteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		return FrontController.ajax + JSONObject.fromObject(CheckListDAO.getInstance().deleteCheckItem(request.getParameter("item_id")));
		
	}

}
