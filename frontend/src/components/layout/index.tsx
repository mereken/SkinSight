import { Outlet, Navigate } from 'react-router-dom'
import { Navbar } from './Navbar'
import { useAuthStore } from '@/store/authStore'

export function MainLayout() {
  return (
    <div className="min-h-screen flex flex-col">
      <Navbar />
      <main className="flex-1 max-w-6xl mx-auto w-full px-4 py-6">
        <Outlet />
      </main>
      <footer className="border-t border-gray-100 py-4 text-center text-xs text-gray-400">
        SkinSight © 2026 · Not medical advice. Always consult a dermatologist.
      </footer>
    </div>
  )
}

export function ProtectedRoute() {
  const isAuthenticated = useAuthStore((s) => s.isAuthenticated())
  return isAuthenticated ? <Outlet /> : <Navigate to="/login" replace />
}

export function AuthLayout() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-white flex items-center justify-center p-4">
      <div className="w-full max-w-sm">
        <div className="text-center mb-6">
          <h1 className="text-2xl font-bold text-primary-700">SkinSight</h1>
          <p className="text-sm text-gray-500 mt-1">Know your ingredients</p>
        </div>
        <Outlet />
      </div>
    </div>
  )
}
