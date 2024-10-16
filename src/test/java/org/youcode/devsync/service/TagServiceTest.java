package org.youcode.devsync.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.youcode.devsync.model.Tag;
import org.youcode.devsync.repository.TagRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class TagServiceTest {
    @Mock
    private TagRepository tagRepository;
    private TagService tagService;

    // Before
    @BeforeEach
    public void initService() {
        this.tagService = new TagService(tagRepository);
    }

    @Test
    public void testGetAllTags() {
        when(tagRepository.findAll()).thenReturn(List.of(
                new Tag("Java"),
                new Tag("Spring"),
                new Tag("Hibernate")
        ));

        List<Tag> tags = tagService.getAllTags();
        assertEquals(List.of(
                new Tag("Java"),
                new Tag("Spring"),
                new Tag("Hibernate")
        ), tags);
    }

    @Test
    public void testGetTagById() {
        when(tagRepository.findById(10L)).thenReturn(java.util.Optional.of(
                new Tag(10L, "Java")
        ));
        when(tagRepository.findById(20L)).thenReturn(java.util.Optional.empty());

        assert tagService.getTagById(10L).get().equals(new Tag(10L, "Java"));
        assert tagService.getTagById(20L).isEmpty();
    }

    @Test
    public void testCreateNewTag() {
        Tag tag = new Tag("Java");
        when(tagRepository.findByName("Java")).thenReturn(java.util.Optional.empty());
        when(tagRepository.create(tag)).thenReturn(java.util.Optional.of(tag));

        assertEquals(java.util.Optional.of(tag), tagService.createTag(tag));
    }

    @Test
    public void testCreateExistingTag() {
        Tag tag = new Tag("Java");
        when(tagRepository.findByName("Java")).thenReturn(java.util.Optional.of(tag));

        // assert IllegalArgumentException with message "Tag already exists"
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.createTag(tag));
        assertEquals("Tag already exists", exception.getMessage());
    }

    @Test
    public void testUpdateTagWithNonExistingTag() {
        Tag tagToUpdate = new Tag(20L, "Java");

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.updateTag(tagToUpdate));
        assertEquals("Tag does not exist", exception.getMessage());
    }
//    ########################################

    @Test
    public void testGetTagById_ValidId() {
        // Arrange
        Long id = 1L;
        Tag tag = new Tag("Tag1");
        when(tagRepository.findById(id)).thenReturn(Optional.of(tag));

        // Act
        Optional<Tag> result = tagService.getTagById(id);

        // Assert
        assertTrue(result.isPresent());
        assertEquals("Tag1", result.get().getName());
        verify(tagRepository, times(1)).findById(id);
    }

    @Test
    public void testGetTagById_InvalidId() {
        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.getTagById(-1L));
        assertEquals("Invalid id", exception.getMessage());
    }

    @Test
    public void testCreateTag_ValidTag() {
        // Arrange
        Tag tag = new Tag("NewTag");
        when(tagRepository.findByName(tag.getName())).thenReturn(Optional.empty());
        when(tagRepository.create(tag)).thenReturn(Optional.of(tag));

        // Act
        Optional<Tag> result = tagService.createTag(tag);

        // Assert
        assertTrue(result.isPresent());
        assertEquals("NewTag", result.get().getName());
        verify(tagRepository, times(1)).findByName(tag.getName());
        verify(tagRepository, times(1)).create(tag);
    }

    @Test
    public void testCreateTag_DuplicateTag() {
        // Arrange
        Tag tag = new Tag("DuplicateTag");
        when(tagRepository.findByName(tag.getName())).thenReturn(Optional.of(tag));

        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.createTag(tag));
        assertEquals("Tag already exists", exception.getMessage());
    }

    @Test
    public void testCreateTag_InvalidTag() {
        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.createTag(new Tag("")));
        assertEquals("Invalid tag", exception.getMessage());
    }

    @Test
    public void testUpdateTag_ValidTag() {
        // Arrange
        Tag tag = new Tag(10L, "UpdatedTag");
        when(tagRepository.findById(tag.getId())).thenReturn(Optional.of(tag));
        when(tagRepository.findByName("ExistingTag")).thenReturn(Optional.of(new Tag(20L, "ExistingTag")));

        tag.setName("ExistingTag");
        // Act
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.updateTag(tag));

        // Assert
        assertEquals("Tag already exists", exception.getMessage());
        verify(tagRepository, times(0)).update(tag);
    }

    @Test
    public void testUpdateTag_InvalidTagId() {
        // Act & Assert
        IllegalArgumentException exception = assertThrows(
                IllegalArgumentException.class,
                () -> tagService.updateTag(new Tag("InvalidTag"))
        );
        assertEquals("Invalid tag id", exception.getMessage());
    }

    @Test
    public void testDeleteTag_ValidTag() {
        // Arrange
        Tag tag = new Tag("DeleteTag");
        tag.setId(1L);
        when(tagRepository.delete(tag)).thenReturn(tag);

        // Act
        Tag result = tagService.deleteTag(tag);

        // Assert
        assertNotNull(result);
        assertEquals("DeleteTag", result.getName());
        verify(tagRepository, times(1)).delete(tag);
    }

    @Test
    public void testDeleteTag_InvalidTag() {
        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.deleteTag(new Tag()));
        assertEquals("Invalid tag", exception.getMessage());
    }

    @Test
    public void testGetTagsByIds_ValidIds() {
        // Arrange
        Tag tag1 = new Tag("Tag1");
        tag1.setId(1L);
        Tag tag2 = new Tag("Tag2");
        tag2.setId(2L);
        List<Long> ids = Arrays.asList(1L, 2L);
        when(tagRepository.findAll()).thenReturn(Arrays.asList(tag1, tag2));

        // Act
        List<Tag> result = tagService.getTagsByIds(ids);

        // Assert
        assertEquals(2, result.size());
        assertEquals("Tag1", result.get(0).getName());
        assertEquals("Tag2", result.get(1).getName());
        verify(tagRepository, times(1)).findAll();
    }

    @Test
    public void testGetTagsByIds_NullIds() {
        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> tagService.getTagsByIds(null));
        assertEquals("Invalid ids", exception.getMessage());
    }
}