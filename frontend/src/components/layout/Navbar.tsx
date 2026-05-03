import { Link, NavLink, useNavigate } from 'react-router-dom'
import { Leaf, User, LogOut, Menu, X } from 'lucide-react'
import { useState } from 'react'
import { useAuth } from '@/hooks/useAuth'
import { clsx } from 'clsx'

export function Navbar() {
  const { user, isAuthenticated, logout } = useAuth()
  const [open, setOpen] = useState(false)

  const linkCls = ({ isActive }: { isActive: boolean }) =>
    clsx('text-sm font-medium transition-colors',
      isActive ? 'text-primary-700' : 'text-gray-600 hover:text-primary-600')

  return (
    <header className="sticky top-0 z-40 bg-white border-b border-gray-100 shadow-sm">
      <div className="max-w-6xl mx-auto px-4 h-14 flex items-center justify-between gap-4">
        <Link to="/" className="flex items-center gap-2 font-bold text-primary-700">
          <Leaf className="w-5 h-5" /> SkinSight
        </Link>

        <nav className="hidden md:flex items-center gap-6">
          <NavLink to="/products" className={linkCls}>Products</NavLink>
          {isAuthenticated() && (
            <>
              <NavLink to="/dashboard" className={linkCls}>Dashboard</NavLink>
              <NavLink to="/compatibility" className={linkCls}>Compatibility</NavLink>
            </>
          )}
        </nav>

        <div className="hidden md:flex items-center gap-2">
          {isAuthenticated() ? (
            <>
              <NavLink to="/profile" className={linkCls}>
                <div className="flex items-center gap-1.5">
                  <User className="w-4 h-4" />
                  <span className="text-sm">{user?.email.split('@')[0]}</span>
                </div>
              </NavLink>
              <button onClick={() => logout.mutate()}
                className="btn-ghost text-sm flex items-center gap-1.5 text-gray-500">
                <LogOut className="w-4 h-4" /> Logout
              </button>
            </>
          ) : (
            <>
              <Link to="/login" className="btn-outline text-sm px-3 py-1.5">Login</Link>
              <Link to="/register" className="btn-primary text-sm px-3 py-1.5">Sign up</Link>
            </>
          )}
        </div>

        <button className="md:hidden btn-ghost p-1" onClick={() => setOpen(!open)}>
          {open ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
        </button>
      </div>

      {open && (
        <div className="md:hidden border-t border-gray-100 bg-white px-4 py-3 flex flex-col gap-3">
          <NavLink to="/products" className={linkCls} onClick={() => setOpen(false)}>Products</NavLink>
          {isAuthenticated() && (
            <>
              <NavLink to="/dashboard" className={linkCls} onClick={() => setOpen(false)}>Dashboard</NavLink>
              <NavLink to="/profile" className={linkCls} onClick={() => setOpen(false)}>Profile</NavLink>
              <NavLink to="/compatibility" className={linkCls} onClick={() => setOpen(false)}>Compatibility</NavLink>
            </>
          )}
          {!isAuthenticated() && (
            <div className="flex gap-2 pt-1">
              <Link to="/login" className="btn-outline flex-1 text-center py-1.5" onClick={() => setOpen(false)}>Login</Link>
              <Link to="/register" className="btn-primary flex-1 text-center py-1.5" onClick={() => setOpen(false)}>Sign up</Link>
            </div>
          )}
        </div>
      )}
    </header>
  )
}
