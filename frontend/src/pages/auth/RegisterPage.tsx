import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'
import { Link } from 'react-router-dom'
import { useAuth } from '@/hooks/useAuth'
import { Button, Card, Input } from '@/components/ui'

const schema = z.object({
  email: z.string().email('Invalid email'),
  password: z.string().min(6, 'At least 6 characters'),
  confirm: z.string(),
}).refine((d) => d.password === d.confirm, {
  message: "Passwords don't match",
  path: ['confirm'],
})
type Form = z.infer<typeof schema>

export function RegisterPage() {
  const { register: registerAuth } = useAuth()
  const { register, handleSubmit, formState: { errors } } = useForm<Form>({
    resolver: zodResolver(schema),
  })

  const onSubmit = ({ email, password }: Form) =>
    registerAuth.mutate({ email, password })

  return (
    <Card>
      <h2 className="text-lg font-semibold text-gray-900 mb-4">Create account</h2>
      <form onSubmit={handleSubmit(onSubmit)} className="flex flex-col gap-4">
        <Input label="Email" type="email" placeholder="you@example.com"
          error={errors.email?.message} {...register('email')} />
        <Input label="Password" type="password" placeholder="••••••"
          error={errors.password?.message} {...register('password')} />
        <Input label="Confirm password" type="password" placeholder="••••••"
          error={errors.confirm?.message} {...register('confirm')} />

        {registerAuth.error && (
          <p className="text-sm text-red-600 bg-red-50 rounded-lg px-3 py-2">
            Email already in use
          </p>
        )}

        <Button type="submit" loading={registerAuth.isPending} className="w-full mt-1">
          Create account
        </Button>
      </form>
      <p className="mt-4 text-center text-sm text-gray-500">
        Already have an account?{' '}
        <Link to="/login" className="text-primary-600 font-medium hover:underline">
          Sign in
        </Link>
      </p>
    </Card>
  )
}
