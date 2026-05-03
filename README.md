# SkinSight

Web-based cosmetic ingredient analysis system.

## Quick Start

### 1. Start PostgreSQL
```bash
docker-compose up postgres -d
```

### 2. Backend
```bash
cd backend
mvn spring-boot:run
```
Starts on http://localhost:8081
Flyway runs migrations automatically — creates all tables and seeds 30 ingredients + 5 products.

### 3. Frontend
```bash
cd frontend
npm install
npm run dev
```
Starts on http://localhost:5173

---

## Features

- **Authentication** — register / login / logout with JWT
- **User profile** — skin type, skin conditions, personal allergens
- **Product search** — search and filter by category
- **Ingredient analysis** — rule-based safety score (0–100) personalized to your skin type
- **Compatibility checker** — detects conflicting ingredient pairs between products
- **Favorites & history** — save products, view past analyses

## Project Structure

```
skinsight/
├── docker-compose.yml
├── backend/                    Spring Boot 3 / Java 17
│   └── src/main/java/com/skinsight/
│       ├── auth/               JWT auth (register, login, refresh, logout)
│       ├── user/               Profile, favorites
│       ├── product/            Search, detail
│       ├── ingredient/         Ingredient database
│       ├── analysis/           Rule engine + history
│       ├── compatibility/      Conflict checker
│       ├── admin/              Product/ingredient CRUD (ADMIN role)
│       └── common/             Security, error handling
└── frontend/                   React 18 / TypeScript / Tailwind CSS
    └── src/
        ├── pages/              Landing, Auth, Products, Profile, Dashboard, Compatibility
        ├── components/         UI primitives, AnalysisPanel
        ├── hooks/              useAuth, useProducts, useAnalysis, useCompatibility
        ├── api/                Axios API layer
        └── store/              Zustand auth store
```

## API Endpoints

| Method | Endpoint                      | Auth  | Description                  |
|--------|-------------------------------|-------|------------------------------|
| POST   | /api/auth/register            | —     | Register                     |
| POST   | /api/auth/login               | —     | Login → JWT pair             |
| POST   | /api/auth/refresh             | —     | Refresh access token         |
| POST   | /api/auth/logout              | ✓     | Logout                       |
| GET    | /api/users/me                 | ✓     | Get profile                  |
| PUT    | /api/users/me/profile         | ✓     | Update skin type / allergens |
| GET    | /api/users/me/favorites       | ✓     | Favorites list               |
| POST   | /api/users/me/favorites/{id}  | ✓     | Add favorite                 |
| DELETE | /api/users/me/favorites/{id}  | ✓     | Remove favorite              |
| GET    | /api/products                 | —     | Search products              |
| GET    | /api/products/{id}            | —     | Product detail               |
| POST   | /api/analysis/{productId}     | ✓     | Analyze product              |
| GET    | /api/analysis/history         | ✓     | Analysis history             |
| POST   | /api/compatibility/check      | ✓     | Check compatibility          |
| POST   | /api/admin/products           | ADMIN | Create product               |
| PUT    | /api/admin/products/{id}      | ADMIN | Update product               |
| POST   | /api/admin/ingredients        | ADMIN | Create ingredient            |
| PUT    | /api/admin/ingredients/{id}   | ADMIN | Update ingredient            |

## Notes

- First user gets `USER` role. To make an admin: `UPDATE users SET role='ADMIN' WHERE email='...'`
- Flyway seed includes 30 ingredients with skin-type flags and 5 sample interaction rules
