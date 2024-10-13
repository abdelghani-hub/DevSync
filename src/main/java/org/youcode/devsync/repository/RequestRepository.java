package org.youcode.devsync.repository;

import jakarta.persistence.EntityManager;
import org.youcode.devsync.interfaces.RepositoryInterface;
import org.youcode.devsync.model.Request;
import org.youcode.devsync.util.EntityManagerProvider;

import java.util.List;
import java.util.Optional;

public class RequestRepository implements RepositoryInterface<Request> {

    private EntityManager getEntityManager() {
        return EntityManagerProvider.getEntityManagerFactory().createEntityManager();
    }

    @Override
    public Optional<Request> findById(Long id) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            Request request = entityManager.find(Request.class, id);
            entityManager.getTransaction().commit();
            return Optional.ofNullable(request);
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
    public List<Request> findAll() {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            List<Request> requests = entityManager.createQuery("SELECT r FROM Request r", Request.class).getResultList();
            entityManager.getTransaction().commit();
            return requests;
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
    public Optional<Request> create(Request request) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(request);
            entityManager.getTransaction().commit();
            return Optional.of(request);
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
    public Optional<Request> update(Request request) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            Request updatedRequest = entityManager.merge(request);
            entityManager.getTransaction().commit();
            return Optional.of(updatedRequest);
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
    public Request delete(Request request) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            entityManager.remove(entityManager.contains(request) ? request : entityManager.merge(request));
            entityManager.getTransaction().commit();
            return request;
        } catch (Exception e) {
            e.printStackTrace();
            if (entityManager.getTransaction().isActive())
                entityManager.getTransaction().rollback();
            return null;
        } finally {
            entityManager.close();
        }
    }
}
