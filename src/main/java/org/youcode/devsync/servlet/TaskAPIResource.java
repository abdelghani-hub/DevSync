package org.youcode.devsync.servlet;

import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.youcode.devsync.controller.API.TaskAPIController;
import jakarta.inject.Inject;
import org.youcode.devsync.servlet.bodies.TaskFilterRequestBody;

@Path("/")
public class TaskAPIResource {

    @Inject
    private TaskAPIController taskAPIController;

    // Handle POST requests with a JSON body
    @POST
    @Path("/tasks")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTasks(TaskFilterRequestBody requestBody) {
        return taskAPIController.index(requestBody.getTagsIds(), requestBody.getYear(), requestBody.getMonth());
    }
}
