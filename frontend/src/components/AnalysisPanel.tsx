import { ShieldCheck, TrendingUp, AlertTriangle } from 'lucide-react'
import type { AnalysisResult, FlagType } from '@/types'
import { Badge, ScoreCircle } from '@/components/ui'

const FLAG_LABEL: Record<FlagType, string> = {
  BENEFICIAL: 'Beneficial',
  NEUTRAL: 'Neutral',
  CAUTION: 'Caution',
  AVOID: 'Avoid',
}

export function AnalysisPanel({ result }: { result: AnalysisResult }) {
  const flagged = result.flaggedIngredients.filter((f) => f.flag !== 'NEUTRAL')

  return (
    <div className="flex flex-col gap-5">
      {/* Score */}
      <div className="flex flex-col sm:flex-row items-center gap-6 p-5 bg-gray-50 rounded-xl">
        <ScoreCircle score={result.safetyScore} label={result.scoreLabel} />
        <div className="flex flex-col gap-3 flex-1">
          {result.topBeneficials.length > 0 && (
            <div>
              <p className="text-xs font-semibold text-green-700 uppercase tracking-wide mb-1.5 flex items-center gap-1">
                <TrendingUp className="w-3.5 h-3.5" /> Key actives
              </p>
              <div className="flex flex-wrap gap-1.5">
                {result.topBeneficials.map((name) => (
                  <span key={name} className="badge-beneficial">{name}</span>
                ))}
              </div>
            </div>
          )}
          {result.topRisks.length > 0 && (
            <div>
              <p className="text-xs font-semibold text-red-700 uppercase tracking-wide mb-1.5 flex items-center gap-1">
                <AlertTriangle className="w-3.5 h-3.5" /> Watch out for
              </p>
              <div className="flex flex-wrap gap-1.5">
                {result.topRisks.map((name) => (
                  <span key={name} className="badge-avoid">{name}</span>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Flagged ingredient list */}
      {flagged.length > 0 && (
        <div className="flex flex-col gap-2">
          <h4 className="text-sm font-semibold text-gray-700 flex items-center gap-1.5">
            <ShieldCheck className="w-4 h-4 text-primary-500" /> Ingredient breakdown
          </h4>
          <div className="flex flex-col gap-2">
            {flagged.map((fi) => (
              <div
                key={fi.ingredientId}
                className="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white"
              >
                <Badge variant={fi.flag.toLowerCase() as any}>
                  {FLAG_LABEL[fi.flag]}
                </Badge>
                <div className="flex flex-col gap-0.5 min-w-0">
                  <p className="text-sm font-medium text-gray-900">
                    {fi.commonName ?? fi.inciName}
                  </p>
                  <p className="text-xs text-gray-500">{fi.explanation}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
