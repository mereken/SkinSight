package com.skinsight.user.controller;

import com.skinsight.common.dto.ApiResponse;
import com.skinsight.product.dto.ProductDto;
import com.skinsight.product.service.ProductService;
import com.skinsight.user.dto.UserDto.*;
import com.skinsight.user.entity.User;
import com.skinsight.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final ProductService productService;

    @GetMapping("/me")
    public ResponseEntity<ApiResponse<ProfileResponse>> getMe(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(ApiResponse.ok(userService.getProfile(user.getId())));
    }

    @PutMapping("/me/profile")
    public ResponseEntity<ApiResponse<ProfileResponse>> updateProfile(
            @AuthenticationPrincipal User user,
            @RequestBody ProfileUpdateRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(userService.updateProfile(user.getId(), request)));
    }

    @GetMapping("/me/favorites")
    public ResponseEntity<ApiResponse<List<ProductDto.ProductSummary>>> getFavorites(
            @AuthenticationPrincipal User user) {
        var favorites = userService.getFavorites(user.getId())
                .stream().map(productService::toSummary).toList();
        return ResponseEntity.ok(ApiResponse.ok(favorites));
    }

    @PostMapping("/me/favorites/{productId}")
    public ResponseEntity<ApiResponse<Void>> addFavorite(
            @AuthenticationPrincipal User user,
            @PathVariable Long productId) {
        userService.addFavorite(user.getId(), productId);
        return ResponseEntity.ok(ApiResponse.ok("Added to favorites", null));
    }

    @DeleteMapping("/me/favorites/{productId}")
    public ResponseEntity<ApiResponse<Void>> removeFavorite(
            @AuthenticationPrincipal User user,
            @PathVariable Long productId) {
        userService.removeFavorite(user.getId(), productId);
        return ResponseEntity.ok(ApiResponse.ok("Removed from favorites", null));
    }
}
