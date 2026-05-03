import { useState } from 'react'
import { GitCompare, Plus, X, CheckCircle, AlertTriangle } from 'lucide-react'
import { useCompatibility } from '@/hooks/useProducts'
import { useFavorites } from '@/hooks/useAuth'
import { Button, Card, Empty, Spinner } from '@/components/ui'
import type { CompatibilityResult } from '@/types'
import { clsx } from 'clsx'

const SEVERITY_COLOR = {
  LOW:    'border-l-yellow-300 bg-yellow-50',
  MEDIUM: 'border-l-orange-400 bg-orange-50',
  HIGH:   'border-l-red-500 bg-red-50',
}
const SEVERITY_BADGE = {
  LOW:    'bg-yellow-100 text-yellow-800',
  MEDIUM: 'bg-orange-100 text-orange-800',
  HIGH:   'bg-red-100 text-red-800',
}

export function CompatibilityPage() {
  const { data: favorites, isLoading: favLoading } = useFavorites()
  const check = useCompatibility()

  const [selected, setSelected] = useState<number[]>([])
  const [result, setResult] = useState<CompatibilityResult | null>(null)

  const toggle = (id: number) => {
    setSelected((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : prev.length < 4 ? [...prev, id] : prev
    )
    setResult(null)
  }

  const handleCheck = async () => {
    const res = await check.mutateAsync(selected)
    setResult(res)
  }

  return (
    <div className="flex flex-col gap-6 max-w-2xl">
      <div>
        <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
          <GitCompare className="w-6 h-6 text-primary-500" /> Compatibility checker
        </h1>
        <p className="text-sm text-gray-500 mt-1">
          Select 2–4 products from your favorites to check for ingredient conflicts.
        </p>
      </div>

      {/* Product selector */}
      <Card>
        <h2 className="font-semibold text-gray-800 mb-3">Select products</h2>
        {favLoading ? (
          <div className="flex justify-center py-6"><Spinner className="w-5 h-5" /></div>
        ) : !favorites?.length ? (
          <Empty message="Add products to favorites first to use the compatibility checker." />
        ) : (
          <div className="flex flex-col gap-2">
            {favorites.map((p) => {
              const isSelected = selected.includes(p.id)
              return (
                <button
                  key={p.id}
                  onClick={() => toggle(p.id)}
                  className={clsx(
                    'flex items-center gap-3 p-3 rounded-lg border-2 text-left transition-all',
                    isSelected
                      ? 'border-primary-500 bg-primary-50'
                      : 'border-gray-100 hover:border-gray-200 bg-white'
                  )}
                >
                  <div className={clsx(
                    'w-5 h-5 rounded-full border-2 flex items-center justify-center shrink-0 transition-colors',
                    isSelected ? 'border-primary-600 bg-primary-600' : 'border-gray-300'
                  )}>
                    {isSelected && <div className="w-2 h-2 rounded-full bg-white" />}
                  </div>
                  <div className="flex flex-col gap-0.5 min-w-0">
                    <p className="text-sm font-medium text-gray-900 truncate">{p.name}</p>
                    {p.brand && <p className="text-xs text-gray-400">{p.brand}</p>}
                  </div>
                </button>
              )
            })}
          </div>
        )}

        {selected.length >= 2 && (
          <div className="mt-4 pt-4 border-t border-gray-100">
            <Button
              onClick={handleCheck}
              loading={check.isPending}
              className="gap-2"
            >
              <GitCompare className="w-4 h-4" />
              Check {selected.length} products
            </Button>
          </div>
        )}
      </Card>

      {/* Result */}
      {result && (
        <Card>
          <div className="flex items-center gap-3 mb-4">
            {result.safe ? (
              <>
                <CheckCircle className="w-6 h-6 text-green-500 shrink-0" />
                <div>
                  <p className="font-semibold text-green-700">No conflicts found</p>
                  <p className="text-sm text-gray-500">
                    {result.productNames.join(' + ')} can be used together safely.
                  </p>
                </div>
              </>
            ) : (
              <>
                <AlertTriangle className="w-6 h-6 text-red-500 shrink-0" />
                <div>
                  <p className="font-semibold text-red-700">
                    {result.conflicts.length} conflict{result.conflicts.length > 1 ? 's' : ''} found
                  </p>
                  <p className="text-sm text-gray-500">
                    {result.productNames.join(' + ')}
                  </p>
                </div>
              </>
            )}
          </div>

          {result.conflicts.length > 0 && (
            <div className="flex flex-col gap-3">
              {result.conflicts.map((c, i) => (
                <div
                  key={i}
                  className={clsx('border-l-4 rounded-r-lg p-4', SEVERITY_COLOR[c.severity])}
                >
                  <div className="flex items-center gap-2 mb-1">
                    <span className="font-medium text-sm text-gray-900">
                      {c.ingredientA} + {c.ingredientB}
                    </span>
                    <span className={clsx('badge text-[10px]', SEVERITY_BADGE[c.severity])}>
                      {c.severity}
                    </span>
                  </div>
                  <p className="text-sm text-gray-600 leading-relaxed">{c.description}</p>
                </div>
              ))}
            </div>
          )}
        </Card>
      )}
    </div>
  )
}
