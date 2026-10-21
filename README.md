# SkinSight

Web-based information system for personalized cosmetic ingredient analysis.

Most skincare apps tell you *what* an ingredient is. SkinSight tells you *why it matters for your specific skin* — and whether two products are safe to use together.

## What it does

| Feature | Description |
|---|---|
| Ingredient analysis | Rule-based safety score (0–100) personalized to your skin type and allergens |
| Compatibility checker | Detects conflicting ingredient pairs across 2–4 products (e.g. Retinol + Salicylic Acid) |
| Explainable output | Every flagged ingredient gets a plain-language explanation referencing your skin profile |
| User profile | Stores skin type, conditions (acne-prone, rosacea, eczema, hyperpigmentation), and personal allergen list |
| Favorites & history | Save products, track past analyses with scores and flagged ingredients |

No competitor (INCI Decoder, CosDNA, Yuka) combines all three: personalized analysis + explainable recommendations + compatibility checker in a single web tool.

## Tech stack

| Layer | Technology | Why |
|---|---|---|
| Frontend | React 18, TypeScript, Tailwind CSS, React Query, Zustand | Type-safe component UI; React Query handles server state caching automatically |
| Backend | Spring Boot 3, Java 17, Spring Security, Spring Data JPA | Layered architecture (Controller → Service → Repository) maps cleanly to the domain |
| Database | PostgreSQL 16 | Native `text[]` arrays for allergens and skin conditions; `JSONB` for flexible analysis result storage |
| Auth | JWT (jjwt 0.12.5) + BCrypt | Stateless auth with short-lived access tokens and refresh token rotation/revocation |
| Migrations | Flyway | Version-controlled schema; V1 creates all tables, V2 seeds 30 ingredients + 5 interaction rules |
| Container | Docker, Docker Compose | Single `docker-compose.yml` starts PostgreSQL with health check; backend waits for healthy DB |

## Architecture decisions

**Why PostgreSQL over MySQL?** `JSONB` support for storing analysis results as flexible structured data, and native array types for allergen/condition lists — avoids a separate join table for simple string collections.

**Why a rule-based engine instead of ML?** Full transparency and auditability. Every safety score is traceable to explicit flag records in the database — no black box, no commercial bias. Skin-type flags are stored per ingredient and resolved at runtime against the user's profile.

**Why separate `IngredientFlag` and `IngredientInteraction` tables?** Flags handle per-ingredient safety per skin type (one-to-many). Interactions handle conflicts between ingredient *pairs* across products (many-to-many self-join on ingredients). Keeping them separate lets the rule engine evaluate them independently.

## Rule engine logic

```
For each ingredient in the product:
  1. Look up IngredientFlag for user's skin type → BENEFICIAL / NEUTRAL / CAUTION / AVOID
  2. If ingredient INCI name is in user's allergen list → override to AVOID
  3. Safety score starts at 100
     - subtract 5 per CAUTION
     - subtract 15 per AVOID
     - clamp at 0
  4. Assign label: GREAT (≥80) / GOOD (≥60) / CAUTION (≥40) / POOR (<40)
  5. Generate natural language explanation for every non-neutral ingredient
```

Seeded conflict rules: Retinol + Salicylic Acid (HIGH), Retinol + Glycolic Acid (HIGH), Vitamin C + Niacinamide (MEDIUM), Salicylic Acid + Glycolic Acid (MEDIUM), Retinol + Lactic Acid (MEDIUM).

## Quick start

**Prerequisites:** Java 17+, Node.js 18+, Docker

```bash
# 1. Start PostgreSQL
docker-compose up postgres -d

# 2. Backend (runs on :8081, Flyway auto-migrates on startup)
cd backend
mvn spring-boot:run

# 3. Frontend (runs on :5173)
cd frontend
npm install
npm run dev
```

## Project structure

```
skinsight/
├── docker-compose.yml
├── backend/                    Spring Boot 3 / Java 17
│   └── src/main/java/com/skinsight/
│       ├── auth/               JWT auth (register, login, refresh, logout)
│       ├── user/               Profile, favorites
│       ├── product/            Search, detail
│       ├── ingredient/         Ingredient database + flags
│       ├── analysis/           Rule engine + history
│       ├── compatibility/      Conflict checker
│       ├── admin/              Product/ingredient CRUD (ADMIN role)
│       └── common/             Security config, error handling
└── frontend/                   React 18 / TypeScript / Tailwind CSS
    └── src/
        ├── pages/              Landing, Auth, Products, Profile, Dashboard, Compatibility
        ├── components/         UI primitives, AnalysisPanel, CompatibilityReport
        ├── hooks/              useAuth, useProducts, useAnalysis, useCompatibility
        ├── api/                Axios API layer
        └── store/              Zustand auth store
```

## API reference

| Method | Endpoint | Auth | Description |
|---|---|---|---|
| POST | `/api/auth/register` | — | Register |
| POST | `/api/auth/login` | — | Login → JWT pair |
| POST | `/api/auth/refresh` | — | Refresh access token |
| POST | `/api/auth/logout` | ✓ | Revoke refresh token |
| GET | `/api/users/me` | ✓ | Get profile |
| PUT | `/api/users/me/profile` | ✓ | Update skin type / allergens |
| GET | `/api/users/me/favorites` | ✓ | Favorites list |
| POST | `/api/users/me/favorites/{id}` | ✓ | Add favorite |
| DELETE | `/api/users/me/favorites/{id}` | ✓ | Remove favorite |
| GET | `/api/products` | — | Search + filter products (paginated) |
| GET | `/api/products/{id}` | — | Product detail with ingredients |
| POST | `/api/analysis/{productId}` | ✓ | Run ingredient analysis |
| GET | `/api/analysis/history` | ✓ | Analysis history (paginated) |
| POST | `/api/compatibility/check` | ✓ | Check compatibility between products |
| POST | `/api/admin/products` | ADMIN | Create product |
| PUT | `/api/admin/products/{id}` | ADMIN | Update product |
| POST | `/api/admin/ingredients` | ADMIN | Create ingredient with flags |
| PUT | `/api/admin/ingredients/{id}` | ADMIN | Update ingredient flags |

## Notes

- First registered user gets `USER` role. To promote to admin: `UPDATE users SET role='ADMIN' WHERE email='your@email.com'`
- Flyway seeds 30 ingredients with skin-type flags and 5 sample products on first startup
- All analysis outputs carry non-medical disclaimers — SkinSight is a decision-support tool, not a medical instrument
- Passwords stored as BCrypt hashes; skin profile data is user-controlled and used only for personalization
