// import { useState } from 'react'
// import { Link } from 'react-router-dom'
// import { Search, SlidersHorizontal, Package } from 'lucide-react'
// import { useProducts } from '@/hooks/useProducts'
// import { Button, Empty, Input, Spinner } from '@/components/ui'
//
// const CATEGORIES = ['All', 'MOISTURIZER', 'SERUM', 'CLEANSER', 'EXFOLIANT', 'SUNSCREEN', 'TONER']
//
// export function ProductsPage() {
//   const [q, setQ] = useState('')
//   const [category, setCategory] = useState('')
//   const [page, setPage] = useState(0)
//   const [search, setSearch] = useState('')
//
//   const { data, isLoading } = useProducts({
//     q: search || undefined,
//     category: category || undefined,
//     page,
//   })
//
//   const handleSearch = (e: React.FormEvent) => {
//     e.preventDefault()
//     setSearch(q)
//     setPage(0)
//   }
//
//   return (
//     <div className="flex flex-col gap-6">
//       <div className="flex flex-col sm:flex-row gap-3 items-start sm:items-center justify-between">
//         <h1 className="text-2xl font-bold text-gray-900">Products</h1>
//
//         {/* Search */}
//         <form onSubmit={handleSearch} className="flex gap-2 w-full sm:w-auto">
//           <div className="relative flex-1 sm:w-72">
//             <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
//             <input
//               value={q}
//               onChange={(e) => setQ(e.target.value)}
//               placeholder="Search products..."
//               className="input pl-9"
//             />
//           </div>
//           <Button type="submit" variant="primary">Search</Button>
//         </form>
//       </div>
//
//       {/* Category filters */}
//       <div className="flex gap-2 flex-wrap">
//         {CATEGORIES.map((cat) => {
//           const val = cat === 'All' ? '' : cat
//           return (
//             <button
//               key={cat}
//               onClick={() => { setCategory(val); setPage(0) }}
//               className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
//                 category === val
//                   ? 'bg-primary-600 text-white'
//                   : 'bg-white border border-gray-200 text-gray-600 hover:border-primary-400'
//               }`}
//             >
//               {cat}
//             </button>
//           )
//         })}
//       </div>
//
//       {/* Grid */}
//       {isLoading ? (
//         <div className="flex justify-center py-20"><Spinner className="w-8 h-8" /></div>
//       ) : !data?.content.length ? (
//         <Empty message="No products found. Try a different search." />
//       ) : (
//         <>
//           <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
//             {data.content.map((product) => (
//               <Link
//                 key={product.id}
//                 to={`/products/${product.id}`}
//                 className="card p-5 hover:shadow-md hover:border-primary-100 transition-all group"
//               >
//                 <div className="flex items-start gap-3">
//                   <div className="w-12 h-12 rounded-lg bg-primary-50 flex items-center justify-center shrink-0">
//                     <Package className="w-6 h-6 text-primary-400" />
//                   </div>
//                   <div className="flex flex-col gap-1 min-w-0">
//                     <h3 className="font-semibold text-gray-900 group-hover:text-primary-700 truncate transition-colors">
//                       {product.name}
//                     </h3>
//                     {product.brand && (
//                       <p className="text-sm text-gray-500">{product.brand}</p>
//                     )}
//                     {product.category && (
//                       <span className="self-start text-xs bg-primary-50 text-primary-600 px-2 py-0.5 rounded-full font-medium">
//                         {product.category}
//                       </span>
//                     )}
//                   </div>
//                 </div>
//               </Link>
//             ))}
//           </div>
//
//           {/* Pagination */}
//           {data.totalPages > 1 && (
//             <div className="flex justify-center items-center gap-3 mt-2">
//               <Button variant="outline" disabled={page === 0} onClick={() => setPage(page - 1)}>
//                 Previous
//               </Button>
//               <span className="text-sm text-gray-500">
//                 Page {page + 1} of {data.totalPages}
//               </span>
//               <Button variant="outline" disabled={page >= data.totalPages - 1} onClick={() => setPage(page + 1)}>
//                 Next
//               </Button>
//             </div>
//           )}
//         </>
//       )}
//     </div>
//   )
// }






import { useState, useEffect } from 'react'
import { Link, useSearchParams } from 'react-router-dom' // <-- Добавили useSearchParams
import { Search, Package } from 'lucide-react'
import { useProducts } from '@/hooks/useProducts'
import { Button, Empty, Spinner } from '@/components/ui'

