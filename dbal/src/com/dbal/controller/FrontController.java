package com.dbal.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.*;

import com.dbal.controller.boardMain.*;
import com.dbal.controller.card.*;
import com.dbal.controller.card.updateDateCheckController;
import com.dbal.controller.card.updateDescriptionController;
import com.dbal.controller.member.*;

@WebServlet("*.do")
public class FrontController extends HttpServlet {

	public static final String redirect = "redirect:";
	public static final String ajax = "ajax:";

	String charset = null;
	HashMap<String, Controller> list = null;

	@Override
	public void init(ServletConfig sc) throws ServletException {

		charset = "UTF-8"; // sc.getInitParameter("charset");

		list = new HashMap<String, Controller>();
		/* 로그인 */
		list.put("/member/login.do", new LoginController());
		list.put("/member/create.do", new MemberCreateController());
		list.put("/member/idcheck.do", new IdDupCheckController());
		list.put("/member/logout.do", new LogoutController());
		

		/* 사용자 */
		list.put("/member/memberList.do", new MemberListController());
		list.put("/ajax/deleteMember.do", new MemberDeleteController());
		list.put("/member/memberInvite.do", new MemberInviteController());

		list.put("/popup/createTeam.do", new TeamCreateController());
		list.put("/main/userHome.do", new UserHomeController());
		list.put("/ajax/userboard.do", new UserHomeBoardController());
		list.put("/ajax/addboard.do", new BoardCreateController());
		
		/* 보드 */
		list.put("/board/boardMain.do", new BoardMainController());
		list.put("/ajax/insertBoardList.do", new BoardInsertController());
		list.put("/ajax/insertCard.do", new CardInsertController());
		list.put("/ajax/deleteCard.do", new CardDeleteController());
		list.put("/ajax/moveCard.do", new CardMoveController());
		list.put("/board/boardDelete.do", new BoardDeleteController());
		
		//카드 - 리스트
		list.put("/ajax/cardInfo.do", new CardInfoController());
		list.put("/ajax/updateCardName.do", new CardNameUpdateController());
		list.put("/ajax/updateCardDate.do", new CardDateUpdateController());

		// 사용자 초대
		list.put("/ajax/memberInvite.do", new MemberInviteController());
		
		// 카드 - 체크 아이템
		list.put("/ajax/insertCheckItem.do", new CheckItemInsertController());
		list.put("/ajax/updateCheckItem.do", new CheckItemUpdateController());
		list.put("/ajax/deleteCheckItem.do", new CheckItemDeleteController());
		
		//카드 - 수정
		list.put("/ajax/updateCardDateCheck.do", new updateDateCheckController());
		list.put("/ajax/updateCardDescription.do", new updateDescriptionController());

	}
	
		

	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding(charset);
		// uri: /dev/memberList.do
		String url = request.getRequestURI();
		String contextPath = request.getContextPath();
		String path = url.substring(contextPath.length());

		Controller subController = list.get(path);
		String view = subController.execute(request, response);
		// 다형성(실행결과가 다 다름)
		// 참조하는 자식객체의 매서드를 호출
		if (view != null) {
			if (view.startsWith(redirect)) {
				response.sendRedirect(view.substring(redirect.length()));
			} else if (view.startsWith(ajax)) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = null;
				try {
					out = response.getWriter();
					out.print(view.substring(ajax.length()));
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				HttpUtil.forward(request, response, view);
			}
		}
	}
}
