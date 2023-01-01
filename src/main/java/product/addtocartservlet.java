package product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.ProductDao;
@WebServlet("/addtocartservlet")
public class addtocartservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public addtocartservlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pid = request.getParameter("pid");
		String uname = (String)request.getSession().getAttribute("user");
		if(pid==null || pid=="") {response.sendRedirect("index.jsp");return;}
		ProductDao pd = new ProductDao();
		try {
			pd.addProdToCart(pid,uname );
			
			response.sendRedirect("index.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
