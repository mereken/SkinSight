package com.skinsight.ingredient.controller;

import com.skinsight.common.dto.ApiResponse;
import com.skinsight.ingredient.dto.IngredientDto.*;
import com.skinsight.ingredient.service.IngredientService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ingredients")
@RequiredArgsConstructor
public class IngredientController {

    private final IngredientService ingredientService;

    @GetMapping
    public ResponseEntity<ApiResponse<Page<IngredientDetail>>> list(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(ApiResponse.ok(ingredientService.search(q, page, size)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<IngredientDetail>> getById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(ingredientService.getById(id)));
    }
}
