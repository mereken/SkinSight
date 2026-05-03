import { Link } from 'react-router-dom'
import { FlaskConical, GitCompare, Heart, Clock, ChevronRight } from 'lucide-react'
import { useProfile, useFavorites } from '@/hooks/useAuth'
import { useAnalysisHistory } from '@/hooks/useProducts'
import { Card, ScoreCircle, Spinner } from '@/components/ui'

export function DashboardPage() {
  const { data: profile } = useProfile()
  const { data: favorites, isLoading: favLoading } = useFavorites()
  const { data: history, isLoading: histLoading } = useAnalysisHistory(0)

  const recentHistory = history?.content.slice(0, 3) ?? []
  const recentFavs = favorites?.slice(0, 4) ?? []

  return (
    <div className="flex flex-col gap-6">
      {/* Welcome */}
      <div>
        <h1 className="text-2xl font-bold text-gray-900">
          Welcome back{profile?.email ? `, ${profile.email.split('@')[0]}` : ''}
        </h1>
        <p className="text-sm text-gray-500 mt-1">
          {profile?.skinType
            ? `Skin type: ${profile.skinType.toLowerCase()}`
            : 'Set your skin type in your profile for personalized analysis.'}
        </p>
        {!profile?.skinType && (
          <Link to="/profile" className="text-sm text-primary-600 font-medium hover:underline mt-1 inline-block">
            Set skin type →
          </Link>
        )}
      </div>

      {/* Quick actions */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        {[
          { to: '/products', icon: <FlaskConical className="w-5 h-5" />, label: 'Analyze a product', desc: 'Search and analyze ingredients' },
          { to: '/compatibility', icon: <GitCompare className="w-5 h-5" />, label: 'Check compatibility', desc: 'Compare two products' },
          { to: '/profile', icon: <Heart className="w-5 h-5" />, label: 'Update profile', desc: 'Skin type & allergens' },
        ].map((a) => (
          <Link key={a.to} to={a.to} className="card p-4 flex items-center gap-3 hover:shadow-md hover:border-primary-100 transition-all group">
            <div className="w-10 h-10 rounded-lg bg-primary-50 text-primary-600 flex items-center justify-center shrink-0">
              {a.icon}
            </div>
            <div className="flex flex-col gap-0.5 flex-1 min-w-0">
              <p className="text-sm font-semibold text-gray-900 group-hover:text-primary-700 transition-colors">{a.label}</p>
              <p className="text-xs text-gray-500">{a.desc}</p>
            </div>
            <ChevronRight className="w-4 h-4 text-gray-300 group-hover:text-primary-400 transition-colors shrink-0" />
          </Link>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Recent analyses */}
        <Card>
          <div className="flex items-center justify-between mb-4">
            <h2 className="font-semibold text-gray-900 flex items-center gap-2">
              <Clock className="w-4 h-4 text-primary-500" /> Recent analyses
            </h2>
            <Link to="/history" className="text-xs text-primary-600 hover:underline">See all</Link>
          </div>
          {histLoading ? (
            <div className="flex justify-center py-6"><Spinner className="w-5 h-5" /></div>
          ) : recentHistory.length === 0 ? (
            <p className="text-sm text-gray-400 text-center py-6">No analyses yet. Try analyzing a product!</p>
          ) : (
            <div className="flex flex-col gap-3">
              {recentHistory.map((r) => (
                <Link
                  key={r.productId}
                  to={`/products/${r.productId}`}
                  className="flex items-center gap-3 p-3 rounded-lg hover:bg-gray-50 transition-colors"
                >
                  <ScoreCircle score={r.safetyScore} label={r.scoreLabel} />
                  <div className="flex flex-col gap-0.5 min-w-0 flex-1">
                    <p className="text-sm font-medium text-gray-900 truncate">{r.productName}</p>
                    {r.topRisks.length > 0 && (
                      <p className="text-xs text-red-500 truncate">⚠ {r.topRisks.join(', ')}</p>
                    )}
                  </div>
                </Link>
              ))}
            </div>
          )}
        </Card>

        {/* Favorites */}
        <Card>
          <div className="flex items-center justify-between mb-4">
            <h2 className="font-semibold text-gray-900 flex items-center gap-2">
              <Heart className="w-4 h-4 text-primary-500" /> Favorites
            </h2>
          </div>
          {favLoading ? (
            <div className="flex justify-center py-6"><Spinner className="w-5 h-5" /></div>
          ) : recentFavs.length === 0 ? (
            <p className="text-sm text-gray-400 text-center py-6">
              No favorites yet.{' '}
              <Link to="/products" className="text-primary-600 hover:underline">Browse products</Link>
            </p>
          ) : (
            <div className="flex flex-col gap-2">
              {recentFavs.map((p) => (
                <Link
                  key={p.id}
                  to={`/products/${p.id}`}
                  className="flex items-center gap-3 p-3 rounded-lg hover:bg-gray-50 transition-colors"
                >
                  <div className="w-8 h-8 rounded-lg bg-primary-50 flex items-center justify-center shrink-0 text-primary-400 text-xs font-bold">
                    {p.name[0]}
                  </div>
                  <div className="flex flex-col gap-0.5 min-w-0 flex-1">
                    <p className="text-sm font-medium text-gray-900 truncate">{p.name}</p>
                    {p.brand && <p className="text-xs text-gray-400">{p.brand}</p>}
                  </div>
                </Link>
              ))}
            </div>
          )}
        </Card>
      </div>
    </div>
  )
}
