package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.bo.*;

public class CheckLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
		
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CheckLoginBO checkloginBO = new CheckLoginBO();
		UserBO userBO = new UserBO();
		String username = request.getParameter("username");
		System.out.println(username);
		String password = request.getParameter("password");
		System.out.println(password);
		if(checkloginBO.CheckUserExist(username, password)) {
			if(username.equals("admin"))
				response.sendRedirect("Admin/index.jsp");
			else {
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("userid", userBO.getIdByUsername(username));
				response.sendRedirect("User/index2.jsp");
			}
		} else {
			response.sendRedirect("login.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
