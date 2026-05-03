package com.skinsight.user.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "user_profile")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserProfile {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(name = "skin_type")
    private SkinType skinType;

    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "skin_conditions", columnDefinition = "text[]")
    @Builder.Default
    private List<String> skinConditions = new ArrayList<>();

    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "allergens", columnDefinition = "text[]")
    @Builder.Default
    private List<String> allergens = new ArrayList<>();

    public enum SkinType { NORMAL, OILY, DRY, COMBINATION, SENSITIVE }
}
