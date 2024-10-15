package org.youcode.devsync.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.youcode.devsync.model.Tag;
import org.youcode.devsync.model.User;
import org.youcode.devsync.model.UserRole;
import org.youcode.devsync.service.TagService;

import java.util.List;

public class MainController {
    private TagService tagService;

    public MainController() {
        tagService = new TagService();
    }

    public void index(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // not found
    public void notFound(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("notFound.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void statistics(HttpServletRequest request, HttpServletResponse response) {
        // Check if the user is logged in and is a manager
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("login.jsp");
            try {
                requestDispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        } else if (!user.getRole().equals(UserRole.manager)){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/");
            try {
                requestDispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return;
        }
        List<Tag> tags = tagService.getAllTags();
        request.setAttribute("tags", tags);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("statistics.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
