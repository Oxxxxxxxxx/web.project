package com.yedam.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedam.common.Control;
import com.yedam.service.BoardService;
import com.yedam.service.BoradServiceImpl;
import com.yedam.vo.BoardVO;

public class RemoveControl implements Control {

	@Override
	public void exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// bno(글삭제용도), page(page로 이동)
		String bno = request.getParameter("bno");
		String page = request.getParameter("page");
		
		// 검색조건.
		String sc = request.getParameter("searchCondition");
		String kw = request.getParameter("keyword");
		
		//로그인 정보
		HttpSession session = request.getSession();
		String logid = (String) session.getAttribute("logid");
		
		BoardService svc = new BoradServiceImpl();
		BoardVO board = svc.getboard(Integer.parseInt(bno));
		
		// 로그인정보가 없거나 로그인 정보와 작성자가 다르면 > 삭제불가
		if(logid == null || !logid.equals(board.getWriter())) {
			request.setAttribute("message", "삭제권한이 없습니다.");
			request.setAttribute("board", board);
			request.setAttribute("page", page);
			
			request.getRequestDispatcher("board/board.tiles").forward(request, response);
			return;
		}
		
		// 게시글 삭제
		if(svc.removeboard(Integer.parseInt(bno))){
			response.sendRedirect("boardList.do?page=" + page + "&searchCondition=" + sc + "&keyword=" + kw);
		}
		
	}

}
