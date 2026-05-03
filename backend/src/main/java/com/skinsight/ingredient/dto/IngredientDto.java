package com.skinsight.ingredient.dto;

import com.skinsight.ingredient.entity.IngredientFlag.FlagType;
import com.skinsight.user.entity.UserProfile.SkinType;
import lombok.Data;

import java.util.List;

public class IngredientDto {

    @Data
    public static class IngredientDetail {
        private Long id;
        private String inciName;
        private String commonName;
        private String description;
        private List<String> functions;
        private List<FlagSummary> flags;

        @Data
        public static class FlagSummary {
            private SkinType skinType;
            private FlagType flag;
        }
    }

    @Data
    public static class IngredientCreateRequest {
        private String inciName;
        private String commonName;
        private String description;
        private List<String> functions;
        private List<FlagInput> flags;

        @Data
        public static class FlagInput {
            private SkinType skinType;
            private FlagType flag;
        }
    }
}
