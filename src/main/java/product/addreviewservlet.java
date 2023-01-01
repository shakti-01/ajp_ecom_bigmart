package product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.ProductDao;
@WebServlet("/addreviewservlet")
public class addreviewservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public addreviewservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("r-title");
		String rating = request.getParameter("r-rating");
		String content = request.getParameter("r-content");
		String pid = request.getParameter("pid");
		String uid = (String)request.getSession().getAttribute("userid");
		ProductDao pd = new ProductDao();
		
		try {
			pd.addReview(title,rating,content,pid,uid);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
