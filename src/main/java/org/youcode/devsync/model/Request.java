package org.youcode.devsync.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "tasks")
public class Request {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, updatable = false)
    private User requester;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "task_id", nullable = false, updatable = false)
    private Task task;

    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private RequestType type;

    @Column(name = "status", nullable = false, columnDefinition = "VARCHAR(10) DEFAULT 'PENDING'")
    @Enumerated(EnumType.STRING)
    private RequestStatus status;

    @Column(name = "requested_at", nullable = false, updatable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime requestedAt;

    @Column(name = "responded_at", nullable = true)
    private LocalDateTime respondedAt;
}
