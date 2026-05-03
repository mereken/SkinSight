package com.skinsight.compatibility.controller;

import com.skinsight.common.dto.ApiResponse;
import com.skinsight.compatibility.dto.CompatibilityResult;
import com.skinsight.compatibility.service.CompatibilityService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/compatibility")
@RequiredArgsConstructor
public class CompatibilityController {

    private final CompatibilityService compatibilityService;

    @PostMapping("/check")
    public ResponseEntity<ApiResponse<CompatibilityResult>> check(
            @RequestBody CheckRequest request) {
        return ResponseEntity.ok(ApiResponse.ok(compatibilityService.check(request.getProductIds())));
    }

    @Data
    public static class CheckRequest {
        private List<Long> productIds;
    }
}
