package com.skinsight.analysis.dto;

import com.skinsight.ingredient.entity.IngredientFlag.FlagType;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class AnalysisResult {

    private Long productId;
    private String productName;
    private int safetyScore;           // 0–100
    private String scoreLabel;         // GREAT / GOOD / CAUTION / POOR
    private List<FlaggedIngredient> flaggedIngredients;
    private List<String> topBeneficials;   // top 3 active/beneficial names
    private List<String> topRisks;         // top 3 caution/avoid names

    @Data
    @Builder
    public static class FlaggedIngredient {
        private Long ingredientId;
        private String inciName;
        private String commonName;
        private FlagType flag;
        private String explanation;   // "Contains Alcohol Denat. which may dry your skin"
    }

    public static String labelForScore(int score) {
        if (score >= 80) return "GREAT";
        if (score >= 60) return "GOOD";
        if (score >= 40) return "CAUTION";
        return "POOR";
    }
}
