-- V6__add_conflicts_and_ingredients.sql

-- 1. Добавляем новые жесткие правила несовместимости
-- Benzoyl Peroxide (27) + Retinol (2)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (2, 27, 'HIGH', 'Retinol + Benzoyl Peroxide: Они нейтрализуют друг друга и вызывают сильнейшее раздражение, ожоги и сухость.');

-- Benzoyl Peroxide (27) + Salicylic Acid (5)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (5, 27, 'HIGH', 'BHA + Benzoyl Peroxide: Экстремально сушащая комбинация. Сильно повреждает защитный барьер кожи.');

-- Ascorbic Acid (3) + Glycolic Acid (6)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (3, 6, 'HIGH', 'Vitamin C + AHA (Glycolic Acid): Обе кислоты очень сильные. Использование вместе приведет к покраснению и нарушению pH баланса.');


-- 2. Добавляем новые продукты-активы (концентраты)
INSERT INTO products (name, brand, category, description, image_url) VALUES
                                                                         ('Intensive Retinol 1% Night Cream', 'Skincare Lab', 'MOISTURIZER', 'High strength 1% Pure Retinol for deep wrinkles.', null),
                                                                         ('Max Strength Acne Spot Treatment', 'ClearSkin', 'SERUM', '10% Benzoyl Peroxide spot treatment.', null),
                                                                         ('Pure Vitamin C 20% Serum', 'GlowMakers', 'SERUM', 'High concentration L-Ascorbic Acid.', null),
                                                                         ('AHA Resurfacing Liquid', 'DermTech', 'EXFOLIANT', 'Potent 10% Glycolic Acid liquid.', null),
                                                                         ('BHA Pore Clearing Toner', 'PoreControl', 'TONER', '2% Salicylic Acid formula.', null);


-- 3. ПРИВЯЗЫВАЕМ ИНГРЕДИЕНТЫ К ПРОДУКТАМ (чтобы алгоритм их увидел)

-- Intensive Retinol -> Retinol (2), Glycerin (22)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 2, 1 FROM products WHERE name = 'Intensive Retinol 1% Night Cream';
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 22, 2 FROM products WHERE name = 'Intensive Retinol 1% Night Cream';

-- Acne Spot -> Benzoyl Peroxide (27), Alcohol Denat (16 - жесткий спирт)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 27, 1 FROM products WHERE name = 'Max Strength Acne Spot Treatment';
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 16, 2 FROM products WHERE name = 'Max Strength Acne Spot Treatment';

-- Vitamin C -> Ascorbic Acid (3), Tocopherol (11)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 3, 1 FROM products WHERE name = 'Pure Vitamin C 20% Serum';
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 11, 2 FROM products WHERE name = 'Pure Vitamin C 20% Serum';

-- AHA Resurfacing -> Glycolic Acid (6), Lactic Acid (7)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 6, 1 FROM products WHERE name = 'AHA Resurfacing Liquid';
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 7, 2 FROM products WHERE name = 'AHA Resurfacing Liquid';

-- BHA Toner -> Salicylic Acid (5), Propylene Glycol (20)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 5, 1 FROM products WHERE name = 'BHA Pore Clearing Toner';
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 20, 2 FROM products WHERE name = 'BHA Pore Clearing Toner';

-- 4. Оживим парочку хитов из предыдущих скриптов!
-- 'C E Ferulic' -> Добавим ему Витамин С (3)
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 3, 1 FROM products WHERE name = 'C E Ferulic';

-- 'AHA 30% + BHA 2% Peeling Solution' -> Гликолевая (6) и Салициловая (5) кислоты
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 6, 1 FROM products WHERE name = 'AHA 30% + BHA 2% Peeling Solution';
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 5, 2 FROM products WHERE name = 'AHA 30% + BHA 2% Peeling Solution';