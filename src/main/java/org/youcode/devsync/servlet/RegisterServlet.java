package org.youcode.devsync.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

import org.youcode.devsync.model.User;
import org.youcode.devsync.model.UserRole;
import org.youcode.devsync.service.UserService;
import org.youcode.devsync.util.StringUtil;

@WebServlet(name = "RegisterServlet", value = {"/register", "/users", "/login"})
public class RegisterServlet extends HttpServlet {
    private final UserService userService;

    public RegisterServlet() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getServletPath().equals("/register")) {
            RequestDispatcher view = request.getRequestDispatcher("auth/register.jsp");
            view.forward(request, response);
        }
        else if (request.getServletPath().equals("/users")) {
            List<User> users = userService.getAllUsers();
            request.setAttribute("users", users);
            RequestDispatcher view = request.getRequestDispatcher("users/index.jsp");
            view.forward(request, response);
        } else if (request.getServletPath().equals("/login")) {
            RequestDispatcher view = request.getRequestDispatcher("auth/login.jsp");
            view.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters from the request
        if (request.getServletPath().equals("/register")) {
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
                            if (user.getRole() == UserRole.manager) {
                                response.sendRedirect(request.getContextPath() + "/users");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/tasks");
                            }
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
        else if (request.getServletPath().equals("/login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            Optional<User> user = userService.getUserByEmail(email);
            if(user.isPresent()) {
                // check password
                if(user.get().getPassword().equals(StringUtil.hashPassword(password))) {
                    if (user.get().getRole() == UserRole.manager) {
                        response.sendRedirect(request.getContextPath() + "/users");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/tasks");
                    }
                } else {
                    // redirect to login page
                    response.sendRedirect(request.getContextPath() + "/login");
                }
            } else {
                // redirect to login page
                response.sendRedirect(request.getContextPath() + "/login?error=invalid-credentials");
            }
        }
    }
}
