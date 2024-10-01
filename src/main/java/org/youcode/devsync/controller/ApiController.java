package org.youcode.devsync.controller;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.youcode.devsync.model.User;

@Path("/")
public class ApiController {
    @GET
    @Path("/hello")
    @Produces(MediaType.APPLICATION_JSON)
    public Response get() {
        User user = new User("John Doe", "email@example.com", "password");
        return Response.ok(user).build();
    }
}
