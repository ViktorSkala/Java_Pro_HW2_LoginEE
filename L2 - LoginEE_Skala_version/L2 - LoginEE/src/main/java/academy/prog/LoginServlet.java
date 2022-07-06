package academy.prog;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    static final String LOGIN = "admin";
    static final String PASS = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    String login = request.getParameter("login");
    String password = request.getParameter("password");
    String age = request.getParameter("age");
    Integer ageInt = 0;
    Boolean ageIsNumber = true;
    Integer passwordLength = password.length();

    if (age == null || "".equals(age)) {
        request.setAttribute("req_user_login", login);
        request.setAttribute("req_user_password", password);
        request.setAttribute("req_user_age", age);
        getServletContext().getRequestDispatcher("/index.jsp").forward(request,response);
    } else {
        try {
            ageInt = Integer.parseInt(age);
        } catch (NumberFormatException e) {
            ageIsNumber = false;
        }
    }

    if (LOGIN.equals(login) && PASS.equals(password) && ageIsNumber) {
        HttpSession session = request.getSession(true);
        session.setAttribute("user_login", login);
        session.setAttribute("user_age",age);
        session.setAttribute("user_password_length", passwordLength);
        response.sendRedirect("index.jsp");
    } else {
        request.setAttribute("req_user_login", login);
        request.setAttribute("req_user_password", password);
        request.setAttribute("req_user_age", age);
        getServletContext().getRequestDispatcher("/index.jsp").forward(request,response);
    }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String a = request.getParameter("a");
        HttpSession session = request.getSession(false);

        if ("exit".equals(a) && (session != null))
            session.removeAttribute("user_login");

        response.sendRedirect("index.jsp");
    }
}
