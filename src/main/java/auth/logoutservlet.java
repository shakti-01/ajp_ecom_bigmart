package auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/logoutservlet")
public class logoutservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	public logoutservlet() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			if(request.getSession().getAttribute("user")!=null) {
				request.getSession().removeAttribute("user");
				System.out.println("Logged out..");
				response.sendRedirect("login.jsp");
			}else {
				response.sendRedirect("index.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
