import { useEffect, useState } from 'react'
import { User, Save, X, Plus } from 'lucide-react'
import { useProfile } from '@/hooks/useAuth'
import { userApi } from '@/api'
import { useQueryClient } from '@tanstack/react-query'
import { Button, Card, Spinner } from '@/components/ui'
import type { SkinType } from '@/types'
import { clsx } from 'clsx'

const SKIN_TYPES: { value: SkinType; label: string; desc: string; color: string }[] = [
  { value: 'NORMAL',      label: 'Normal',      desc: 'Balanced, not too oily or dry',  color: 'bg-skin-normal border-green-200' },
  { value: 'OILY',        label: 'Oily',        desc: 'Shiny, enlarged pores',           color: 'bg-skin-oily border-yellow-200' },
  { value: 'DRY',         label: 'Dry',         desc: 'Tight, flaky, rough texture',     color: 'bg-skin-dry border-blue-200' },
  { value: 'COMBINATION', label: 'Combination', desc: 'Oily T-zone, dry cheeks',         color: 'bg-skin-combination border-lime-200' },
  { value: 'SENSITIVE',   label: 'Sensitive',   desc: 'Easily irritated, prone to redness', color: 'bg-skin-sensitive border-red-200' },
]

const CONDITIONS = ['acne-prone', 'rosacea', 'eczema', 'hyperpigmentation', 'dehydrated', 'aging']

export function ProfilePage() {
  const qc = useQueryClient()
  const { data: profile, isLoading } = useProfile()

  const [skinType, setSkinType] = useState<SkinType | null>(null)
  const [conditions, setConditions] = useState<string[]>([])
  const [allergens, setAllergens] = useState<string[]>([])
  const [newAllergen, setNewAllergen] = useState('')
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)

  useEffect(() => {
    if (profile) {
      setSkinType(profile.skinType)
      setConditions(profile.skinConditions ?? [])
      setAllergens(profile.allergens ?? [])
    }
  }, [profile])

  const toggleCondition = (c: string) =>
    setConditions((prev) => prev.includes(c) ? prev.filter((x) => x !== c) : [...prev, c])

  const addAllergen = () => {
    const val = newAllergen.trim().toUpperCase()
    if (val && !allergens.includes(val)) {
      setAllergens((prev) => [...prev, val])
    }
    setNewAllergen('')
  }

  const save = async () => {
    setSaving(true)
    await userApi.updateProfile({ skinType: skinType ?? undefined, skinConditions: conditions, allergens })
    qc.invalidateQueries({ queryKey: ['profile'] })
    setSaving(false)
    setSaved(true)
    setTimeout(() => setSaved(false), 2000)
  }

  if (isLoading) return <div className="flex justify-center py-20"><Spinner className="w-8 h-8" /></div>

  return (
    <div className="flex flex-col gap-6 max-w-2xl">
      <div className="flex items-center gap-3">
        <div className="w-10 h-10 rounded-full bg-primary-100 flex items-center justify-center">
          <User className="w-5 h-5 text-primary-600" />
        </div>
        <div>
          <h1 className="text-xl font-bold text-gray-900">Your profile</h1>
          <p className="text-sm text-gray-500">{profile?.email}</p>
        </div>
      </div>

      {/* Skin type */}
      <Card>
        <h2 className="font-semibold text-gray-900 mb-4">Skin type</h2>
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
          {SKIN_TYPES.map((st) => (
            <button
              key={st.value}
              onClick={() => setSkinType(st.value)}
              className={clsx(
                'p-3 rounded-xl border-2 text-left transition-all',
                st.color,
                skinType === st.value ? 'border-primary-500 ring-2 ring-primary-200' : 'hover:border-gray-300'
              )}
            >
              <p className="font-medium text-sm text-gray-900">{st.label}</p>
              <p className="text-xs text-gray-500 mt-0.5">{st.desc}</p>
            </button>
          ))}
        </div>
      </Card>

      {/* Skin conditions */}
      <Card>
        <h2 className="font-semibold text-gray-900 mb-4">Skin conditions</h2>
        <div className="flex flex-wrap gap-2">
          {CONDITIONS.map((c) => (
            <button
              key={c}
              onClick={() => toggleCondition(c)}
              className={clsx(
                'px-3 py-1.5 rounded-full text-sm font-medium border transition-all',
                conditions.includes(c)
                  ? 'bg-primary-600 text-white border-primary-600'
                  : 'bg-white text-gray-600 border-gray-200 hover:border-primary-300'
              )}
            >
              {c}
            </button>
          ))}
        </div>
      </Card>

      {/* Allergens */}
      <Card>
        <h2 className="font-semibold text-gray-900 mb-1">Personal allergens</h2>
        <p className="text-xs text-gray-500 mb-4">
          Ingredients you know you react to. These will always be flagged as AVOID.
        </p>
        <div className="flex flex-wrap gap-2 mb-3">
          {allergens.map((a) => (
            <span key={a} className="flex items-center gap-1 bg-red-50 text-red-700 border border-red-200 px-2.5 py-1 rounded-full text-xs font-medium">
              {a}
              <button onClick={() => setAllergens((prev) => prev.filter((x) => x !== a))}>
                <X className="w-3 h-3 hover:text-red-900" />
              </button>
            </span>
          ))}
        </div>
        <div className="flex gap-2">
          <input
            value={newAllergen}
            onChange={(e) => setNewAllergen(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && addAllergen()}
            placeholder="e.g. FRAGRANCE, ALCOHOL DENAT."
            className="input text-sm flex-1"
          />
          <Button variant="outline" onClick={addAllergen} className="gap-1 shrink-0">
            <Plus className="w-4 h-4" /> Add
          </Button>
        </div>
      </Card>

      {/* Save */}
      <div className="flex items-center gap-3">
        <Button onClick={save} loading={saving} className="gap-2">
          <Save className="w-4 h-4" /> Save profile
        </Button>
        {saved && <p className="text-sm text-green-600 font-medium">✓ Saved!</p>}
      </div>
    </div>
  )
}
