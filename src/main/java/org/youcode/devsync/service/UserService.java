package org.youcode.devsync.service;

import org.youcode.devsync.model.User;
import org.youcode.devsync.repository.UserRepository;

import java.util.List;
import java.util.Optional;

public class UserService {
    private UserRepository userRepository;

    public UserService() {
        userRepository = new UserRepository();
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> getUserById(Long id) {
        // validate id
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid id");
        }

        return userRepository.findById(id);
    }

    public Optional<User> createUser(User user) {
        // validate user
        if (user == null || user.getUsername() == null || user.getUsername().isEmpty()
                || user.getEmail() == null || user.getEmail().isEmpty()
                || user.getPassword() == null || user.getPassword().isEmpty()) {
            throw new IllegalArgumentException("Invalid user");
        }

        return userRepository.create(user);
    }

    public Optional<User> updateUser(User user) {
        // validate user
        if (user == null || user.getUsername() == null || user.getUsername().isEmpty()
                || user.getEmail() == null || user.getEmail().isEmpty()
                || user.getPassword() == null || user.getPassword().isEmpty()
                || user.getId() == null || user.getId() <= 0) {
            throw new IllegalArgumentException("Invalid user");
        }
        return userRepository.update(user);
    }

    public Optional<User> getUserByEmail(String email) {
        // validate email
        if (email == null || !email.contains("@")) {
            throw new IllegalArgumentException("Invalid email");
        }
        return userRepository.findByEmail(email);
    }

    public User deleteUser(User u) {
        // validate user
        if (u == null || u.getId() == null || u.getId() <= 0) {
            throw new IllegalArgumentException("Invalid user");
        }

        return userRepository.delete(u);
    }
}
