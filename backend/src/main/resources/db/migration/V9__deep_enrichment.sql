-- V9__deep_enrichment.sql
-- Глубокое обогащение базы: составы из 3-6 ингредиентов и новые правила анализатора

-- ==========================================
-- 1. СИНЕРГИЯ И СОВМЕСТИМОСТЬ (Рекомендации)
-- Используем severity 'LOW' для обозначения крутых связок
-- ==========================================

-- Витамин С (3) + Витамин Е (11)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (3, 11, 'LOW', 'SYNERGY: Vitamin E stabilizes Vitamin C and doubles its antioxidant protection against UV damage.');

-- Ретинол (2) + Церамиды (8)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (2, 8, 'LOW', 'SYNERGY: Ceramides help rebuild the skin barrier, significantly reducing the irritation and peeling caused by Retinol.');

-- Ретинол (2) + Гиалуроновая кислота (4)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (2, 4, 'LOW', 'SYNERGY: Hyaluronic acid draws moisture into the skin, perfectly countering the drying effects of retinoids.');

-- Ниацинамид (1) + Салициловая кислота (5)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (1, 5, 'LOW', 'SYNERGY: A perfect acne-fighting duo. BHA clears the pores, while Niacinamide regulates sebum and calms inflammation.');

-- Зеленый чай (29) + Алоэ (23)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (29, 23, 'LOW', 'SYNERGY: Ultimate soothing combo. Great for calming sunburns, redness, and sensitive skin reactions.');

-- ==========================================
-- 2. НОВЫЕ КОНФЛИКТЫ И ПРЕДУПРЕЖДЕНИЯ
-- ==========================================

-- Ниацинамид (1) + AHA кислоты (6)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (1, 6, 'MEDIUM', 'CAUTION: Niacinamide can raise the pH of AHA acids, making the exfoliation less effective. Wait 15 minutes between applications.');

-- Гликолевая кислота (6) + Спирт (16)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (6, 16, 'HIGH', 'HIGH RISK: Alcohol strips the skin barrier, and applying strong AHA acids over it will cause severe stinging and redness.');

-- Азелаиновая кислота (25) + Спирт (16)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (25, 16, 'MEDIUM', 'CAUTION: Both ingredients are drying. Mixing them can exacerbate rosacea or sensitive skin issues.');


-- ==========================================
-- 3. МАССОВОЕ ОБОГАЩЕНИЕ СОСТАВОВ ПРОДУКТОВ (Базовые формулы)
-- Безопасное добавление через NOT EXISTS, позиция 3, 4, 5, 6
-- ==========================================

-- ВСЕ КРЕМЫ (MOISTURIZER) получают Глицерин (22), Диметикон (21) и Церамиды (8)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 22, 3 FROM products WHERE category = 'MOISTURIZER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 22);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 21, 4 FROM products WHERE category = 'MOISTURIZER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 21);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 8, 5 FROM products WHERE category = 'MOISTURIZER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 8);


-- ВСЕ СЫВОРОТКИ (SERUM) получают Гиалуронку (4), Пантенол (10) и Аллантоин (14)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 4, 3 FROM products WHERE category = 'SERUM' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 4);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 10, 4 FROM products WHERE category = 'SERUM' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 10);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 14, 5 FROM products WHERE category = 'SERUM' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 14);


-- ВСЕ ТОНЕРЫ (TONER) получают Глицерин (22), Центеллу (15) и Экстракт Зеленого Чая (29)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 22, 3 FROM products WHERE category = 'TONER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 22);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 15, 4 FROM products WHERE category = 'TONER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 15);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 29, 5 FROM products WHERE category = 'TONER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 29);


-- ВСЕ УМЫВАЛКИ (CLEANSER) получают Глицерин (22), Алоэ (23) и Мягкий ПАВ (пусть будет SLS для базы, 18)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 22, 3 FROM products WHERE category = 'CLEANSER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 22);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 23, 4 FROM products WHERE category = 'CLEANSER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 23);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 18, 5 FROM products WHERE category = 'CLEANSER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 18);


-- ВСЕ СОЛНЦЕЗАЩИТНЫЕ (SUNSCREEN) получают Витамин Е (11), Пантенол (10) и Глицерин (22)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 11, 3 FROM products WHERE category = 'SUNSCREEN' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 11);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 10, 4 FROM products WHERE category = 'SUNSCREEN' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 10);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 22, 5 FROM products WHERE category = 'SUNSCREEN' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 22);


-- ==========================================
-- 4. ТОЧЕЧНЫЕ ДОБАВЛЕНИЯ ПО НАЗВАНИЯМ (Чтобы составы были уникальными)
-- ==========================================

-- Сквалан (используем Глицерин или Церамиды как замену, так как Сквалана нет в базе ингредиентов)
-- Продуктам с "Green Tea" добавляем Зеленый чай (29) на 1 позицию
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 29, 1 FROM products WHERE name ILIKE '%Green Tea%' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 29);

-- Продуктам с "Snail" или "Bee" добавляем Аллантоин (14) как заживляющий агент
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 14, 1 FROM products WHERE (name ILIKE '%Snail%' OR name ILIKE '%Bee%') AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 14);

-- В "Fat Water" добавим Ниацинамид (1)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 1, 2 FROM products WHERE name = 'Fat Water Pore-Refining Toner Serum' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 1);