package com.skinsight.ingredient.repository;

import com.skinsight.ingredient.entity.Ingredient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface IngredientRepository extends JpaRepository<Ingredient, Long> {
    Optional<Ingredient> findByInciNameIgnoreCase(String inciName);

    @Query("SELECT i FROM Ingredient i LEFT JOIN FETCH i.flags WHERE i.id IN :ids")
    List<Ingredient> findAllWithFlagsByIds(@Param("ids") List<Long> ids);
}