const CATEGORIES = ['All', 'MOISTURIZER', 'SERUM', 'CLEANSER', 'EXFOLIANT', 'SUNSCREEN', 'TONER']

export function ProductsPage() {
  // 1. Подключаем работу с параметрами URL
  const [searchParams, setSearchParams] = useSearchParams()

  // 2. Читаем значения прямо из URL (если их нет, ставим дефолтные)
  const category = searchParams.get('category') || ''
  const page = parseInt(searchParams.get('page') || '0', 10)
  const search = searchParams.get('q') || ''

  // 3. Локальный state нужен только для поля ввода, чтобы мы могли печатать текст
  const [localQ, setLocalQ] = useState(search)

  // Синхронизируем локальный поиск с URL при нажатии "Назад"
  useEffect(() => {
    setLocalQ(search)
  }, [search])

  const { data, isLoading } = useProducts({
    q: search || undefined,
    category: category || undefined,
    page,
  })

  // 4. Функции теперь обновляют не useState, а саму адресную строку!
  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault()
    setSearchParams(prev => {
      if (localQ) prev.set('q', localQ)
      else prev.delete('q')
      prev.set('page', '0') // при новом поиске сбрасываем на 1 страницу
      return prev
    })
  }

  const handleCategoryClick = (val: string) => {
    setSearchParams(prev => {
      if (val) prev.set('category', val)
      else prev.delete('category')
      prev.set('page', '0') // при смене категории сбрасываем на 1 страницу
      return prev
    })
  }

  const handlePageChange = (newPage: number) => {
    setSearchParams(prev => {
      prev.set('page', newPage.toString())
      return prev
    })
  }

  return (
    <div className="flex flex-col gap-6">
      <div className="flex flex-col sm:flex-row gap-3 items-start sm:items-center justify-between">
        <h1 className="text-2xl font-bold text-gray-900">Products</h1>

        {/* Search */}
        <form onSubmit={handleSearch} className="flex gap-2 w-full sm:w-auto">
          <div className="relative flex-1 sm:w-72">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              value={localQ}
              onChange={(e) => setLocalQ(e.target.value)}
              placeholder="Search products..."
              className="input pl-9"
            />
          </div>
          <Button type="submit" variant="primary">Search</Button>
        </form>
      </div>

      {/* Category filters */}
      <div className="flex gap-2 flex-wrap">
        {CATEGORIES.map((cat) => {
          const val = cat === 'All' ? '' : cat
          return (
            <button
              key={cat}
              onClick={() => handleCategoryClick(val)}
              className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
                category === val
                  ? 'bg-primary-600 text-white'
                  : 'bg-white border border-gray-200 text-gray-600 hover:border-primary-400'
              }`}
            >
              {cat}
            </button>
          )
        })}
      </div>

      {/* Grid */}
      {isLoading ? (
        <div className="flex justify-center py-20"><Spinner className="w-8 h-8" /></div>
      ) : !data?.content.length ? (
        <Empty message="No products found. Try a different search." />
      ) : (
        <>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {data.content.map((product) => (
              <Link
                key={product.id}
                to={`/products/${product.id}`}
                className="card p-5 hover:shadow-md hover:border-primary-100 transition-all group"
              >
                <div className="flex items-start gap-3">
                  <div className="w-12 h-12 rounded-lg bg-primary-50 flex items-center justify-center shrink-0">
                    <Package className="w-6 h-6 text-primary-400" />
                  </div>
                  <div className="flex flex-col gap-1 min-w-0">
                    <h3 className="font-semibold text-gray-900 group-hover:text-primary-700 truncate transition-colors">
                      {product.name}
                    </h3>
                    {product.brand && (
                      <p className="text-sm text-gray-500">{product.brand}</p>
                    )}
                    {product.category && (
                      <span className="self-start text-xs bg-primary-50 text-primary-600 px-2 py-0.5 rounded-full font-medium">
                        {product.category}
                      </span>
                    )}
                  </div>
                </div>
              </Link>
            ))}
          </div>

          {/* Pagination */}
          {data.totalPages > 1 && (
            <div className="flex justify-center items-center gap-3 mt-2">
              <Button variant="outline" disabled={page === 0} onClick={() => handlePageChange(page - 1)}>
                Previous
              </Button>
              <span className="text-sm text-gray-500">
                Page {page + 1} of {data.totalPages}
              </span>
              <Button variant="outline" disabled={page >= data.totalPages - 1} onClick={() => handlePageChange(page + 1)}>
                Next
              </Button>
            </div>
          )}
        </>
      )}
    </div>
  )
}