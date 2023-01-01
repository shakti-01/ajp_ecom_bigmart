package product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.ProductDao;

@WebServlet("/removefromcartservlet")
public class removefromcartservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public removefromcartservlet() {
        super();
    }
	protected void doGet(HttpServletRequest request,  HttpServletResponse responce) throws ServletException, IOException {
		String pid = request.getParameter("pid");
		String uname = (String)request.getSession().getAttribute("user");
		if(pid==null || pid=="") {responce.sendRedirect("cart.jsp");return;}
		ProductDao pd = new ProductDao();
		try {
			pd.removeFromCart(pid,uname );
			
			responce.sendRedirect("cart.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
