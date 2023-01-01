package product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.ProductDao;

@WebServlet("/addnewprodservlet")
public class addnewprodservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public addnewprodservlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pname = request.getParameter("pname");
		String price = request.getParameter("price");
		String seller = request.getParameter("seller");
		String rating = request.getParameter("rating");
		String userid = (String)request.getSession().getAttribute("userid");
		
		ProductDao pd = new ProductDao();
		try {
			pd.addNewProd(pname,price,seller,rating,userid);
			response.sendRedirect("seller_home.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
}
