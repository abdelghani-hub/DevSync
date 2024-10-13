package org.youcode.devsync.service;

import org.youcode.devsync.model.Request;
import org.youcode.devsync.model.RequestStatus;
import org.youcode.devsync.repository.RequestRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class RequestService {
    private final RequestRepository requestRepository;

    public RequestService() {
        requestRepository = new RequestRepository();
    }

    public List<Request> getAllRequests() {
        return requestRepository.findAll();
    }

    public Optional<Request> getRequestById(Long id) {
        return requestRepository.findById(id);
    }

    public Optional<Request> createRequest(Request request) {
        if (request == null || request.getRequester() == null || request.getTask() == null || request.getType() == null) {
            throw new IllegalArgumentException("Request, requester, task and type must be provided");
        }
        return requestRepository.create(request);
    }

    public Optional<Request> updateRequest(Request request) {
        if (request == null || request.getId() == null) {
            throw new IllegalArgumentException("Request and id must be provided");
        }
        return requestRepository.update(request);
    }

    public Request deleteRequest(Request u) {
        return requestRepository.delete(u);
    }

    public String validateRequest(Request newRequest) {

        // Requester must be a user
        if (newRequest.getRequester() == null || newRequest.getRequester().getId() == null)
            return "Requester must be a user";

        // Task must be a task
        if (newRequest.getTask() == null || newRequest.getTask().getId() == null)
            return "Task must be a task";

        // Request can't be requested after deadline
        if (newRequest.getTask().getDeadline() != null && newRequest.getRequestedAt().toLocalDate().isAfter(newRequest.getTask().getDeadline()))
            return "Cannot request after deadline";

        // Request can't be requested by the task creator
        if (newRequest.getTask().getCreatedBy().equals(newRequest.getRequester()))
            return "Cannot request by the task creator";

        // Check Requester tokens
        if (!newRequest.getRequester().canRequest(newRequest.getType()))
            return "You don't have enough tokens";

        return null;
    }

    public Optional<Request> respondToRequest(Request request, RequestStatus status) {
        request.setStatus(status);
        request.setRespondedAt(LocalDateTime.now());
        return this.updateRequest(request);
    }
}
