package com.skinsight.compatibility.service;

import com.skinsight.common.exception.AppException;
import com.skinsight.compatibility.dto.CompatibilityResult;
import com.skinsight.compatibility.dto.CompatibilityResult.Conflict;
import com.skinsight.ingredient.entity.IngredientInteraction;
import com.skinsight.ingredient.repository.InteractionRepository;
import com.skinsight.product.entity.Product;
import com.skinsight.product.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CompatibilityService {

    private final ProductRepository productRepository;
    private final InteractionRepository interactionRepository;

    public CompatibilityResult check(List<Long> productIds) {
        if (productIds == null || productIds.size() < 2) {
            throw new AppException("At least 2 products required", HttpStatus.BAD_REQUEST);
        }

        List<Product> products = productRepository.findAllById(productIds);
        if (products.size() != productIds.size()) {
            throw new AppException("One or more products not found", HttpStatus.NOT_FOUND);
        }

        // Collect all ingredient IDs across selected products
        List<Long> allIngredientIds = products.stream()
                .flatMap(p -> p.getProductIngredients().stream())
                .map(pi -> pi.getIngredient().getId())
                .distinct()
                .toList();

        // Find any known interactions between these ingredients
        List<IngredientInteraction> interactions =
                interactionRepository.findConflictsBetween(allIngredientIds);

        List<Conflict> conflicts = interactions.stream()
                .map(i -> Conflict.builder()
                        .ingredientA(nameOf(i.getIngredientA().getCommonName(), i.getIngredientA().getInciName()))
                        .ingredientB(nameOf(i.getIngredientB().getCommonName(), i.getIngredientB().getInciName()))
                        .severity(i.getSeverity())
                        .description(i.getDescription())
                        .build())
                .toList();

        return CompatibilityResult.builder()
                .productIds(productIds)
                .productNames(products.stream().map(Product::getName).toList())
                .safe(conflicts.isEmpty())
                .conflicts(conflicts)
                .build();
    }

    private String nameOf(String commonName, String inciName) {
        return commonName != null ? commonName : inciName;
    }
}
