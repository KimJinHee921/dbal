package com.dbal.controller.boardMain;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dbal.controller.Controller;
import com.dbal.controller.FrontController;
import com.dbal.dao.BoardListDAO;
import com.dbal.dto.BoardDTO;
import com.dbal.dto.BoardListDTO;

public class BoardMainController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {

		// 보드 정보
		BoardDTO board = new BoardDTO(request.getParameter("board_id"), request.getParameter("board_name"));

		// 보드 리스트 정보
		BoardListDTO boardListInfo = BoardListDAO.getInstance().selectBoardListInfo(board);		
		
		request.setAttribute("board", board);
		request.setAttribute("boardInfo", boardListInfo);
		
		return "/board/boardMain.jsp";
	}

}
