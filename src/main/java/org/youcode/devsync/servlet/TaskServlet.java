package org.youcode.devsync.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.youcode.devsync.controller.MainController;
import org.youcode.devsync.controller.TaskController;

@WebServlet(name = "TaskServlet", value = {"/tasks"})
public class TaskServlet extends HttpServlet {
    private final TaskController taskController;
    private final MainController mainController;

    public TaskServlet() {
        taskController = new TaskController();
        mainController = new MainController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");
        System.out.println("\n\nAction : " + action);
        response.setContentType("text/html");
        // Index
        if (action == null) {
            taskController.index(request, response);
        }
        // create
        else if (action.equals("create")) {
            taskController.create(request, response);
        }
        // Edit
        else if (action.equals("edit")) {
            taskController.edit(request, response);
        }
        else{
            mainController.notFound(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");
        System.out.println("\n\nAction : " + action);

        // Register
        switch (action) {
            case "save":
                taskController.save(request, response);
                break;
            // Update Task
            case "update":
                taskController.update(request, response);
                break;
            // Delete Task
            case "delete":
                taskController.delete(request, response);
                break;
            // Mark as done
            case "done":
                taskController.markAsDone(request, response);
                break;
            // Mark as pending
            case "pending":
                taskController.markAsPending(request, response);
                break;
            default:
                taskController.index(request, response);
                break;
        }
    }
}
