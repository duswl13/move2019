package movie2019.board.comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class CommentDelete implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CommentDAO dao = new CommentDAO();
		CommentVO co = new CommentVO();
		
		//ajax 한글 깨짐방지
		request.setCharacterEncoding("utf-8");
		co.setNum(Integer.parseInt(request.getParameter("num")));
		
		try{
			int ok = dao.commentsDelete(co.getNum());
			response.getWriter().print(ok);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("댓글 삭제 실패");
			ActionForward forward = new ActionForward();
			 request.setAttribute("message", "댓글 삭제 실패입니다.");
	            forward.setPath("error/error.jsp");
	            forward.setRedirect(false);
	    		return forward;
		}
		
		return null;
	}
}
