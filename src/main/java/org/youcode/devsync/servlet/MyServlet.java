package org.youcode.devsync.servlet;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.youcode.devsync.controller.MainController;

@WebServlet(name = "myServlet", value = {"/"})
public class MyServlet extends HttpServlet {

    MainController mainController;
    public void init() {
        mainController = new MainController();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        if(request.getServletPath().equals("/"))
            mainController.index(request, response);
        if(request.getServletPath().equals("/statistics"))
            mainController.statistics(request, response);
    }
}