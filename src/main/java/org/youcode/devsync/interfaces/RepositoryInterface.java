package org.youcode.devsync.interfaces;

import java.util.List;
import java.util.Optional;

public interface RepositoryInterface<T> {
    public Optional<T> findById(Long id);
    public List<T> findAll();
    public Optional<T> create(T object);
    public Optional<T> update(T object);
    public Optional<T> delete(T object);
    public Optional<T> deleteById(Long id);
}
