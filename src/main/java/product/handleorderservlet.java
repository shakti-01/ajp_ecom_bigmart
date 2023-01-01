package product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.ProductDao;
@WebServlet("/handleorderservlet")
public class handleorderservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public handleorderservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isConfirmed = request.getParameter("confirmation");
		String oid = request.getParameter("oid");
		System.out.println("000");
		ProductDao pd = new ProductDao();
		try {
			pd.orderConfirmStatus(isConfirmed,oid);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("seller_order.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
