package auth;

import dao.*;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signupservlet")
public class signupservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public signupservlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse responce) throws ServletException, IOException {
		try{
			String uname = request.getParameter("username");
			String pass = request.getParameter("userpass");
			String seller = request.getParameter("is_seller");
			
			if(seller == null) seller="0";
			
			userdao ud = new userdao();
			if(ud.usersignup(uname, pass, seller)) {
				System.out.println("signupservlet: Created ac");
				request.getSession().setAttribute("message","Please login to your new account");				
			}
			else {
				System.out.println("signupservlet: ac not created");
				request.getSession().setAttribute("message","Account not created. Try a different username.");
			}
			responce.sendRedirect("login.jsp");
			 
			} catch (Exception e) {
				e.printStackTrace();
			}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
