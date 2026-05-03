-- V7__add_massive_conflicts.sql
-- Создаем огромное количество конфликтов и продуктов с агрессивными активами!

-- 1. ДОБАВЛЯЕМ НОВЫЕ ПРАВИЛА НЕСОВМЕСТИМОСТИ (INGREDIENT INTERACTIONS)
-- Пептиды (30) боятся Кислот (AHA - 6, 7) и Витамина С (3)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (3, 30, 'HIGH', 'Vitamin C + Peptides: Аскорбиновая кислота разрушает пептидные связи, делая оба средства бесполезными. Разносите их на утро и вечер.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (6, 30, 'HIGH', 'Glycolic Acid + Peptides: Кислоты снижают pH и полностью нейтрализуют омолаживающее действие пептидов.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (7, 30, 'HIGH', 'Lactic Acid + Peptides: Кислоты разрушают структуру пептидов. Использовать вместе бессмысленно.');

-- Витамин С (3) конфликтует с Ретинолом (2) и Бензоил Пероксидом (27)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (2, 3, 'HIGH', 'Retinol + Vitamin C: Мощное раздражение кожи из-за разницы pH. Сильный риск получить химический ожог или дерматит.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (3, 27, 'HIGH', 'Vitamin C + Benzoyl Peroxide: Бензоил пероксид окисляет витамин С, делая его неэффективным и окрашивая кожу в оранжевый цвет.');

-- Азелаиновая кислота (25) + Салициловая (5) / AHA (6) / Бензоил (27)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (5, 25, 'MEDIUM', 'BHA + Azelaic Acid: Обе кислоты отшелушивают кожу. Риск пересушивания и повреждения барьера. Осторожно для чувствительной кожи.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (6, 25, 'MEDIUM', 'AHA + Azelaic Acid: Сильное отшелушивающее комбо. Может вызвать шелушение и покраснение.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (25, 27, 'HIGH', 'Azelaic Acid + Benzoyl Peroxide: Экстремальное пересушивание и повреждение липидного барьера кожи.');

-- Спирт (16) усугубляет Ретинол (2)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (2, 16, 'MEDIUM', 'Retinol + Alcohol Denat: Спирт усиливает проницаемость, но сильно сушит кожу, усугубляя побочные эффекты ретинола ("ретиноловый дерматит").');


-- 2. ДОБАВЛЯЕМ ПРОДУКТЫ С ВЫСОКОЙ КОНЦЕНТРАЦИЕЙ АКТИВОВ
INSERT INTO products (name, brand, category, description, image_url) VALUES
-- Пептиды (конфликтуют с кислотами и вит. С)
('Copper Peptide Firming Serum', 'SkinTech', 'SERUM', 'Anti-aging serum with 1% copper peptides.', null),
('Matrixyl 3000 + Argireline', 'The Ordinary', 'SERUM', 'Powerful peptide complex for deep wrinkles.', null),
('Multi-Peptide Eye Serum', 'The Ordinary', 'SERUM', 'Peptides targeting eye contour concerns.', null),

-- Витамин С (конфликтует с ретинолом, пептидами, бензоил пероксидом)
('Clinical Grade Vit C 30% Silicone', 'DermTech', 'SERUM', 'Extremely potent 30% L-Ascorbic Acid.', null),
('Vitamin C Brightening Toner', 'GlowMakers', 'TONER', 'Daily brightening toner with ascorbic acid.', null),
('C-Radiance Boosting Serum', 'Lumina', 'SERUM', 'Vitamin C and Hyaluronic acid blend.', null),

-- Ретиноиды (конфликтуют с кислотами, вит. С, бензоилом)
('Encapsulated Retinol 2% Serum', 'Skincare Lab', 'SERUM', 'High strength sustained release retinol.', null),
('Prescription Grade Tretinoin 0.05%', 'PharmacyRx', 'MOISTURIZER', 'Clinical strength retinoid for acne and aging.', null),
('Retinol Toner Pads', 'ClearSkin', 'TONER', 'Daily swipe pads with retinol and alcohol.', null),

-- Мощные кислоты AHA/BHA (конфликтуют с ретинолом, пептидами)
('Advanced Peeling AHA/BHA Pads', 'DermTech', 'EXFOLIANT', 'Glycolic, Lactic, and Salicylic acid daily pads.', null),
('Maximum Strength Peeling Solution', 'SkinTech', 'EXFOLIANT', 'Professional grade AHA peeling.', null),
('Pure Lactic Acid 10% Serum', 'GlowMakers', 'EXFOLIANT', 'Mild but effective 10% lactic acid.', null),
('BHA 9% Spot Treatment', 'Paula''s Choice', 'EXFOLIANT', 'Stubborn acne spot treatment.', null),
('Multi-Acid Clarifying Toner', 'PoreControl', 'TONER', 'AHA/BHA clarifying daily sweep.', null),

-- Средства от Акне (Азелаиновая кислота и Бензоил Пероксид)
('10% Azelaic Acid Booster', 'Paula''s Choice', 'SERUM', 'Multitasking cream-gel for redness and breakouts.', null),
('15% Azelaic Acid Prescription Grade', 'PharmacyRx', 'MOISTURIZER', 'Clinical treatment for severe rosacea and acne.', null),
('Benzoyl Peroxide 5% Daily Wash', 'ClearSkin', 'CLEANSER', 'Foaming acne wash.', null),
('Acne SOS Drying Lotion', 'PoreControl', 'SERUM', 'Overnight drying lotion with BP and Alcohol.', null),
('Triple Action Acne Treatment', 'DermTech', 'SERUM', 'BP and Salicylic acid combined.', null),
('Clear Pore Daily BHA/Azelaic', 'SkinTech', 'SERUM', 'Combination for stubborn texture.', null);


-- 3. ПРИВЯЗЫВАЕМ АКТИВЫ К ПРОДУКТАМ (Без этого конфликты не сработают!)

-- Пептидные продукты
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 30, 1 FROM products WHERE name IN ('Copper Peptide Firming Serum', 'Matrixyl 3000 + Argireline', 'Multi-Peptide Eye Serum');

-- Витамин С
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 3, 1 FROM products WHERE name IN ('Clinical Grade Vit C 30% Silicone', 'Vitamin C Brightening Toner', 'C-Radiance Boosting Serum');

-- Ретинол
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 2, 1 FROM products WHERE name IN ('Encapsulated Retinol 2% Serum', 'Prescription Grade Tretinoin 0.05%', 'Retinol Toner Pads');
-- Добавим спирт в тонер с ретинолом
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 16, 2 FROM products WHERE name = 'Retinol Toner Pads';

-- Кислоты AHA/BHA
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 6, 1 FROM products WHERE name IN ('Advanced Peeling AHA/BHA Pads', 'Maximum Strength Peeling Solution', 'Multi-Acid Clarifying Toner');
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 7, 2 FROM products WHERE name IN ('Advanced Peeling AHA/BHA Pads', 'Pure Lactic Acid 10% Serum', 'Multi-Acid Clarifying Toner');
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 5, 3 FROM products WHERE name IN ('Advanced Peeling AHA/BHA Pads', 'BHA 9% Spot Treatment', 'Multi-Acid Clarifying Toner');

-- Азелаиновая кислота
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 25, 1 FROM products WHERE name IN ('10% Azelaic Acid Booster', '15% Azelaic Acid Prescription Grade', 'Clear Pore Daily BHA/Azelaic');

-- Бензоил Пероксид
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 27, 1 FROM products WHERE name IN ('Benzoyl Peroxide 5% Daily Wash', 'Acne SOS Drying Lotion', 'Triple Action Acne Treatment');
-- Добавим спирт и BHA в SOS лосьон
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 16, 2 FROM products WHERE name = 'Acne SOS Drying Lotion';
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 5, 3 FROM products WHERE name = 'Acne SOS Drying Lotion';
-- Добавим BHA в Triple Action
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 5, 2 FROM products WHERE name = 'Triple Action Acne Treatment';
-- Добавим BHA к Азелаиновой в Clear Pore
INSERT INTO product_ingredients (product_id, ingredient_id, position) SELECT id, 5, 2 FROM products WHERE name = 'Clear Pore Daily BHA/Azelaic';