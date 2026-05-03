package com.skinsight.analysis.engine;

import com.skinsight.analysis.dto.AnalysisResult;
import com.skinsight.analysis.dto.AnalysisResult.FlaggedIngredient;
import com.skinsight.ingredient.entity.Ingredient;
import com.skinsight.ingredient.entity.IngredientFlag;
import com.skinsight.ingredient.entity.IngredientFlag.FlagType;
import com.skinsight.product.entity.Product;
import com.skinsight.user.entity.UserProfile;
import com.skinsight.user.entity.UserProfile.SkinType;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class RuleEngineService {

    private static final int PENALTY_CAUTION = 5;
    private static final int PENALTY_AVOID   = 15;

    public AnalysisResult evaluate(Product product, UserProfile profile) {
        SkinType skinType = profile.getSkinType();
        List<String> allergens = profile.getAllergens() != null
                ? profile.getAllergens().stream().map(String::toUpperCase).toList()
                : List.of();

        List<FlaggedIngredient> flagged = new ArrayList<>();
        int score = 100;

        for (var pi : product.getProductIngredients()) {
            Ingredient ingredient = pi.getIngredient();
            FlagType flag = resolveFlag(ingredient, skinType, allergens);

            // Build explanation only for non-neutral flags
            if (flag != FlagType.NEUTRAL) {
                String explanation = buildExplanation(ingredient, flag, skinType);
                flagged.add(FlaggedIngredient.builder()
                        .ingredientId(ingredient.getId())
                        .inciName(ingredient.getInciName())
                        .commonName(ingredient.getCommonName())
                        .flag(flag)
                        .explanation(explanation)
                        .build());
            }

            if (flag == FlagType.CAUTION) score -= PENALTY_CAUTION;
            if (flag == FlagType.AVOID)   score -= PENALTY_AVOID;
        }

        score = Math.max(0, score);

        List<String> topBeneficials = flagged.stream()
                .filter(f -> f.getFlag() == FlagType.BENEFICIAL)
                .limit(3)
                .map(f -> f.getCommonName() != null ? f.getCommonName() : f.getInciName())
                .toList();

        List<String> topRisks = flagged.stream()
                .filter(f -> f.getFlag() == FlagType.CAUTION || f.getFlag() == FlagType.AVOID)
                .limit(3)
                .map(f -> f.getCommonName() != null ? f.getCommonName() : f.getInciName())
                .toList();

        return AnalysisResult.builder()
                .productId(product.getId())
                .productName(product.getName())
                .safetyScore(score)
                .scoreLabel(AnalysisResult.labelForScore(score))
                .flaggedIngredients(flagged)
                .topBeneficials(topBeneficials)
                .topRisks(topRisks)
                .build();
    }

    private FlagType resolveFlag(Ingredient ingredient, SkinType skinType, List<String> allergens) {
        // Allergen check takes priority
        if (allergens.contains(ingredient.getInciName().toUpperCase())) {
            return FlagType.AVOID;
        }

        if (skinType == null) return FlagType.NEUTRAL;

        return ingredient.getFlags().stream()
                .filter(f -> f.getSkinType() == skinType)
                .map(IngredientFlag::getFlag)
                .findFirst()
                .orElse(FlagType.NEUTRAL);
    }

    private String buildExplanation(Ingredient ingredient, FlagType flag, SkinType skinType) {
        String name = ingredient.getCommonName() != null
                ? ingredient.getCommonName()
                : ingredient.getInciName();

        return switch (flag) {
            case BENEFICIAL -> name + " is beneficial for your " + formatSkinType(skinType) + " skin.";
            case CAUTION    -> name + " may cause mild irritation for " + formatSkinType(skinType) + " skin. Use with care.";
            case AVOID      -> name + " is not recommended for " + formatSkinType(skinType) + " skin and may cause irritation.";
            default         -> name + " has no specific effect for your skin type.";
        };
    }

    private String formatSkinType(SkinType skinType) {
        if (skinType == null) return "your";
        return skinType.name().toLowerCase();
    }
}
