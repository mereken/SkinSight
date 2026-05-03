package com.skinsight.analysis.controller;

import com.skinsight.analysis.dto.AnalysisResult;
import com.skinsight.analysis.service.AnalysisService;
import com.skinsight.common.dto.ApiResponse;
import com.skinsight.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/analysis")
@RequiredArgsConstructor
public class AnalysisController {

    private final AnalysisService analysisService;

    @PostMapping("/{productId}")
    public ResponseEntity<ApiResponse<AnalysisResult>> analyze(
            @PathVariable Long productId,
            @AuthenticationPrincipal User user) {
        return ResponseEntity.ok(ApiResponse.ok(analysisService.analyze(productId, user)));
    }

    @GetMapping("/history")
    public ResponseEntity<ApiResponse<Page<AnalysisResult>>> getHistory(
            @AuthenticationPrincipal User user,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(ApiResponse.ok(analysisService.getHistory(user.getId(), page, size)));
    }
}
