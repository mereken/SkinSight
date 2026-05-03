import { clsx } from 'clsx'
import { Loader2 } from 'lucide-react'
import type { ButtonHTMLAttributes, InputHTMLAttributes, ReactNode } from 'react'

// ── Button ────────────────────────────────────────────────────────────────────
interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'outline' | 'ghost' | 'danger'
  loading?: boolean
  children: ReactNode
}
export function Button({ variant = 'primary', loading, children, className, disabled, ...props }: ButtonProps) {
  const cls = {
    primary: 'btn-primary',
    outline: 'btn-outline',
    ghost:   'btn-ghost',
    danger:  'btn-danger',
  }[variant]
  return (
    <button className={clsx(cls, className)} disabled={disabled || loading} {...props}>
      {loading && <Loader2 className="w-4 h-4 animate-spin" />}
      {children}
    </button>
  )
}

// // ── Input ─────────────────────────────────────────────────────────────────────
// interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
//   label?: string
//   error?: string
// }
// export function Input({ label, error, className, ...props }: InputProps) {
//   return (
//     <div className="flex flex-col gap-1">
//       {label && <label className="text-sm font-medium text-gray-700">{label}</label>}
//       <input className={clsx('input', error && 'border-red-400 focus:border-red-400 focus:ring-red-400', className)} {...props} />
//       {error && <p className="text-xs text-red-600">{error}</p>}
//     </div>
//   )
// }

// ── Input ─────────────────────────────────────────────────────────────────────
import React, { forwardRef } from 'react';

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string
  error?: string
}

// Оборачиваем в forwardRef и принимаем ref вторым аргументом
export const Input = forwardRef<HTMLInputElement, InputProps>(
  ({ label, error, className, ...props }, ref) => {
    return (
      <div className="flex flex-col gap-1">
        {label && <label className="text-sm font-medium text-gray-700">{label}</label>}
        <input
          ref={ref} // ПРОКИДЫВАЕМ REF СЮДА
          className={clsx('input', error && 'border-red-400 focus:border-red-400 focus:ring-red-400', className)}
          {...props}
        />
        {error && <p className="text-xs text-red-600">{error}</p>}
      </div>
    )
  }
)
Input.displayName = 'Input'


// ── Card ──────────────────────────────────────────────────────────────────────
export function Card({ children, className }: { children: ReactNode; className?: string }) {
  return <div className={clsx('card p-5', className)}>{children}</div>
}

// ── Badge ─────────────────────────────────────────────────────────────────────
type BadgeVariant = 'beneficial' | 'caution' | 'avoid' | 'neutral'
export function Badge({ variant, children }: { variant: BadgeVariant; children: ReactNode }) {
  return <span className={`badge-${variant}`}>{children}</span>
}

// ── Score Circle ──────────────────────────────────────────────────────────────
export function ScoreCircle({ score, label }: { score: number; label: string }) {
  const color =
    score >= 80 ? 'text-green-600 stroke-green-500' :
    score >= 60 ? 'text-blue-600 stroke-blue-500' :
    score >= 40 ? 'text-amber-600 stroke-amber-500' :
                  'text-red-600 stroke-red-500'
  const r = 36
  const circ = 2 * Math.PI * r
  const dash = (score / 100) * circ

  return (
    <div className="flex flex-col items-center gap-1">
      <div className="relative w-24 h-24">
        <svg className="w-full h-full -rotate-90" viewBox="0 0 96 96">
          <circle cx="48" cy="48" r={r} fill="none" stroke="#e5e7eb" strokeWidth="8" />
          <circle cx="48" cy="48" r={r} fill="none" strokeWidth="8"
            className={color}
            strokeDasharray={`${dash} ${circ}`}
            strokeLinecap="round" />
        </svg>
        <div className="absolute inset-0 flex flex-col items-center justify-center">
          <span className={clsx('text-xl font-bold', color.split(' ')[0])}>{score}</span>
        </div>
      </div>
      <span className={clsx('text-sm font-semibold', color.split(' ')[0])}>{label}</span>
    </div>
  )
}

// ── Spinner ───────────────────────────────────────────────────────────────────
export function Spinner({ className }: { className?: string }) {
  return <Loader2 className={clsx('animate-spin text-primary-600', className)} />
}

// ── Empty state ───────────────────────────────────────────────────────────────
export function Empty({ message }: { message: string }) {
  return (
    <div className="flex flex-col items-center justify-center py-16 text-gray-400">
      <p className="text-sm">{message}</p>
    </div>
  )
}
