import { useState } from 'react'
import { Link } from 'react-router-dom'
import { Clock } from 'lucide-react'
import { useAnalysisHistory } from '@/hooks/useProducts'
import { Button, Empty, ScoreCircle, Spinner } from '@/components/ui'

export function HistoryPage() {
  const [page, setPage] = useState(0)
  const { data, isLoading } = useAnalysisHistory(page)

  return (
    <div className="flex flex-col gap-6 max-w-2xl">
      <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
        <Clock className="w-6 h-6 text-primary-500" /> Analysis history
      </h1>

      {isLoading ? (
        <div className="flex justify-center py-20"><Spinner className="w-8 h-8" /></div>
      ) : !data?.content.length ? (
        <Empty message="No analysis history yet. Analyze a product to get started." />
      ) : (
        <>
          <div className="flex flex-col gap-3">
            {data.content.map((r, i) => (
              <Link
                key={i}
                to={`/products/${r.productId}`}
                className="card p-4 flex items-center gap-4 hover:shadow-md hover:border-primary-100 transition-all"
              >
                <ScoreCircle score={r.safetyScore} label={r.scoreLabel} />
                <div className="flex flex-col gap-1 flex-1 min-w-0">
                  <p className="font-semibold text-gray-900 truncate">{r.productName}</p>
                  {r.topBeneficials.length > 0 && (
                    <p className="text-xs text-green-600 truncate">
                      ✓ {r.topBeneficials.join(', ')}
                    </p>
                  )}
                  {r.topRisks.length > 0 && (
                    <p className="text-xs text-red-500 truncate">
                      ⚠ {r.topRisks.join(', ')}
                    </p>
                  )}
                </div>
              </Link>
            ))}
          </div>

          {data.totalPages > 1 && (
            <div className="flex justify-center items-center gap-3">
              <Button variant="outline" disabled={page === 0} onClick={() => setPage(page - 1)}>
                Previous
              </Button>
              <span className="text-sm text-gray-500">
                {page + 1} / {data.totalPages}
              </span>
              <Button variant="outline" disabled={page >= data.totalPages - 1} onClick={() => setPage(page + 1)}>
                Next
              </Button>
            </div>
          )}
        </>
      )}
    </div>
  )
}
