package org.youcode.devsync.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.youcode.devsync.model.User;
import org.youcode.devsync.model.UserRole;
import org.youcode.devsync.service.UserService;
import org.youcode.devsync.util.StringUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

public class UserController {

    private final UserService userService;

    public UserController() {
        userService = new UserService();
    }

    public void index(HttpServletRequest request, HttpServletResponse response) {
        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("users/index.jsp");
        try{
            requestDispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void create(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("auth/register.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save(HttpServletRequest request, HttpServletResponse response) {
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
                        out.println("<html><body><h1 style=\"color:red;\">Registration failed</h1><");
                        out.println("<h2> registered user : " + registeredUser + "</h2></body></html>");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
        );
    }

    public void edit(HttpServletRequest request, HttpServletResponse response) {
        Long id = Long.parseLong(request.getParameter("id"));
        Optional<User> user = userService.getUserById(id);
        user.ifPresent(value -> {
            request.setAttribute("user", value);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("users/edit.jsp");
            try {
                requestDispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    public void update(HttpServletRequest request, HttpServletResponse response) {
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

    public void delete(HttpServletRequest request, HttpServletResponse response) {
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

    public void login(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Optional<User> user = userService.getUserByEmail(email);
        user.ifPresentOrElse(
                u -> {
                    if (u.getPassword().equals(StringUtil.hashPassword(password))) {
                        try {
                            if (u.getRole() == UserRole.manager) {
                                response.sendRedirect(request.getContextPath() + "/users");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/tasks");
                            }
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    } else {
                        try {
                            response.sendRedirect(request.getContextPath() + "/login?error=invalid-credentials");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                },
                () -> {
                    try {
                        response.sendRedirect(request.getContextPath() + "/login?error=invalid-credentials");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
        );
    }

    public void loginForm(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher view = request.getRequestDispatcher("auth/login.jsp");
        try {
            view.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
