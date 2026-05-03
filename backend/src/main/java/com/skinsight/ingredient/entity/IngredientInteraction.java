package com.skinsight.ingredient.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ingredient_interactions")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class IngredientInteraction {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingredient_a_id", nullable = false)
    private Ingredient ingredientA;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingredient_b_id", nullable = false)
    private Ingredient ingredientB;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Severity severity;

    @Column(columnDefinition = "TEXT")
    private String description;

    public enum Severity { LOW, MEDIUM, HIGH }
}
