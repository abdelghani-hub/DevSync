package org.youcode.devsync.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class EntityManagerProvider {

    private static EntityManagerFactory entityManagerFactory;

    // Private constructor to prevent instantiation
    private EntityManagerProvider() {
    }

    // Method to get the EntityManagerFactory instance
    public static EntityManagerFactory getEntityManagerFactory() {
        if (entityManagerFactory == null) {
            entityManagerFactory = Persistence.createEntityManagerFactory("devsync");
        }
        return entityManagerFactory;
    }

    // Optional: Method to close the EntityManagerFactory when the application stops
    public static void closeEntityManagerFactory() {
        if (entityManagerFactory != null) {
            entityManagerFactory.close();
            entityManagerFactory = null;
        }
    }
}
