package mail;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sendmailservlet")
public class sendmailservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public sendmailservlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Get form data
	    String from = request.getParameter("mail");
	    String to = "pnandashakti@gmail.com";
	    String subject = request.getParameter("sub");
	    String message = request.getParameter("body");
	    // Set up mail server properties
	    Properties props = new Properties();
	    props.put("mail.smtp.host", "smtp-relay.sendinblue.com");
	    props.put("mail.smtp.ssl.trust", "smtp-relay.sendinblue.com");
	    props.put("mail.smtp.port", "587");
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    props.put("mail.smtp.starttls.enable", "true");

	    // Set up authentication
	    Session session = Session.getInstance(props,
	        new javax.mail.Authenticator() {
	          protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication("shaktip2014@gmail.com", "kHRyZDOWEMYvT7x9");
	          }
	        });
	    
	    response.setContentType("text/plain");
	    PrintWriter out = response.getWriter();
	    
	    try {
	      // Create a message
	      Message msg = new MimeMessage(session);
	      msg.setFrom(new InternetAddress(from));
	      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
	      msg.setSubject(subject);
	      msg.setText(message);

	      // Send the message
	      Transport.send(msg);

	      out.println("Mail sent");
	    } catch (MessagingException e) {
	    	out.println("Error sending mail: "+e.getMessage());
	    }
	}
}
