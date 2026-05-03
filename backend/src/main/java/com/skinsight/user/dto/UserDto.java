package com.skinsight.user.dto;

import com.skinsight.user.entity.UserProfile.SkinType;
import lombok.Data;

import java.util.List;

public class UserDto {

    @Data
    public static class ProfileUpdateRequest {
        private SkinType skinType;
        private List<String> skinConditions;
        private List<String> allergens;
    }

    @Data
    public static class ProfileResponse {
        private Long userId;
        private String email;
        private SkinType skinType;
        private List<String> skinConditions;
        private List<String> allergens;
    }
}
