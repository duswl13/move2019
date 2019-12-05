package movie2019.movie.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MovieListController
 */
@WebServlet("*.ml")
public class MovieListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MovieListController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI);

		// getContextPath() : 컨텍스트 경로가 반환됩니다.
		// contextPath는 "/JspProject" 가 반환합니다.
		String contextPath = request.getContextPath();
		System.out.println("contextPath = " + contextPath);

		// RequestURI에서 컨텍스트 경로 길이 값의 인덱스 위치의 문자부터
		// 마지막 위치 문자까지 추출합니다.
		// command는 'login.net'을 반환합니다.

		String command = RequestURI.substring(contextPath.length());
		System.out.println("command = " + command);

		// 초기화
		ActionForward forward = null;
		Action action = null;

		ServletContext sc = this.getServletContext();
		
		if (command.equals("/main.ml")) {

			action = new MainMovieAction();

			try {
				forward = action.execute(request, response,sc);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (command.equals("/MovieList.ml")) {
			action = new MovieListAction(); // parameter 있음

			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (command.equals("/Search.ml")) {
			action = new SearchMovieAction(); // parameter 있음

			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}

			
		} else if (command.equals("/moviedetail.ml")) {
			action = new SelectRatingAction();
			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (command.equals("/PersonDetail.ml")) {
			forward = new ActionForward();// parameter 있음
			forward.setRedirect(false);
			forward.setPath("Page/MovieDetail/PersonDetail.jsp");
		} else if (command.equals("/InsertFaceRating.ml")) {
			action = new InsertFaceRatingAction();// parameter 있음

			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/InsertStarRating.ml")) {
			action = new InsertStarRatingAction();// parameter 있음

			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/UpdateStarRating.ml")) {
			action = new UpdateStarRatingAction();// parameter 있음

			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/UpdateFaceRating.ml")) {
			action = new UpdateFaceRatingAction();// parameter 있음

			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/InsertHidden.ml")) {
			action = new InsertHiddenAction();// parameter 있음

			try {
				forward = action.execute(request, response, null);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (forward != null) {
			if (forward.isRedirect()) {
				System.out.println("sendRedirect 이동 :" + forward.getPath());
				response.sendRedirect(forward.getPath());
			} else { // 포워딩됩니다.
				System.out.println("dispather 이동 :" + forward.getPath());
				RequestDispatcher dispather = request.getRequestDispatcher(forward.getPath());
				dispather.forward(request, response);

			}
		}

	}

}
