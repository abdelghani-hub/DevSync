package org.youcode.devsync.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;


import org.youcode.devsync.model.User;
import org.youcode.devsync.model.UserRole;
import org.youcode.devsync.service.UserService;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private final UserService userService;

    public RegisterServlet() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("auth/register.jsp");
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters from the request
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        UserRole role = UserRole.valueOf(request.getParameter("role"));

        // Create a new User object
        User newUser = new User(username, email, password, firstName, lastName, role);

        Optional<User> registeredUser = userService.createUser(newUser);
        registeredUser.ifPresentOrElse(
            user -> {
                try {
                    response.sendRedirect("tasks/index.jsp");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            },
            () -> {
                try {
                    PrintWriter out = response.getWriter();
                    out.println("<html><body><h1 style=\"color:red;\">Registration failed</h1></body></html>");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        );
    }
}
