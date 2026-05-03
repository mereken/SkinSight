-- V8__fill_missing_ingredients.sql
-- Умное заполнение пустых продуктов ингредиентами на основе их названий и категорий!

-- 1. Добавляем Витамин С (3) везде, где есть слово Vitamin C или Ascorbic
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 3, 1 FROM products WHERE (name ILIKE '%Vitamin C%' OR name ILIKE '%Ascorbic%')
                                AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 3);

-- 2. Добавляем Салициловую кислоту (BHA - 5)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 5, 2 FROM products WHERE (name ILIKE '%BHA%' OR name ILIKE '%Salicylic%')
                                AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 5);

-- 3. Добавляем Гликолевую кислоту (AHA - 6)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 6, 3 FROM products WHERE (name ILIKE '%AHA%' OR name ILIKE '%Glycolic%')
                                AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 6);

-- 4. Добавляем Гиалуроновую кислоту (4)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 4, 1 FROM products WHERE (name ILIKE '%Hyaluronic%' OR name ILIKE '%Water%' OR name ILIKE '%Hydrat%')
                                AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 4);

-- 5. Добавляем Ниацинамид (1)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 1, 1 FROM products WHERE name ILIKE '%Niacinamide%'
AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 1);

-- 6. Добавляем Центеллу / Cica (15)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 15, 2 FROM products WHERE (name ILIKE '%Centella%' OR name ILIKE '%Cica%')
                                 AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 15);

-- 7. Добавляем Церамиды (8)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 8, 2 FROM products WHERE name ILIKE '%Ceramide%'
AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 8);


-- 8. РАЗДАЕМ БАЗОВЫЕ ИНГРЕДИЕНТЫ ПО КАТЕГОРИЯМ (чтобы никто не ушел обиженным)

-- Всем солнцезащитным кремам (SUNSCREEN) даем Оксид Цинка (12) и Диоксид Титана (13)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 12, 1 FROM products WHERE category = 'SUNSCREEN' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 12);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 13, 2 FROM products WHERE category = 'SUNSCREEN' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 13);

-- Всем умывалкам (CLEANSER) даем Глицерин (22) и Пантенол (10)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 22, 1 FROM products WHERE category = 'CLEANSER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 22);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 10, 2 FROM products WHERE category = 'CLEANSER' AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 10);


-- 9. ФИНАЛЬНАЯ ПРОВЕРКА: Если у продукта всё ещё ВООБЩЕ НЕТ ингредиентов, даем ему базу (Глицерин и Аллантоин)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 22, 1 FROM products WHERE id NOT IN (SELECT DISTINCT product_id FROM product_ingredients);

INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 14, 2 FROM products WHERE id NOT IN (SELECT DISTINCT product_id FROM product_ingredients WHERE ingredient_id = 14)
                                 AND (SELECT count(*) FROM product_ingredients p2 WHERE p2.product_id = products.id) < 2;