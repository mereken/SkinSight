import { useState } from 'react'
import { useParams, Link } from 'react-router-dom'
import { ArrowLeft, Package, Heart, FlaskConical } from 'lucide-react'
import { useProduct, useAnalysis } from '@/hooks/useProducts'
import { useFavorites } from '@/hooks/useAuth'
import { userApi } from '@/api'
import { useAuthStore } from '@/store/authStore'
import { Button, Spinner } from '@/components/ui'
import { AnalysisPanel } from '@/components/AnalysisPanel'
import { useQueryClient } from '@tanstack/react-query'
import type { AnalysisResult } from '@/types'

export function ProductDetailPage() {
  const { id } = useParams<{ id: string }>()
  const productId = Number(id)
  const isAuthenticated = useAuthStore((s) => s.isAuthenticated())
  const qc = useQueryClient()

  const { data: product, isLoading } = useProduct(productId)
  const { data: favorites } = useFavorites()
  const analyze = useAnalysis(productId)
  const [analysisResult, setAnalysisResult] = useState<AnalysisResult | null>(null)

  const isFav = favorites?.some((f) => f.id === productId) ?? false

  const toggleFavorite = async () => {
    if (isFav) await userApi.removeFavorite(productId)
    else await userApi.addFavorite(productId)
    qc.invalidateQueries({ queryKey: ['favorites'] })
  }

  const handleAnalyze = async () => {
    const result = await analyze.mutateAsync()
    setAnalysisResult(result)
  }

  if (isLoading) return <div className="flex justify-center py-20"><Spinner className="w-8 h-8" /></div>
  if (!product) return <p className="text-gray-500">Product not found.</p>

  return (
    <div className="flex flex-col gap-6 max-w-3xl">
      <Link to="/products" className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-primary-600 transition-colors w-fit">
        <ArrowLeft className="w-4 h-4" /> Back to products
      </Link>

      {/* Header */}
      <div className="card p-6 flex flex-col sm:flex-row gap-4">
        <div className="w-16 h-16 rounded-xl bg-primary-50 flex items-center justify-center shrink-0">
          <Package className="w-8 h-8 text-primary-400" />
        </div>
        <div className="flex flex-col gap-1 flex-1">
          <div className="flex items-start justify-between gap-3">
            <h1 className="text-xl font-bold text-gray-900">{product.name}</h1>
            {isAuthenticated && (
              <button onClick={toggleFavorite} className="shrink-0 mt-0.5">
                <Heart className={`w-5 h-5 transition-colors ${isFav ? 'fill-red-500 text-red-500' : 'text-gray-300 hover:text-red-400'}`} />
              </button>
            )}
          </div>
          {product.brand && <p className="text-sm text-gray-500">{product.brand}</p>}
          {product.category && (
            <span className="self-start text-xs bg-primary-50 text-primary-600 px-2 py-0.5 rounded-full font-medium mt-1">
              {product.category}
            </span>
          )}
          {product.description && (
            <p className="text-sm text-gray-600 mt-2 leading-relaxed">{product.description}</p>
          )}
        </div>
      </div>

      {/* Ingredients */}
      <div className="card p-6 flex flex-col gap-4">
        <h2 className="font-semibold text-gray-900 flex items-center gap-2">
          <FlaskConical className="w-4 h-4 text-primary-500" />
          Ingredients ({product.ingredients.length})
        </h2>
        <div className="flex flex-wrap gap-2">
          {product.ingredients.map((ing) => (
            <span key={ing.id} title={ing.inciName}
              className="text-xs bg-gray-50 border border-gray-200 text-gray-700 px-2.5 py-1 rounded-full">
              {ing.commonName ?? ing.inciName}
            </span>
          ))}
        </div>

        {isAuthenticated ? (
          <div className="pt-2 border-t border-gray-100">
            <Button onClick={handleAnalyze} loading={analyze.isPending} className="gap-2">
              <FlaskConical className="w-4 h-4" /> Analyze for my skin
            </Button>
            <p className="text-xs text-gray-400 mt-2">
              Based on your skin type and conditions from your profile.
            </p>
          </div>
        ) : (
          <p className="text-sm text-gray-500 bg-gray-50 rounded-lg px-4 py-3">
            <Link to="/login" className="text-primary-600 font-medium hover:underline">Sign in</Link> to analyze this product for your skin type.
          </p>
        )}
      </div>

      {/* Analysis result */}
      {analysisResult && (
        <div className="card p-6 flex flex-col gap-4">
          <h2 className="font-semibold text-gray-900">Analysis result</h2>
          <AnalysisPanel result={analysisResult} />
        </div>
      )}
    </div>
  )
}
