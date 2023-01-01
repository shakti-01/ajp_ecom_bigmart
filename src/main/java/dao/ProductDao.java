package dao;

//import dao.Product;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
	static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
	static final String USER = "c##shakti";
	static final String PASS = "shakti";
	
	public List<Product> getAllProds() throws ClassNotFoundException, SQLException {
		List<Product> prod_list = new ArrayList<Product>();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "SELECT * FROM ajp_ecom_prod";
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				Product p = new Product();
				p.setPid(rs.getInt(1));
				p.setName(rs.getString(2));
				p.setPrice(rs.getFloat(3));
				p.setSeller(rs.getString(4));
				p.setRating(rs.getFloat(6));
				prod_list.add(p);
			}
			System.out.println("pd-getallprod: Fetched products from db..");
			
			return prod_list;
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			return prod_list;
		}
	}
	
	public List<Product> getFilterProds(String substr) throws ClassNotFoundException, SQLException {
		List<Product> prod_list = new ArrayList<Product>();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "select * from ajp_ecom_prod where pname like '%"+substr+"%'";
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				Product p = new Product();
				p.setPid(rs.getInt(1));
				p.setName(rs.getString(2));
				p.setPrice(rs.getFloat(3));
				p.setSeller(rs.getString(4));
				p.setRating(rs.getFloat(6));
				prod_list.add(p);
			}
			System.out.println("pd-getsearchprod: Fetched search products..");
			
			return prod_list;
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			return prod_list;
		}
	}
	
	public Product getProd(String pid) throws ClassNotFoundException, SQLException {
		Product p = new Product();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "select pid,pname,price,seller,rating from ajp_ecom_prod where pid="+pid;
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				p.setPid(rs.getInt(1));
				p.setName(rs.getString(2));
				p.setPrice(rs.getFloat(3));
				p.setSeller(rs.getString(4));
				p.setRating(rs.getFloat(5));
			}
			System.out.println("pd-getprod: Fetched search product  n reviews..");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return p;
	}
	
	
	public List<Review> getReviews(String pid, String userid) throws ClassNotFoundException, SQLException {
		List<Review> rev_list = new ArrayList<Review>();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "select title,content,rating from ajp_ecom_review where pid="+pid;
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				Review r = new Review();
				r.setTitle(rs.getString(1));
				r.setContent(rs.getString(2));
				r.setRating(rs.getFloat(3));
				rev_list.add(r);
			}
			System.out.println("pd-getrevs: Fetched reviews..");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return rev_list;
	}
	
	
	public void addReview(String title, String rating, String cont, String pid, String uid) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "insert into ajp_ecom_review values("+pid+","+uid+",'"+title+"','"+cont+"',"+rating+")";
			stmt.executeUpdate(sql);
			sql="update ajp_ecom_prod set rating = (SELECT AVG(rating) FROM ajp_ecom_review WHERE pid = "+pid+") where pid="+pid;
			stmt.executeUpdate(sql);
			System.out.println("pd-addrev: addeded...");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	public boolean checkReviewExists(String uid, String pid) throws ClassNotFoundException, SQLException {
		boolean reviewExists=false;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			String sql = "select pid from ajp_ecom_review where userid="+uid+"and pid="+pid;
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				reviewExists = true;
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return reviewExists;
	}
	
	
	public void addProdToCart(String pid, String uname) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "select * from ajp_ecom_cart where pid = "+pid+" and uname='"+uname+"'";
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()) {
				//order exist already so update quantity
				sql = "update ajp_ecom_cart set quantity = quantity+1 where pid = "+pid+" and uname='"+uname+"'";
			}
			else {
				sql = "insert into ajp_ecom_cart(uname,pid,quantity) values('"+uname+"',"+pid+",1)";
			}
			stmt.executeUpdate(sql);
			
			System.out.println("pd: cart prod added to db..");
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public void removeFromCart(String pid, String uname) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "delete from ajp_ecom_cart where pid="+pid+" and uname='"+uname+"'";
			stmt.executeUpdate(sql);
			
			System.out.println("pd-removefromcart: cart item removed from db..");
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public List<Product> getCartProds(String uname) throws ClassNotFoundException, SQLException {
		List<Product> p_list = new ArrayList<Product>();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			//String s = "select * from ajp_ecom_prod p where p.pid in (select pid from ajp_ecom_cart c where c.uname = '"+uname+"')";
			String s = "select pid,pname,price,seller,rating,quantity from ajp_ecom_prod natural join ajp_ecom_cart where uname='"+uname+"'";
			ResultSet rs=stmt.executeQuery(s);
			while(rs.next()){
				Product p = new Product();
				p.setPid(rs.getInt(1));
				p.setName(rs.getString(2));
				p.setPrice(rs.getFloat(3));
				p.setSeller(rs.getString(4));
				p.setRating(rs.getFloat(5));
				p.setQuantity(rs.getInt(6));
				p_list.add(p);
			}
			System.out.println("pd-getcartp: Fetched products which were in cart");
			
			return p_list;
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			return p_list;
		}
	}
	
	public List<Order> getOrderProds(String uname) throws ClassNotFoundException, SQLException {
		List<Order> o_list = new ArrayList<Order>();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			//String s = "select * from ajp_ecom_prod p where p.pid in (select pid from ajp_ecom_cart c where c.uname = '"+uname+"')";
			String s = "select pid,pname,price,seller,rating,quantity,is_confirmed,oid from ajp_ecom_prod natural join ajp_ecom_order where uname='"+uname+"'";
			ResultSet rs=stmt.executeQuery(s);
			while(rs.next()){
				Order o = new Order();
				o.setPid(rs.getInt(1));
				o.setName(rs.getString(2));
				o.setPrice(rs.getFloat(3));
				o.setSeller(rs.getString(4));
				o.setRating(rs.getFloat(5));
				o.setQuantity(rs.getInt(6));
				
				o.setConfirmed(rs.getInt(7));
				o.setOid(rs.getInt(8));
				o_list.add(o);
			}
			System.out.println("pd-getcartp: Fetched products which were in cart");
			
			return o_list;
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			return o_list;
		}
	}
	
	public void orderAll(String uname) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			String s = "select pid, quantity from ajp_ecom_cart where uname = '"+uname+"'";
			ResultSet rs=stmt.executeQuery(s);
			String pid="-1",quan="0";
			while(rs.next()) {
				pid = rs.getString(1);
				quan = rs.getString(2);
				s = "insert into ajp_ecom_order(uname,pid,quantity,is_confirmed) values('"+uname+"',"+pid+","+quan+",0)";
				stmt.executeUpdate(s);
			}
			//remove all prod from cart after buying
			s = "delete from ajp_ecom_cart where uname='"+uname+"'";
			stmt.executeUpdate(s);
			System.out.println("pd-orderall: inserted new orders and emptied cart");
			
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			
		}
	}
	
	public List<Order> getCustOrder(String seller) throws ClassNotFoundException, SQLException {
		List<Order> o_list = new ArrayList<Order>();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			
			String s = "select pname,price,uname,quantity,is_confirmed,oid from ajp_ecom_prod natural join ajp_ecom_order where seller='"+seller+"'";
			ResultSet rs=stmt.executeQuery(s);
			while(rs.next()){
				Order o = new Order();
				
				o.setName(rs.getString(1));
				o.setPrice(rs.getFloat(2));
				o.setOrderedBy(rs.getString(3));
				o.setQuantity(rs.getInt(4));
				o.setConfirmed(rs.getInt(5));
				o.setOid(Integer.valueOf(rs.getString(6)));
				o_list.add(o);
			}
			System.out.println("pd-getCustOrder: Fetched products which were ordered by custs");
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return o_list;
	}
	
	public void orderConfirmStatus(String isConfirmed, String oid) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			System.out.println(oid);
			String sql = "update ajp_ecom_order set is_confirmed = "+isConfirmed+" where oid="+oid;
			
			stmt.executeUpdate(sql);
			
			System.out.println("prod dao-orderConfirmStatus: confirm status changed");
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public List<Product> getSellerProds(String sellerid) throws ClassNotFoundException, SQLException {
		List<Product> p_list = new ArrayList<Product>(); 
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String s = "select pid, pname, price, rating from ajp_ecom_prod where sid="+sellerid;
			ResultSet res=stmt.executeQuery(s);
			while(res.next()){
				Product p = new Product();
				p.setPid( Integer.valueOf(res.getString(1)));
				p.setName(res.getString(2));
				p.setPrice(res.getFloat(3));
				p.setRating(res.getFloat(4));	
				p_list.add(p);
			}
			for(Product p:p_list) {
				s = "SELECT COUNT(*),SUM(quantity) FROM ajp_ecom_order WHERE pid="+p.getPid();
				ResultSet rs = stmt.executeQuery(s);
				if(rs.next()) {
					p.setTimesOrdered(rs.getInt(1)*rs.getInt(2));
				}
			}
			System.out.println("proddao-getsellprod: fetched items");
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return p_list;
	}
	
	public void addNewProd(String pname, String price, String seller, String rating, String userid) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "INSERT INTO ajp_ecom_prod(pname,price,seller,sid,rating) VALUES('"+pname+"',"+price+",'"+seller+"',"+userid+","+rating+")";
			
			stmt.executeUpdate(sql);
			
			System.out.println("prod dao-addnewprod: New prod added to db..");
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public void removeSellerProd(String pid) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "delete from ajp_ecom_prod where pid="+pid;
			stmt.executeUpdate(sql);
			
			System.out.println("prod dao-removeprod: prod del from db db..");
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
