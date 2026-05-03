package com.skinsight.analysis.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.skinsight.analysis.dto.AnalysisResult;
import com.skinsight.analysis.engine.RuleEngineService;
import com.skinsight.analysis.entity.AnalysisHistory;
import com.skinsight.analysis.repository.AnalysisHistoryRepository;
import com.skinsight.common.exception.AppException;
import com.skinsight.product.entity.Product;
import com.skinsight.product.repository.ProductRepository;
import com.skinsight.user.entity.User;
import com.skinsight.user.entity.UserProfile;
import com.skinsight.user.repository.UserProfileRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AnalysisService {

    private final ProductRepository productRepository;
    private final UserProfileRepository userProfileRepository;
    private final AnalysisHistoryRepository analysisHistoryRepository;
    private final RuleEngineService ruleEngineService;
    private final ObjectMapper objectMapper;

    @Transactional
    public AnalysisResult analyze(Long productId, User user) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new AppException("Product not found", HttpStatus.NOT_FOUND));

        UserProfile profile = userProfileRepository.findByUserId(user.getId())
                .orElseGet(() -> UserProfile.builder().user(user).build());

        AnalysisResult result = ruleEngineService.evaluate(product, profile);

        // Persist to history
        try {
            String json = objectMapper.writeValueAsString(result);
            AnalysisHistory history = AnalysisHistory.builder()
                    .user(user)
                    .product(product)
                    .resultJson(json)
                    .build();
            analysisHistoryRepository.save(history);
        } catch (JsonProcessingException e) {
            // Log but don't fail the request
        }

        return result;
    }

    public Page<AnalysisResult> getHistory(Long userId, int page, int size) {
        return analysisHistoryRepository
                .findByUserIdOrderByCreatedAtDesc(userId, PageRequest.of(page, size))
                .map(h -> {
                    try {
                        return objectMapper.readValue(h.getResultJson(), AnalysisResult.class);
                    } catch (JsonProcessingException e) {
                        return null;
                    }
                });
    }
}
