package org.youcode.devsync.controller;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.youcode.devsync.model.User;
import org.youcode.devsync.model.UserRole;

@Path("/")
public class ApiController {
    @GET
    @Path("/hello")
    @Produces(MediaType.APPLICATION_JSON)
    public Response get() {
        User user = new User("JohnDoe", "email@example.com", "password", "John", "Doe", UserRole.user);
        return Response.ok(user).build();
    }
}