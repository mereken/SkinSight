import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { useNavigate } from 'react-router-dom'
import { authApi, userApi } from '@/api'
import { useAuthStore } from '@/store/authStore'

export function useAuth() {
  const { setTokens, setUser, logout: storeLogout, user, isAuthenticated, isAdmin } = useAuthStore()
  const navigate = useNavigate()
  const qc = useQueryClient()

  const register = useMutation({
    mutationFn: ({ email, password }: { email: string; password: string }) =>
      authApi.register(email, password),
    onSuccess: ({ data }) => {
      setTokens(data.data.accessToken, data.data.refreshToken)
      setUser(data.data.user)
      navigate('/dashboard')
    },
  })

  const login = useMutation({
    mutationFn: ({ email, password }: { email: string; password: string }) =>
      authApi.login(email, password),
    onSuccess: ({ data }) => {
      setTokens(data.data.accessToken, data.data.refreshToken)
      setUser(data.data.user)
      navigate('/dashboard')
    },
  })

  const logout = useMutation({
    mutationFn: () => authApi.logout(),
    onSettled: () => {
      storeLogout()
      qc.clear()
      navigate('/login')
    },
  })

  return { register, login, logout, user, isAuthenticated, isAdmin }
}

export function useProfile() {
  return useQuery({
    queryKey: ['profile'],
    queryFn: () => userApi.getMe().then((r) => r.data.data),
    enabled: useAuthStore.getState().isAuthenticated(),
  })
}

export function useFavorites() {
  return useQuery({
    queryKey: ['favorites'],
    queryFn: () => userApi.getFavorites().then((r) => r.data.data),
  })
}
