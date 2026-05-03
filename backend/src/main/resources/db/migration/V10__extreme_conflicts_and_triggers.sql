-- V10__extreme_conflicts_and_triggers.sql
-- Extremely comprehensive incompatibility database and adding triggers to products

-- ==========================================
-- 1. STRICT INCOMPATIBILITY RULES (Red and Yellow flags)
-- ==========================================

-- SLS (18) + Acids and Retinol (Death to the barrier)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (18, 2, 'HIGH', 'SLS + Retinol: Harsh sulfates wash away the skin''s protective layer, causing retinol to penetrate too deeply and cause severe burns.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (18, 5, 'HIGH', 'SLS + BHA (Salicylic): A double blow to the hydrolipid mantle. The skin will feel squeaky clean, over-dry, and start producing even more oil.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (18, 6, 'HIGH', 'SLS + AHA: Washing with sulfates before applying acids guarantees redness and stinging.');

-- Fragrance (17) + Actives (Allergy risk)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (17, 2, 'MEDIUM', 'Fragrance + Retinol: Retinol thins the stratum corneum and makes the skin sensitive. Fragrance on top of retinol = high risk of contact dermatitis.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (17, 6, 'MEDIUM', 'Fragrance + Glycolic Acid: Applying perfumed products to acid-exfoliated skin can cause rashes and itching.');

-- Kojic Acid (28) + Other actives (Pigmentation danger)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (28, 2, 'HIGH', 'Kojic Acid + Retinol: Both components are extremely aggressive. Mixing them will cause inflammation leading to post-inflammatory hyperpigmentation (the exact opposite of the desired effect).');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (28, 27, 'HIGH', 'Kojic Acid + Benzoyl Peroxide: Extreme irritation. Never use brightening acids together with acne treatments.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (28, 6, 'HIGH', 'Kojic Acid + AHA: Risk of a chemical burn. The skin may peel off in layers.');

-- Peptides (30) + Benzoyl Peroxide (27) (Destruction)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (30, 27, 'HIGH', 'Peptides + Benzoyl Peroxide: Benzoyl peroxide releases oxygen, which instantly oxidizes and completely destroys expensive peptides.');

-- Alcohol (16) + Acids and Acne treatments
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (16, 5, 'HIGH', 'Alcohol + BHA: Alcohol and salicylic acid together will turn the skin into parchment. Guaranteed peeling.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (16, 27, 'HIGH', 'Alcohol + Benzoyl Peroxide: A direct path to dermatitis. Alcohol destroys moisture, and peroxide burns bacteria along with the skin.');
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (16, 3, 'MEDIUM', 'Alcohol + Vitamin C: Alcohol destabilizes many forms of Vitamin C and can cause stinging upon application.');

-- Niacinamide (1) + AHA acids (6)
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description)
VALUES (1, 6, 'MEDIUM', 'Niacinamide + AHA: Niacinamide can raise the pH of acids, making exfoliation less effective. It is better to separate them into morning and evening routines.');


-- ==========================================
-- 2. PLANTING "MINES" IN PRODUCTS
-- (Adding Alcohol, Fragrance, SLS, and Kojic Acid to specific products)
-- ==========================================

-- Adding Alcohol (Alcohol Denat - 16) to Japanese/chemical sunscreens and some toners
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 16, 2 FROM products WHERE name IN ('UV Aqua Rich Watery Essence SPF 50+', 'Urban Environment Oil-Free Sunscreen', 'BHA Blackhead Power Liquid', 'Glow Tonic')
                                 AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 16);

-- Adding Fragrance (17) to luxury products and popular masks
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 17, 5 FROM products WHERE name IN ('Magic Cream', 'Water Sleeping Mask', 'Glow Deep Serum: Rice + Alpha-Arbutin', 'Advanced Night Repair', 'Soy Makeup Removing Face Wash')
                                 AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 17);

-- Adding harsh SLS (18) to "squeaky clean" cleansers and acne treatments
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 18, 2 FROM products WHERE name IN ('Acne Foaming Wash 10% Benzoyl Peroxide', 'Daily Facial Cleanser', 'Deep Cleansing Oil', 'Benzoyl Peroxide 5% Daily Wash')
                                 AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 18);

-- Adding Kojic Acid (28) to brightening serums
INSERT INTO product_ingredients (product_id, ingredient_id, position)
SELECT id, 28, 2 FROM products WHERE name IN ('Discoloration Correcting Serum', 'Glow Deep Serum: Rice + Alpha-Arbutin', 'Vitamin C Brightening Toner')
                                 AND NOT EXISTS (SELECT 1 FROM product_ingredients WHERE product_id = products.id AND ingredient_id = 28);