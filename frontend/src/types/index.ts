// ── Auth ─────────────────────────────────────────────────────────────────────
export interface AuthResponse {
  accessToken: string
  refreshToken: string
  user: { id: number; email: string; role: string }
}

// ── User / Profile ────────────────────────────────────────────────────────────
export type SkinType = 'NORMAL' | 'OILY' | 'DRY' | 'COMBINATION' | 'SENSITIVE'

export interface UserProfile {
  userId: number
  email: string
  skinType: SkinType | null
  skinConditions: string[]
  allergens: string[]
}

// ── Ingredients ───────────────────────────────────────────────────────────────
export type FlagType = 'BENEFICIAL' | 'NEUTRAL' | 'CAUTION' | 'AVOID'

export interface IngredientSummary {
  id: number
  inciName: string
  commonName: string | null
  functions: string[]
  position: number
}

// ── Products ──────────────────────────────────────────────────────────────────
export interface ProductSummary {
  id: number
  name: string
  brand: string | null
  category: string | null
  imageUrl: string | null
}

export interface ProductDetail extends ProductSummary {
  description: string | null
  ingredients: IngredientSummary[]
}

// ── Analysis ──────────────────────────────────────────────────────────────────
export interface FlaggedIngredient {
  ingredientId: number
  inciName: string
  commonName: string | null
  flag: FlagType
  explanation: string
}

export interface AnalysisResult {
  productId: number
  productName: string
  safetyScore: number
  scoreLabel: 'GREAT' | 'GOOD' | 'CAUTION' | 'POOR'
  flaggedIngredients: FlaggedIngredient[]
  topBeneficials: string[]
  topRisks: string[]
}

// ── Compatibility ─────────────────────────────────────────────────────────────
export type Severity = 'LOW' | 'MEDIUM' | 'HIGH'

export interface Conflict {
  ingredientA: string
  ingredientB: string
  severity: Severity
  description: string
}

export interface CompatibilityResult {
  productIds: number[]
  productNames: string[]
  safe: boolean
  conflicts: Conflict[]
}

// ── API wrapper ───────────────────────────────────────────────────────────────
export interface ApiResponse<T> {
  success: boolean
  message?: string
  data: T
}

export interface PageResponse<T> {
  content: T[]
  totalElements: number
  totalPages: number
  number: number
  size: number
}
