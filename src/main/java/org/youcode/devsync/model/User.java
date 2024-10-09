package org.youcode.devsync.model;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserRole role;

    @Column(name = "replacement_tokens", nullable = false, columnDefinition = "integer default 2")
    private Integer replacementTokens;

    @Column(name = "deletion_tokens", nullable = false, columnDefinition = "integer default 1")
    private Integer deletionTokens;

    @Column(name = "last_token_refresh_date", nullable = false, columnDefinition = "date default current_date")
    private LocalDate lastTokenRefreshDate;

    public User() {
    }

    public User(String username, String email, String password, UserRole role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public User(String username, String email, String password, String firstName, String lastName, UserRole role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.replacementTokens = 2;
        this.deletionTokens = 1;
        this.lastTokenRefreshDate = LocalDate.now();
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public Integer getReplacementTokens() {
        return replacementTokens;
    }

    public void setReplacementTokens(Integer replacementTokens) {
        this.replacementTokens = replacementTokens;
    }

    public Integer getDeletionTokens() {
        return deletionTokens;
    }

    public void setDeletionTokens(Integer deletionTokens) {
        this.deletionTokens = deletionTokens;
    }

    public LocalDate getLastTokenRefreshDate() {
        return lastTokenRefreshDate;
    }

    public void setLastTokenRefreshDate(LocalDate date) {
        this.lastTokenRefreshDate = date;
    }

    public void refreshTokens() {
        this.replacementTokens = 2;
        this.deletionTokens = 1;
        this.lastTokenRefreshDate = LocalDate.now();
    }

    public void useReplacementToken() {
        this.replacementTokens--;
    }

    public void useDeletionToken() {
        this.deletionTokens--;
    }

    public boolean hasReplacementToken() {
        return this.replacementTokens > 0;
    }

    public boolean hasDeletionToken() {
        return this.deletionTokens > 0;
    }

    @OneToMany(mappedBy = "assignedTo")
    private Set<Task> assignedTasks = new HashSet<>();

    @OneToMany(mappedBy = "createdBy")
    private Set<Task> createdTasks = new HashSet<>();

    public Set<Task> getAssignedTasks() {
        return assignedTasks;
    }

    public Set<Task> getCreatedTasks() {
        return createdTasks;
    }

    public void addAssignedTask(Task task) {
        assignedTasks.add(task);
    }

    public void addCreatedTask(Task task) {
        createdTasks.add(task);
    }

    public void removeAssignedTask(Task task) {
        assignedTasks.remove(task);
    }

    public void removeCreatedTask(Task task) {
        createdTasks.remove(task);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        User user = (User) obj;
        return Objects.equals(id, user.id);
    }
}
