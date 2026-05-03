package com.skinsight.auth.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

public class AuthDto {

    @Data
    public static class RegisterRequest {
        @Email(message = "Invalid email")
        @NotBlank
        private String email;

        @NotBlank
        @Size(min = 6, message = "Password must be at least 6 characters")
        private String password;
    }

    @Data
    public static class LoginRequest {
        @NotBlank private String email;
        @NotBlank private String password;
    }

    @Data
    public static class RefreshRequest {
        @NotBlank private String refreshToken;
    }

    @Data
    public static class AuthResponse {
        private String accessToken;
        private String refreshToken;
        private UserInfo user;

        @Data
        public static class UserInfo {
            private Long id;
            private String email;
            private String role;
        }
    }
}
