import api from '@/lib/axios'
import type {
  ApiResponse, PageResponse,
  AuthResponse, UserProfile,
  ProductSummary, ProductDetail,
  AnalysisResult, CompatibilityResult,
} from '@/types'

// ── Auth ─────────────────────────────────────────────────────────────────────
export const authApi = {
  register: (email: string, password: string) =>
    api.post<ApiResponse<AuthResponse>>('/auth/register', { email, password }),
  login: (email: string, password: string) =>
    api.post<ApiResponse<AuthResponse>>('/auth/login', { email, password }),
  logout: () => api.post('/auth/logout'),
}

// ── User ─────────────────────────────────────────────────────────────────────
export const userApi = {
  getMe: () =>
    api.get<ApiResponse<UserProfile>>('/users/me'),
  updateProfile: (data: Partial<UserProfile>) =>
    api.put<ApiResponse<UserProfile>>('/users/me/profile', data),
  getFavorites: () =>
    api.get<ApiResponse<ProductSummary[]>>('/users/me/favorites'),
  addFavorite: (productId: number) =>
    api.post(`/users/me/favorites/${productId}`),
  removeFavorite: (productId: number) =>
    api.delete(`/users/me/favorites/${productId}`),
}

// ── Products ──────────────────────────────────────────────────────────────────
export const productsApi = {
  search: (params: { q?: string; category?: string; page?: number; size?: number }) =>
    api.get<ApiResponse<PageResponse<ProductSummary>>>('/products', { params }),
  getById: (id: number) =>
    api.get<ApiResponse<ProductDetail>>(`/products/${id}`),
}

// ── Analysis ──────────────────────────────────────────────────────────────────
export const analysisApi = {
  analyze: (productId: number) =>
    api.post<ApiResponse<AnalysisResult>>(`/analysis/${productId}`),
  getHistory: (page = 0) =>
    api.get<ApiResponse<PageResponse<AnalysisResult>>>('/analysis/history', { params: { page } }),
}

// ── Compatibility ─────────────────────────────────────────────────────────────
export const compatibilityApi = {
  check: (productIds: number[]) =>
    api.post<ApiResponse<CompatibilityResult>>('/compatibility/check', { productIds }),
}
