import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'
import { Link } from 'react-router-dom'
import { useAuth } from '@/hooks/useAuth'
import { Button, Card, Input } from '@/components/ui'

const schema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(1, 'Required'),
})
type Form = z.infer<typeof schema>

export function LoginPage() {
  const { login } = useAuth()
  const { register, handleSubmit, formState: { errors } } = useForm<Form>({
    resolver: zodResolver(schema),
  })

  const onSubmit = (data: Form) => login.mutate(data)

  return (
    <Card>
      <h2 className="text-lg font-semibold text-gray-900 mb-4">Sign in</h2>
      <form onSubmit={handleSubmit(onSubmit)} className="flex flex-col gap-4">
        <Input label="Email" type="email" placeholder="you@example.com"
          error={errors.email?.message} {...register('email')} />
        <Input label="Password" type="password" placeholder="••••••"
          error={errors.password?.message} {...register('password')} />

        {login.error && (
          <p className="text-sm text-red-600 bg-red-50 rounded-lg px-3 py-2">
            Invalid email or password
          </p>
        )}

        <Button type="submit" loading={login.isPending} className="w-full mt-1">
          Sign in
        </Button>
      </form>
      <p className="mt-4 text-center text-sm text-gray-500">
        No account?{' '}
        <Link to="/register" className="text-primary-600 font-medium hover:underline">
          Sign up
        </Link>
      </p>
    </Card>
  )
}
