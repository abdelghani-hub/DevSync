package org.youcode.devsync.controller;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.youcode.devsync.model.User;
import org.youcode.devsync.service.UserService;

import java.util.List;

@Path("/users")
public class UserController {

    private final UserService userService;

    public UserController() {
        userService = new UserService();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllUsers() {
        List<User> users = userService.getAllUsers();
        return Response.ok(users).build();
    }
}
