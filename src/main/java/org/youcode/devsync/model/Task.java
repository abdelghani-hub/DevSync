package org.youcode.devsync.model;

import jakarta.enterprise.inject.Default;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "tasks")
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "status", nullable = false)
    @Enumerated(EnumType.STRING)
    private TaskStatus status;

    @Column(name = "deadline")
    private LocalDate deadline;

    @Column(name = "is_token_modifiable", nullable = false)
    private Boolean isTokenModifiable;

    // Assigned to (User)
    @ManyToOne
    @JoinColumn(name = "assigned_to")
    private User assignedTo;

    // Created by (User)
    @ManyToOne
    @JoinColumn(name = "created_by")
    private User createdBy;


    @Column(name = "created_at", nullable = false)
    private LocalDate createdAt;

    public Task() {
    }

    public Task(String title, String description, TaskStatus status, LocalDate deadline, Boolean isTokenModifiable, User assignedTo, User createdBy) {
        this.title = title;
        this.description = description;
        this.status = status;
        this.deadline = deadline;
        this.isTokenModifiable = isTokenModifiable;
        this.assignedTo = assignedTo;
        this.createdBy = createdBy;
        this.createdAt = LocalDate.now();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public TaskStatus getStatus() {
        return status;
    }

    public void setStatus(TaskStatus status) {
        this.status = status;
    }

    public LocalDate getDeadline() {
        return deadline;
    }

    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }

    public Boolean getTokenModifiable() {
        return isTokenModifiable;
    }

    public void setTokenModifiable(Boolean tokenModifiable) {
        isTokenModifiable = tokenModifiable;
    }

    public User getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(User assignedTo) {
        this.assignedTo = assignedTo;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    // tags
    @ManyToMany(
            cascade = {
                    CascadeType.PERSIST,
                    CascadeType.MERGE
            }
    )
    @JoinTable(
            name = "task_tags",
            joinColumns = @JoinColumn(name = "task_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id"),
            uniqueConstraints = {
                    @UniqueConstraint(
                            columnNames = {"task_id", "tag_id"}
                    )
            }
    )
    private Set<Tag> tags = new HashSet<>();

    public List<Tag> getTags() {
        return new ArrayList<>(tags);
    }

    public void addTag(Tag tag) {
        if (tags.add(tag))
            tag.getTasks().add(this);
    }

    public void removeTag(Tag tag) {
        if (tags.remove(tag))
            tag.getTasks().remove(this);
    }
}
