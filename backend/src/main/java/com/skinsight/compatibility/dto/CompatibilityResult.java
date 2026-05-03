package com.skinsight.compatibility.dto;

import com.skinsight.ingredient.entity.IngredientInteraction.Severity;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class CompatibilityResult {

    private List<Long> productIds;
    private List<String> productNames;
    private boolean safe;
    private List<Conflict> conflicts;

    @Data
    @Builder
    public static class Conflict {
        private String ingredientA;
        private String ingredientB;
        private Severity severity;
        private String description;
    }
}
