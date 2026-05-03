import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { analysisApi, compatibilityApi, productsApi } from '@/api'

// ── Products ──────────────────────────────────────────────────────────────────
export function useProducts(params: { q?: string; category?: string; page?: number }) {
  return useQuery({
    queryKey: ['products', params],
    queryFn: () => productsApi.search(params).then((r) => r.data.data),
    placeholderData: (prev) => prev,
  })
}

export function useProduct(id: number) {
  return useQuery({
    queryKey: ['product', id],
    queryFn: () => productsApi.getById(id).then((r) => r.data.data),
    enabled: !!id,
  })
}

// ── Analysis ──────────────────────────────────────────────────────────────────
export function useAnalysis(productId: number) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: () => analysisApi.analyze(productId).then((r) => r.data.data),
    onSuccess: (data) => {
      qc.setQueryData(['analysis', productId], data)
    },
  })
}

export function useAnalysisHistory(page = 0) {
  return useQuery({
    queryKey: ['analysis-history', page],
    queryFn: () => analysisApi.getHistory(page).then((r) => r.data.data),
  })
}

// ── Compatibility ─────────────────────────────────────────────────────────────
export function useCompatibility() {
  return useMutation({
    mutationFn: (productIds: number[]) =>
      compatibilityApi.check(productIds).then((r) => r.data.data),
  })
}
