package org.youcode.devsync.servlet;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "myServlet", value = {"/", "/tasks"})
public class MyServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (request.getServletPath().equals("/")) {
            RequestDispatcher view = request.getRequestDispatcher("index.jsp");
            try {
                view.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (request.getServletPath().equals("/tasks")) {
            // TODO: Implement the logic to get all tasks from the database
            RequestDispatcher view = request.getRequestDispatcher("tasks/index.jsp");
            try {
                view.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void destroy() {

    }
}