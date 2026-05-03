import { create } from 'zustand'
import { persist } from 'zustand/middleware'

interface AuthState {
  accessToken: string | null
  refreshToken: string | null
  user: { id: number; email: string; role: string } | null
  setTokens: (access: string, refresh: string) => void
  setUser: (user: { id: number; email: string; role: string }) => void
  logout: () => void
  isAuthenticated: () => boolean
  isAdmin: () => boolean
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set, get) => ({
      accessToken: null,
      refreshToken: null,
      user: null,

      setTokens: (access, refresh) =>
        set({ accessToken: access, refreshToken: refresh }),

      setUser: (user) => set({ user }),

      logout: () =>
        set({ accessToken: null, refreshToken: null, user: null }),

      isAuthenticated: () => !!get().accessToken,

      isAdmin: () => get().user?.role === 'ADMIN',
    }),
    {
      name: 'skinsight-auth',
      // Only persist refresh token and user (access token is short-lived)
      partialize: (state) => ({
        refreshToken: state.refreshToken,
        user: state.user,
      }),
    }
  )
)
