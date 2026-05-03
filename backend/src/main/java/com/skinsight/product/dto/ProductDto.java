package com.skinsight.product.dto;

import lombok.Data;
import java.util.List;

public class ProductDto {

    @Data
    public static class ProductSummary {
        private Long id;
        private String name;
        private String brand;
        private String category;
        private String imageUrl;
    }

    @Data
    public static class ProductDetail {
        private Long id;
        private String name;
        private String brand;
        private String category;
        private String description;
        private String imageUrl;
        private List<IngredientItem> ingredients;

        @Data
        public static class IngredientItem {
            private Long id;
            private String inciName;
            private String commonName;
            private List<String> functions;
            private int position;
        }
    }

    @Data
    public static class CreateRequest {
        private String name;
        private String brand;
        private String category;
        private String description;
        private String imageUrl;
        private List<Long> ingredientIds; // ordered list
    }
}
