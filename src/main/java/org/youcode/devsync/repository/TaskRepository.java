package org.youcode.devsync.repository;

import jakarta.persistence.EntityManager;
import org.youcode.devsync.interfaces.RepositoryInterface;
import org.youcode.devsync.model.Task;
import org.youcode.devsync.model.User;
import org.youcode.devsync.util.EntityManagerProvider;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class TaskRepository implements RepositoryInterface<Task> {

    private EntityManager getEntityManager() {
        return EntityManagerProvider.getEntityManagerFactory().createEntityManager();
    }

    @Override
    public Optional<Task> findById(Long id) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            Task task = entityManager.find(Task.class, id);
            entityManager.getTransaction().commit();
            return Optional.ofNullable(task);
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
            return Optional.empty();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Task> findAll() {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            List<Task> tasks = entityManager.createQuery("SELECT u FROM Task u", Task.class).getResultList();
            entityManager.getTransaction().commit();
            return tasks;
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
            return null;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Optional<Task> create(Task task) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(task);
            entityManager.getTransaction().commit();
            return Optional.of(task);
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
            return Optional.empty();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Optional<Task> update(Task task) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            Task updatedTask = entityManager.merge(task);
            entityManager.getTransaction().commit();
            return Optional.of(updatedTask);
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
            return Optional.empty();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Task delete(Task task) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.remove(entityManager.contains(task) ? task : entityManager.merge(task));
            entityManager.getTransaction().commit();
            return task;
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
            return null;
        } finally {
            entityManager.close();
        }
    }

    public List<Task> findByAssignedTo(User user) {
        List<Task> tasks = new ArrayList<>();
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            tasks = entityManager.createQuery("SELECT t FROM Task t WHERE t.assignedTo = :user", Task.class)
                    .setParameter("user", user)
                    .getResultList();
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
        } finally {
            entityManager.close();
        }
        return tasks;
    }
}
