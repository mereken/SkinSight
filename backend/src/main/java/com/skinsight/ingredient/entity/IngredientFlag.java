package com.skinsight.ingredient.entity;

import com.skinsight.user.entity.UserProfile.SkinType;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ingredient_flags")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class IngredientFlag {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingredient_id", nullable = false)
    private Ingredient ingredient;

    @Enumerated(EnumType.STRING)
    @Column(name = "skin_type", nullable = false)
    private SkinType skinType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private FlagType flag;

    public enum FlagType { BENEFICIAL, NEUTRAL, CAUTION, AVOID }
}
