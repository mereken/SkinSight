package com.skinsight.product.controller;

import com.skinsight.common.dto.ApiResponse;
import com.skinsight.product.dto.ProductDto.*;
import com.skinsight.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @GetMapping
    public ResponseEntity<ApiResponse<Page<ProductSummary>>> search(
            @RequestParam(required = false) String q,
            @RequestParam(required = false) String category,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size) {
        return ResponseEntity.ok(ApiResponse.ok(productService.search(q, category, page, size)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<ProductDetail>> getById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(productService.getById(id)));
    }
}
