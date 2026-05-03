import { Routes, Route, Navigate } from 'react-router-dom'
import { MainLayout, AuthLayout, ProtectedRoute } from '@/components/layout'
import { LoginPage } from '@/pages/auth/LoginPage'
import { RegisterPage } from '@/pages/auth/RegisterPage'
import { LandingPage } from '@/pages/LandingPage'
import { DashboardPage } from '@/pages/dashboard/DashboardPage'
import { ProductsPage } from '@/pages/products/ProductsPage'
import { ProductDetailPage } from '@/pages/products/ProductDetailPage'
import { ProfilePage } from '@/pages/profile/ProfilePage'
import { CompatibilityPage } from '@/pages/compatibility/CompatibilityPage'
import { HistoryPage } from '@/pages/dashboard/HistoryPage'

export default function App() {
  return (
    <Routes>
      <Route element={<AuthLayout />}>
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />
      </Route>

      <Route element={<MainLayout />}>
        <Route path="/" element={<LandingPage />} />
        <Route path="/products" element={<ProductsPage />} />
        <Route path="/products/:id" element={<ProductDetailPage />} />

        <Route element={<ProtectedRoute />}>
          <Route path="/dashboard" element={<DashboardPage />} />
          <Route path="/history" element={<HistoryPage />} />
          <Route path="/profile" element={<ProfilePage />} />
          <Route path="/compatibility" element={<CompatibilityPage />} />
        </Route>

        <Route path="*" element={<Navigate to="/" replace />} />
      </Route>
    </Routes>
  )
}
