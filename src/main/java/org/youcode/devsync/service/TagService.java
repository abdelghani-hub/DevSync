package org.youcode.devsync.service;

import org.youcode.devsync.model.Tag;
import org.youcode.devsync.repository.TagRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class TagService {
    private TagRepository tagRepository;

    public TagService(TagRepository tagRepository) {
        this.tagRepository = tagRepository;
    }

    public List<Tag> getAllTags() {
        return tagRepository.findAll();
    }

    public Optional<Tag> getTagById(Long id) {
        // validate id
        if(id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid id");
        }
        return tagRepository.findById(id);
    }

    public Optional<Tag> createTag(Tag tag) {
        // validate tag
        if(tag == null || tag.getName() == null || tag.getName().isEmpty()) {
            throw new IllegalArgumentException("Invalid tag");
        }

        // validate name unique
        if (tagRepository.findByName(tag.getName()).isPresent()) {
            throw new IllegalArgumentException("Tag already exists");
        }

        return tagRepository.create(tag);
    }

    public Optional<Tag> updateTag(Tag tag) {
        // Validate tag
        if (tag == null || tag.getName() == null || tag.getName().isEmpty()) {
            throw new IllegalArgumentException("Invalid tag");
        }

        // Validate ID
        if (tag.getId() == null || tag.getId() <= 0) {
            throw new IllegalArgumentException("Invalid tag id");
        }

        // Ensure that the tag exists (by ID) to update
        Optional<Tag> existingTagById = tagRepository.findById(tag.getId());
        if (existingTagById.isEmpty()) {
            throw new IllegalArgumentException("Tag does not exist");
        }

        // Ensure the new tag name is unique if it's being changed
        Optional<Tag> tagWithSameName = tagRepository.findByName(tag.getName());
        if (tagWithSameName.isPresent() && !tagWithSameName.get().getId().equals(tag.getId())) {
            // If another tag (different ID) with the same name exists, throw "Tag already exists"
            throw new IllegalArgumentException("Tag already exists");
        }

        // If the name is unique or belongs to the same tag, proceed with the update
        return tagRepository.update(tag);
    }


    public Tag deleteTag(Tag tag) {
        // validate tag
        if(tag == null || tag.getId() == null || tag.getId() <= 0) {
            throw new IllegalArgumentException("Invalid tag");
        }
        return tagRepository.delete(tag);
    }

    public List<Tag> getTagsByIds(List<Long> ids) {
        // validate ids
        if(ids == null) {
            throw new IllegalArgumentException("Invalid ids");
        }

        List<Tag> tags = tagRepository.findAll();
        return tags.stream()
                .filter(tag -> ids.contains(tag.getId()))
                .collect(Collectors.toList());
    }
}
