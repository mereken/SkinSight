-- V1__init_schema.sql

-- USERS
CREATE TABLE users (
    id         BIGSERIAL PRIMARY KEY,
    email      VARCHAR(255) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       VARCHAR(20)  NOT NULL DEFAULT 'USER',
    created_at TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- USER PROFILE
CREATE TABLE user_profile (
    id               BIGSERIAL PRIMARY KEY,
    user_id          BIGINT       NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    skin_type        VARCHAR(30),
    skin_conditions  TEXT[],
    allergens        TEXT[]
);

-- REFRESH TOKENS
CREATE TABLE refresh_tokens (
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT      NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token      VARCHAR(512) NOT NULL UNIQUE,
    expires_at TIMESTAMP   NOT NULL,
    revoked    BOOLEAN     NOT NULL DEFAULT FALSE
);

-- INGREDIENTS
CREATE TABLE ingredients (
    id           BIGSERIAL PRIMARY KEY,
    inci_name    VARCHAR(255) NOT NULL UNIQUE,
    common_name  VARCHAR(255),
    description  TEXT,
    functions    TEXT[]
);

-- INGREDIENT FLAGS (per skin type)
CREATE TABLE ingredient_flags (
    id            BIGSERIAL PRIMARY KEY,
    ingredient_id BIGINT      NOT NULL REFERENCES ingredients(id) ON DELETE CASCADE,
    skin_type     VARCHAR(30) NOT NULL,
    flag          VARCHAR(20) NOT NULL  -- BENEFICIAL, NEUTRAL, CAUTION, AVOID
);

-- INGREDIENT INTERACTIONS (compatibility rules)
CREATE TABLE ingredient_interactions (
    id               BIGSERIAL PRIMARY KEY,
    ingredient_a_id  BIGINT      NOT NULL REFERENCES ingredients(id),
    ingredient_b_id  BIGINT      NOT NULL REFERENCES ingredients(id),
    severity         VARCHAR(20) NOT NULL,  -- LOW, MEDIUM, HIGH
    description      TEXT
);

-- PRODUCTS
CREATE TABLE products (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    brand       VARCHAR(255),
    category    VARCHAR(100),
    description TEXT,
    image_url   VARCHAR(500)
);

-- PRODUCT <-> INGREDIENTS (ordered)
CREATE TABLE product_ingredients (
    product_id    BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    ingredient_id BIGINT NOT NULL REFERENCES ingredients(id),
    position      INT    NOT NULL,
    PRIMARY KEY (product_id, ingredient_id)
);

-- FAVORITES
CREATE TABLE favorites (
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id BIGINT    NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, product_id)
);

-- ANALYSIS HISTORY
CREATE TABLE analysis_history (
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id  BIGINT    NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    result_json JSONB     NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- INDEXES
CREATE INDEX idx_product_ingredients_product ON product_ingredients(product_id);
CREATE INDEX idx_ingredient_flags_ingredient ON ingredient_flags(ingredient_id);
CREATE INDEX idx_analysis_history_user       ON analysis_history(user_id);
CREATE INDEX idx_favorites_user              ON favorites(user_id);
