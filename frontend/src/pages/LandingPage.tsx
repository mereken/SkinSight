import { Link } from 'react-router-dom'
import { Leaf, ShieldCheck, GitCompare, ChevronRight } from 'lucide-react'

const features = [
  {
    icon: <ShieldCheck className="w-6 h-6 text-primary-600" />,
    title: 'Ingredient Analysis',
    desc: 'Every ingredient evaluated against your skin type. Get a safety score and plain-English explanation for each flag.',
  },
  {
    icon: <GitCompare className="w-6 h-6 text-primary-600" />,
    title: 'Compatibility Checker',
    desc: 'Select two or more products and instantly see if their ingredients conflict — before you damage your skin.',
  },

]

const stats = [
  { value: '76%', label: 'of users find ingredient lists hard to read' },
  { value: '30+', label: 'ingredients in our database' },
  { value: '4.29/5', label: 'demand score for compatibility checking' },
]

export function LandingPage() {
  return (
    <div className="flex flex-col gap-20 py-8">
      {/* Hero */}
      <section className="text-center flex flex-col items-center gap-6">
        <div className="inline-flex items-center gap-2 bg-primary-50 text-primary-700 text-sm font-medium px-4 py-1.5 rounded-full">
          <Leaf className="w-4 h-4" /> Know what's on your skin
        </div>
        <h1 className="text-4xl md:text-5xl font-bold text-gray-900 max-w-2xl leading-tight">
          Decode your skincare <span className="text-primary-600">ingredients</span> in seconds
        </h1>
        <p className="text-gray-500 max-w-lg text-lg">
          SkinSight analyzes cosmetic ingredient lists, flags risks for your skin type,
          checks product compatibility, and explains everything in plain language.
        </p>
        <div className="flex gap-3 flex-wrap justify-center">
          <Link to="/register" className="btn-primary px-6 py-2.5 text-base gap-1.5">
            Get started free <ChevronRight className="w-4 h-4" />
          </Link>
          <Link to="/products" className="btn-outline px-6 py-2.5 text-base">
            Browse products
          </Link>
        </div>
      </section>

      {/* Stats */}
      <section className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        {stats.map((s) => (
          <div key={s.value} className="card p-6 text-center">
            <p className="text-3xl font-bold text-primary-600">{s.value}</p>
            <p className="text-sm text-gray-500 mt-1">{s.label}</p>
          </div>
        ))}
      </section>

      {/* Features */}
      <section className="flex flex-col gap-4">
        <h2 className="text-2xl font-bold text-gray-900 text-center">Everything you need</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5 mt-2">
          {features.map((f) => (
            <div key={f.title} className="card p-6 flex flex-col gap-3">
              <div className="w-10 h-10 rounded-lg bg-primary-50 flex items-center justify-center">
                {f.icon}
              </div>
              <h3 className="font-semibold text-gray-900">{f.title}</h3>
              <p className="text-sm text-gray-500 leading-relaxed">{f.desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* CTA */}
      <section className="bg-primary-900 rounded-2xl p-10 text-center text-white flex flex-col items-center gap-4">
        <h2 className="text-2xl font-bold">Ready to understand your skincare?</h2>
        <p className="text-primary-200 text-sm max-w-md">
          Create a free account, set your skin type, and start analyzing products immediately.
        </p>
        <Link to="/register" className="bg-white text-primary-700 font-semibold px-6 py-2.5 rounded-lg hover:bg-primary-50 transition">
          Create free account
        </Link>
      </section>
    </div>
  )
}
