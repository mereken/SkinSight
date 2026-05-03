package com.skinsight.admin.controller;

import com.skinsight.common.dto.ApiResponse;
import com.skinsight.ingredient.dto.IngredientDto.*;
import com.skinsight.ingredient.service.IngredientService;
import com.skinsight.product.dto.ProductDto.*;
import com.skinsight.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('ADMIN')")
@RequiredArgsConstructor
public class AdminController {

    private final ProductService productService;
    private final IngredientService ingredientService;

    @PostMapping("/products")
    public ResponseEntity<ApiResponse<ProductDetail>> createProduct(@RequestBody CreateRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(productService.create(request)));
    }

    @PutMapping("/products/{id}")
    public ResponseEntity<ApiResponse<ProductDetail>> updateProduct(
            @PathVariable Long id, @RequestBody CreateRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(productService.update(id, request)));
    }

    @DeleteMapping("/products/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteProduct(@PathVariable Long id) {
        productService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok("Product deleted", null));
    }

    @PostMapping("/ingredients")
    public ResponseEntity<ApiResponse<IngredientDetail>> createIngredient(
            @RequestBody IngredientCreateRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(ingredientService.create(request)));
    }

    @PutMapping("/ingredients/{id}")
    public ResponseEntity<ApiResponse<IngredientDetail>> updateIngredient(
            @PathVariable Long id, @RequestBody IngredientCreateRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(ingredientService.update(id, request)));
    }
}
