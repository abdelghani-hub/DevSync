package org.youcode.devsync.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.youcode.devsync.model.Tag;
import org.youcode.devsync.service.TagService;

import java.util.List;
import java.util.Optional;

public class TagController {
    private final TagService tagService;

    public TagController() {
        tagService = new TagService();
    }

    public void index(HttpServletRequest request, HttpServletResponse response) {
        List<Tag> tags = tagService.getAllTags();
        request.setAttribute("tags", tags);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("tags/index.jsp");
        try{
            requestDispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void create(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("tags/create.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void save(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        Tag tag = new Tag(name);
        tagService.createTag(tag);
        try {
            response.sendRedirect("tags");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void edit(HttpServletRequest request, HttpServletResponse response) {
        Long id = Long.parseLong(request.getParameter("id"));
        Optional<Tag> tag = tagService.getTagById(id);
        tag.ifPresent(value -> {
            request.setAttribute("tag", value);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("tags/edit.jsp");
            try {
                requestDispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    public void update(HttpServletRequest request, HttpServletResponse response) {
        Long id = Long.parseLong(request.getParameter("id"));
        Optional<Tag> tag = tagService.getTagById(id);
        tag.ifPresent(value -> {
            value.setName(request.getParameter("name"));
            tagService.updateTag(value);
            try {
                response.sendRedirect("tags");
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) {
        Long id = Long.parseLong(request.getParameter("id"));
        Optional<Tag> tag = tagService.getTagById(id);
        tag.ifPresent(value -> {
            tagService.deleteTag(value);
            try {
                response.sendRedirect("tags");
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }
}
