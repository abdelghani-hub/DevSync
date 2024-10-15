package org.youcode.devsync.service;

import org.youcode.devsync.model.Tag;
import org.youcode.devsync.repository.TagRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class TagService {
    private TagRepository tagRepository;

    public TagService() {
        tagRepository = new TagRepository();
    }

    public List<Tag> getAllTags() {
        return tagRepository.findAll();
    }

    public Optional<Tag> getTagById(Long id) {
        return tagRepository.findById(id);
    }

    public Optional<Tag> createTag(Tag tag) {
        return tagRepository.create(tag);
    }

    public Optional<Tag> updateTag(Tag tag) {
        return tagRepository.update(tag);
    }

    public Tag deleteTag(Tag tag) {
        return tagRepository.delete(tag);
    }

    public List<Tag> getTagsByIds(List<Long> ids) {
        List<Tag> tags = tagRepository.findAll();
        return tags.stream()
                .filter(tag -> ids.contains(tag.getId()))
                .collect(Collectors.toList());
    }
}
