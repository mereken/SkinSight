package com.skinsight.analysis.repository;

import com.skinsight.analysis.entity.AnalysisHistory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AnalysisHistoryRepository extends JpaRepository<AnalysisHistory, Long> {
    Page<AnalysisHistory> findByUserIdOrderByCreatedAtDesc(Long userId, Pageable pageable);
    Optional<AnalysisHistory> findTopByUserIdAndProductIdOrderByCreatedAtDesc(Long userId, Long productId);
}
