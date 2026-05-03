package com.skinsight.product.entity;

import com.skinsight.ingredient.entity.Ingredient;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "product_ingredients")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
@IdClass(ProductIngredientId.class)
public class ProductIngredient {

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @Id
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ingredient_id")
    private Ingredient ingredient;

    @Column(nullable = false)
    private Integer position;
}
