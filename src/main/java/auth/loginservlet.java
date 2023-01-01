package auth;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/loginservlet")
public class loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public loginservlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String uname = req.getParameter("username");
		String pass = req.getParameter("userpass");
		
		userdao ud = new userdao();
		try {
			String[] user = ud.userlogin(uname, pass);
			
			if(user[0]!=null) {
				req.getSession().setAttribute("user", user[0]);
				req.getSession().setAttribute("is_seller", user[1]);
				req.getSession().setAttribute("userid", user[2]);
				res.sendRedirect("index.jsp");
			}
			else {
				System.out.println("loginservlet: no such user");
				req.getSession().setAttribute("message","Invalid user details, check again..");
				res.sendRedirect("login.jsp");
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

}
