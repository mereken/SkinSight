package com.skinsight.user.service;

import com.skinsight.common.exception.AppException;
import com.skinsight.product.entity.Product;
import com.skinsight.product.repository.ProductRepository;
import com.skinsight.user.dto.UserDto.*;
import com.skinsight.user.entity.*;
import com.skinsight.user.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserProfileRepository userProfileRepository;
    private final FavoriteRepository favoriteRepository;
    private final ProductRepository productRepository;

    public ProfileResponse getProfile(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException("User not found", HttpStatus.NOT_FOUND));
        UserProfile profile = userProfileRepository.findByUserId(userId)
                .orElseGet(() -> UserProfile.builder().user(user).build());

        ProfileResponse response = new ProfileResponse();
        response.setUserId(user.getId());
        response.setEmail(user.getEmail());
        response.setSkinType(profile.getSkinType());
        response.setSkinConditions(profile.getSkinConditions());
        response.setAllergens(profile.getAllergens());
        return response;
    }

    @Transactional
    public ProfileResponse updateProfile(Long userId, ProfileUpdateRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException("User not found", HttpStatus.NOT_FOUND));

        UserProfile profile = userProfileRepository.findByUserId(userId)
                .orElseGet(() -> UserProfile.builder().user(user).build());

        if (request.getSkinType() != null) profile.setSkinType(request.getSkinType());
        if (request.getSkinConditions() != null) profile.setSkinConditions(request.getSkinConditions());
        if (request.getAllergens() != null) profile.setAllergens(request.getAllergens());

        userProfileRepository.save(profile);
        return getProfile(userId);
    }

    public List<Product> getFavorites(Long userId) {
        return favoriteRepository.findByUserId(userId)
                .stream().map(Favorite::getProduct).toList();
    }

    @Transactional
    public void addFavorite(Long userId, Long productId) {
        if (favoriteRepository.existsByUserIdAndProductId(userId, productId)) return;
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException("User not found", HttpStatus.NOT_FOUND));
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new AppException("Product not found", HttpStatus.NOT_FOUND));
        favoriteRepository.save(Favorite.builder().user(user).product(product).build());
    }

    @Transactional
    public void removeFavorite(Long userId, Long productId) {
        favoriteRepository.deleteByUserIdAndProductId(userId, productId);
    }
}
