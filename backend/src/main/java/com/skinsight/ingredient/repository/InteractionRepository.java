package com.skinsight.ingredient.repository;

import com.skinsight.ingredient.entity.IngredientInteraction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface InteractionRepository extends JpaRepository<IngredientInteraction, Long> {

    @Query("""
        SELECT i FROM IngredientInteraction i
        WHERE (i.ingredientA.id IN :ids AND i.ingredientB.id IN :ids)
    """)
    List<IngredientInteraction> findConflictsBetween(@Param("ids") List<Long> ingredientIds);
}
