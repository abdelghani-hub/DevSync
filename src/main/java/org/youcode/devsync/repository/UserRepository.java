package org.youcode.devsync.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.youcode.devsync.interfaces.RepositoryInterface;
import org.youcode.devsync.model.User;

import java.util.List;
import java.util.Optional;

public class UserRepository implements RepositoryInterface<User> {

    private final EntityManagerFactory entityManagerFactory;
    private final EntityManager entityManager;

    public UserRepository() {
        entityManagerFactory = Persistence.createEntityManagerFactory("devsync");
        entityManager = entityManagerFactory.createEntityManager();
    }

    @Override
    public Optional<User> findById(Long id) {
        return Optional.empty();
    }

    @Override
    public List<User> findAll() {
        return entityManager.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public Optional<User> create(User user) {
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(user);
            entityManager.getTransaction().commit();
            return Optional.of(user);
        } catch (Exception e) {
            entityManager.getTransaction().rollback();
            e.printStackTrace();
            return Optional.empty();
        }
    }

    @Override
    public Optional<User> update(User user) {
        return Optional.empty();
    }

    @Override
    public Optional<User> delete(User user) {
        return Optional.empty();
    }

    @Override
    public Optional<User> deleteById(Long id) {
        return Optional.empty();
    }
}
