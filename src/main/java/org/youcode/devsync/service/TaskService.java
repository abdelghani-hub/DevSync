package org.youcode.devsync.service;

import org.youcode.devsync.model.Task;
import org.youcode.devsync.model.TaskStatus;
import org.youcode.devsync.model.User;
import org.youcode.devsync.repository.TaskRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public class TaskService {
    private final TaskRepository taskRepository;

    public TaskService() {
        taskRepository = new TaskRepository();
    }

    public List<Task> getAllTasks() {
        return taskRepository.findAll();
    }

    public Optional<Task> getTaskById(Long id) {
        // validate id
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid id");
        }
        return taskRepository.findById(id);
    }

    public Optional<Task> createTask(Task task) {
        // validate task
        if (task == null || task.getTitle() == null || task.getTitle().isEmpty()
            || task.getCreatedBy() == null || task.getAssignedTo() == null
            || task.getStartDate() == null || task.getDeadline() == null
            || task.getTags() == null || task.getTags().isEmpty()
            || task.getStatus() == null) {
            throw new IllegalArgumentException("Invalid task");
        }
        return taskRepository.create(task);
    }

    public Optional<Task> updateTask(Task task) {
        // validate task
        if (task == null || task.getTitle() == null || task.getTitle().isEmpty()
            || task.getCreatedBy() == null || task.getAssignedTo() == null
            || task.getStartDate() == null || task.getDeadline() == null
            || task.getTags() == null || task.getTags().isEmpty()
            || task.getStatus() == null || task.getId() == null || task.getId() <= 0) {
            throw new IllegalArgumentException("Invalid task");
        }
        return taskRepository.update(task);
    }

    public Boolean markTaskAsDone(Task task) {
        // Validate task
        if (task == null || task.getId() == null || task.getId() <= 0) {
            throw new IllegalArgumentException("Invalid task");
        }
        // Rule 4 : A task can only be marked as done before the deadline
        if (!LocalDate.now().isAfter(task.getDeadline())) {
            task.setStatus(TaskStatus.done);
        }
        // fix : return taskRepository.update(task).get().getStatus().equals(TaskStatus.done);
        if(taskRepository.update(task).isPresent()){
            return taskRepository.update(task).get().getStatus().equals(TaskStatus.done);
        }
        return false;
    }

    public List<Task> getUserTasks(User user) {
        return taskRepository.findByAssignedTo(user);
    }

    public Task deleteTask(Task task) {
        // validate task
        if (task == null || task.getId() == null || task.getId() <= 0) {
            throw new IllegalArgumentException("Invalid task");
        }
        return taskRepository.delete(task);
    }

    public String validateTask(Task newTask) {
        if (newTask == null) {
            return "Not a task";
        }

        if(newTask.getCreatedBy() == null || newTask.getAssignedTo() == null){
            return "Task must have a creator and an assignee.";
        }

        // Rule 1 : Make sure a task cannot be created in the past.
        if (newTask.getStartDate().isBefore(LocalDate.now())) {
            return "Task start date cannot be in the past.";
        }
        // Rule 2 : Require users to enter multiple tags for tasks.
        if (newTask.getTags().size() < 2) {
            return "Task must have at least 2 tags.";
        }
        // Rule 3 :Task should Start at least after 3 days
        if (!newTask.getStartDate().isAfter(LocalDate.now().plusDays(3))
            && !newTask.getAssignedTo().equals(newTask.getCreatedBy())) {
            return "Task should start at least after 3 days.";
        }
        // Rule 5 : Task deadline should be after the start date
        if (newTask.getStartDate().isAfter(newTask.getDeadline())) {
            return "Task deadline should be after the start date.";
        }
        return null;
    }
}
