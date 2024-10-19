package org.youcode.devsync.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.youcode.devsync.model.User;
import org.youcode.devsync.model.UserRole;
import org.youcode.devsync.repository.UserRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UserServiceTest {

    @Mock
    private UserRepository userRepository;
    private UserService userService;

    @BeforeEach
    public void setup() {
        userService = new UserService();
        // Use reflection to set the mocked repository
        java.lang.reflect.Field field;
        try {
            field = UserService.class.getDeclaredField("userRepository");
            field.setAccessible(true);
            field.set(userService, userRepository);
        } catch (NoSuchFieldException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testCreateUser_ValidUser() {
        User user = new User("testuser", "test@example.com", "password123", UserRole.user);
        when(userRepository.findByEmail(user.getEmail())).thenReturn(Optional.empty());
        when(userRepository.findByUsername(user.getUsername())).thenReturn(Optional.empty());
        when(userRepository.create(user)).thenReturn(Optional.of(user));

        Optional<User> result = userService.createUser(user);

        assertTrue(result.isPresent());
        assertEquals(user, result.get());
        verify(userRepository, times(1)).create(user);
    }

    @Test
    public void testCreateUser_NullUser() {
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(null));
    }

    @Test
    public void testCreateUser_EmptyUsername() {
        User user = new User("", "test@example.com", "password123", UserRole.user);
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(user));
    }

    @Test
    public void testCreateUser_NullEmail() {
        User user = new User("testuser", null, "password123", UserRole.user);
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(user));
    }

    @Test
    public void testCreateUser_EmptyPassword() {
        User user = new User("testuser", "test@example.com", "",UserRole.user);
        assertThrows(IllegalArgumentException.class, () -> userService.createUser(user));
    }

    @Test
    public void testCreateUser_ExistingEmail() {
        User user = new User("testuser", "existing@example.com", "password123", UserRole.user);
        when(userRepository.findByEmail(user.getEmail())).thenReturn(Optional.of(new User()));

        assertThrows(IllegalArgumentException.class, () -> userService.createUser(user));
        verify(userRepository, never()).create(any(User.class));
    }

    @Test
    public void testCreateUser_ExistingUsername() {
        User user = new User("existinguser", "test@example.com", "password123", UserRole.user);
        when(userRepository.findByEmail(user.getEmail())).thenReturn(Optional.empty());
        when(userRepository.findByUsername(user.getUsername())).thenReturn(Optional.of(new User()));

        assertThrows(IllegalArgumentException.class, () -> userService.createUser(user));
        verify(userRepository, never()).create(any(User.class));
    }

    @Test
    public void testUpdateUser_ValidUser() {
        User user = new User(1L, "updateduser", "updated@example.com", "newpassword123");
        when(userRepository.update(user)).thenReturn(Optional.of(user));

        Optional<User> result = userService.updateUser(user);

        assertTrue(result.isPresent());
        assertEquals(user, result.get());
        verify(userRepository, times(1)).update(user);
    }

    @Test
    public void testUpdateUser_NullUser() {
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(null));
    }

    @Test
    public void testUpdateUser_EmptyUsername() {
        User user = new User(1L, "", "test@example.com", "password123");
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(user));
    }

    @Test
    public void testUpdateUser_NullEmail() {
        User user = new User(1L, "testuser", null, "password123");
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(user));
    }

    @Test
    public void testUpdateUser_EmptyPassword() {
        User user = new User(1L, "testuser", "test@example.com", "");
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(user));
    }

    @Test
    public void testUpdateUser_InvalidId() {
        User user = new User("testuser", "test@example.com", "password123", UserRole.user);
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(user));
    }

    @Test
    public void testUpdateUser_NullId() {
        User user = new User("testuser", "test@example.com", "password123", UserRole.user);
        assertThrows(IllegalArgumentException.class, () -> userService.updateUser(user));
    }

    @Test
    public void testGetAllUsers() {
        List<User> users = Arrays.asList(
                new User(1L, "user1", "user1@example.com", "password1"),
                new User(2L, "user2", "user2@example.com", "password2")
        );
        when(userRepository.findAll()).thenReturn(users);

        List<User> result = userService.getAllUsers();

        assertEquals(2, result.size());
        assertEquals(users, result);
        verify(userRepository, times(1)).findAll();
    }

    @Test
    public void testGetUserById_ValidId() {
        Long id = 1L;
        User user = new User(id, "testuser", "test@example.com", "password123");
        when(userRepository.findById(id)).thenReturn(Optional.of(user));

        Optional<User> result = userService.getUserById(id);

        assertTrue(result.isPresent());
        assertEquals(user, result.get());
        verify(userRepository, times(1)).findById(id);
    }

    @Test
    public void testGetUserById_InvalidId() {
        assertThrows(IllegalArgumentException.class, () -> userService.getUserById(-1L));
        assertThrows(IllegalArgumentException.class, () -> userService.getUserById(0L));
        assertThrows(IllegalArgumentException.class, () -> userService.getUserById(null));

        verify(userRepository, never()).findById(any());
    }

    @Test
    public void testGetUserById_NonExistentId() {
        Long id = 999L;
        when(userRepository.findById(id)).thenReturn(Optional.empty());

        Optional<User> result = userService.getUserById(id);

        assertFalse(result.isPresent());
        verify(userRepository, times(1)).findById(id);
    }

    @Test
    public void testGetUserByEmail_ValidEmail() {
        String email = "test@example.com";
        User user = new User(1L, "testuser", email, "password123");
        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));

        Optional<User> result = userService.getUserByEmail(email);

        assertTrue(result.isPresent());
        assertEquals(user, result.get());
        verify(userRepository, times(1)).findByEmail(email);
    }

    @Test
    public void testGetUserByEmail_InvalidEmail() {
        assertThrows(IllegalArgumentException.class, () -> userService.getUserByEmail(null));
        assertThrows(IllegalArgumentException.class, () -> userService.getUserByEmail("invalidemail"));

        verify(userRepository, never()).findByEmail(any());
    }

    @Test
    public void testGetUserByEmail_NonExistentEmail() {
        String email = "nonexistent@example.com";
        when(userRepository.findByEmail(email)).thenReturn(Optional.empty());

        Optional<User> result = userService.getUserByEmail(email);

        assertFalse(result.isPresent());
        verify(userRepository, times(1)).findByEmail(email);
    }

    @Test
    public void testDeleteUser_ValidUser() {
        User user = new User(1L, "testuser", "test@example.com", "password123");
        when(userRepository.delete(user)).thenReturn(user);

        User result = userService.deleteUser(user);

        assertNotNull(result);
        assertEquals(user, result);
        verify(userRepository, times(1)).delete(user);
    }

    @Test
    public void testDeleteUser_NullUser() {
        assertThrows(IllegalArgumentException.class, () -> userService.deleteUser(null));
        verify(userRepository, never()).delete(any());
    }

    @Test
    public void testDeleteUser_InvalidId() {
        User userWithInvalidId = new User(0L, "testuser", "test@example.com", "password123");
        assertThrows(IllegalArgumentException.class, () -> userService.deleteUser(userWithInvalidId));

        User userWithNullId = new User(null, "testuser", "test@example.com", "password123");
        assertThrows(IllegalArgumentException.class, () -> userService.deleteUser(userWithNullId));

        verify(userRepository, never()).delete(any());
    }
}