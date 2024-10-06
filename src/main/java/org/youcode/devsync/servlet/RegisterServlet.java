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

@WebServlet(name = "RegisterServlet", value = {"/register", "/users", "/login", "/users/delete", "/users/edit/*", "/users/update"})
public class RegisterServlet extends HttpServlet {
    private final UserService userService;

    public RegisterServlet() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Register
        if (request.getServletPath().equals("/register")) {
            RequestDispatcher view = request.getRequestDispatcher("auth/register.jsp");
            view.forward(request, response);
        }
        // Users index
        else if (request.getServletPath().equals("/users")) {
            List<User> users = userService.getAllUsers();
            request.setAttribute("users", users);
            RequestDispatcher view = request.getRequestDispatcher("users/index.jsp");
            view.forward(request, response);
        }
        // Login
        else if (request.getServletPath().equals("/login")) {
            RequestDispatcher view = request.getRequestDispatcher("auth/login.jsp");
            view.forward(request, response);
        }
        // Edit User
        else if (request.getServletPath().contains("/users/edit")) {
            // user ID
            String pathInfo = request.getPathInfo();

            if (pathInfo != null && pathInfo.length() > 1) {
                String idStr = pathInfo.substring(1);

                try {
                    Long userId = Long.parseLong(idStr);

                    Optional<User> user = userService.getUserById(userId);

                    user.ifPresentOrElse(
                            u -> {
                                request.setAttribute("user", u);
                                RequestDispatcher view = request.getRequestDispatcher("/users/updateForm.jsp");
                                try {
                                    view.forward(request, response);
                                } catch (ServletException | IOException e) {
                                    e.printStackTrace();
                                }
                            },
                            () -> {
                                try {
                                    PrintWriter out = response.getWriter();
                                    out.println("<html><body><h1 style=\"color:red;\">User not found</h1></body></html>");
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                    );
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID (" + pathInfo + ")");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID not provided.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        // Register
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
        // Login
        else if (request.getServletPath().equals("/login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            Optional<User> user = userService.getUserByEmail(email);
            if (user.isPresent()) {
                // check password
                if (user.get().getPassword().equals(StringUtil.hashPassword(password))) {
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
        // Update User
        else if (request.getServletPath().equals("/users/update")) {
            Long userId = Long.parseLong(request.getParameter("id"));
            Optional<User> user = userService.getUserById(userId);
            user.ifPresentOrElse(
                    u -> {
                        u.setUsername(request.getParameter("username"));
                        u.setEmail(request.getParameter("email"));
                        u.setPassword(request.getParameter("password"));
                        u.setFirstName(request.getParameter("firstName"));
                        u.setLastName(request.getParameter("lastName"));
                        u.setRole(UserRole.valueOf(request.getParameter("role")));
                        Optional<User> updatedUser = userService.updateUser(u);
                        updatedUser.ifPresentOrElse(
                                user1 -> {
                                    try {
                                        response.sendRedirect(request.getContextPath() + "/users");
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                },
                                () -> {
                                    try {
                                        PrintWriter out = response.getWriter();
                                        out.println("<html><body><h1 style=\"color:red;\">User update failed</h1></body></html>");
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                        );
                    },
                    () -> {
                        try {
                            PrintWriter out = response.getWriter();
                            out.println("<html><body><h1 style=\"color:red;\">User not found</h1></body></html>");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
            );
        }
        // Delete User
        else if (request.getServletPath().equals("/users/delete")) {
            Long userId = Long.parseLong(request.getParameter("id"));
            Optional<User> user = userService.getUserById(userId);
            user.ifPresentOrElse(
                    u -> {
                        if (userService.deleteUser(u) != null) {
                            try {
                                response.sendRedirect(request.getContextPath() + "/users");
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        } else {
                            try {
                                PrintWriter out = response.getWriter();
                                out.println("<html><body><h1 style=\"color:red;\">User deletion failed</h1></body></html>");
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                    },
                    () -> {
                        try {
                            PrintWriter out = response.getWriter();
                            out.println("<html><body><h1 style=\"color:red;\">User not found</h1></body></html>");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
            );
        }
    }
}
