-- V2__seed_ingredients.sql

INSERT INTO ingredients (inci_name, common_name, description, functions) VALUES
('NIACINAMIDE',           'Vitamin B3',          'Water-soluble vitamin that improves skin texture, minimizes pores, and reduces redness.',                     ARRAY['brightening','pore-minimizing','anti-inflammatory']),
('RETINOL',               'Vitamin A',            'Gold standard anti-aging ingredient that speeds cell turnover and boosts collagen.',                           ARRAY['anti-aging','cell-turnover','collagen-boosting']),
('ASCORBIC ACID',         'Vitamin C',            'Potent antioxidant that brightens skin, evens tone, and protects against free radicals.',                     ARRAY['antioxidant','brightening','collagen-boosting']),
('HYALURONIC ACID',       'Hyaluronic Acid',      'Humectant that can hold up to 1000x its weight in water; plumps and hydrates skin.',                         ARRAY['humectant','hydrating','plumping']),
('SALICYLIC ACID',        'BHA',                  'Oil-soluble beta hydroxy acid that penetrates pores to clear blackheads and acne.',                           ARRAY['exfoliating','anti-acne','pore-clearing']),
('GLYCOLIC ACID',         'AHA',                  'Alpha hydroxy acid that exfoliates the surface, improves tone and texture.',                                   ARRAY['exfoliating','brightening','anti-aging']),
('LACTIC ACID',           'Lactic Acid',          'Gentle AHA suitable for sensitive skin; exfoliates and hydrates simultaneously.',                             ARRAY['exfoliating','hydrating','brightening']),
('CERAMIDE NP',           'Ceramide 3',           'Lipid molecule that restores the skin barrier and prevents moisture loss.',                                    ARRAY['barrier-repair','moisturizing']),
('CERAMIDE AP',           'Ceramide 6',           'Barrier-strengthening lipid that helps retain moisture.',                                                     ARRAY['barrier-repair','moisturizing']),
('PANTHENOL',             'Provitamin B5',        'Humectant and skin-conditioning agent that soothes and hydrates.',                                             ARRAY['humectant','soothing','healing']),
('TOCOPHEROL',            'Vitamin E',            'Antioxidant that protects skin from oxidative stress and supports barrier function.',                          ARRAY['antioxidant','barrier-repair','moisturizing']),
('ZINC OXIDE',            'Zinc Oxide',           'Mineral sunscreen agent; also anti-inflammatory for acne-prone skin.',                                        ARRAY['sun-protection','anti-inflammatory']),
('TITANIUM DIOXIDE',      'Titanium Dioxide',     'Mineral sunscreen agent; gentle and non-irritating.',                                                         ARRAY['sun-protection']),
('ALLANTOIN',             'Allantoin',            'Soothing agent that promotes cell renewal and calms irritated skin.',                                          ARRAY['soothing','healing','anti-irritant']),
('CENTELLA ASIATICA EXTRACT', 'Cica',            'Plant extract that repairs skin barrier and soothes inflammation.',                                            ARRAY['soothing','barrier-repair','anti-inflammatory']),
('ALCOHOL DENAT.',        'Denatured Alcohol',    'Volatile alcohol used as a solvent; can be drying and irritating with frequent use.',                         ARRAY['solvent','antimicrobial']),
('FRAGRANCE',             'Parfum / Fragrance',   'Added scent; common allergen and irritant, especially for sensitive skin.',                                   ARRAY['fragrance']),
('SODIUM LAURYL SULFATE', 'SLS',                  'Surfactant and cleansing agent; known to strip the skin barrier and cause irritation.',                       ARRAY['surfactant','cleansing']),
('METHYLPARABEN',         'Methylparaben',        'Preservative; effective antimicrobial but a potential irritant and endocrine disruptor concern.',              ARRAY['preservative']),
('PROPYLENE GLYCOL',      'Propylene Glycol',     'Humectant and solvent; effective hydrator but can irritate sensitive skin at high concentrations.',           ARRAY['humectant','solvent']),
('DIMETHICONE',           'Silicone',             'Silicone that smooths skin texture and locks in moisture; non-comedogenic.',                                  ARRAY['emollient','barrier-forming','smoothing']),
('GLYCERIN',              'Glycerin',             'Gentle humectant that attracts moisture from the air; suitable for all skin types.',                          ARRAY['humectant','hydrating']),
('ALOE BARBADENSIS LEAF JUICE', 'Aloe Vera',     'Soothing plant extract with anti-inflammatory and hydrating properties.',                                     ARRAY['soothing','hydrating','anti-inflammatory']),
('TRANEXAMIC ACID',       'Tranexamic Acid',      'Brightening ingredient that reduces dark spots and hyperpigmentation.',                                       ARRAY['brightening','anti-hyperpigmentation']),
('AZELAIC ACID',          'Azelaic Acid',         'Targets acne and rosacea; reduces hyperpigmentation and calms redness.',                                     ARRAY['anti-acne','anti-redness','brightening']),
('CAFFEINE',              'Caffeine',             'Antioxidant that reduces puffiness and strengthens the skin barrier.',                                        ARRAY['antioxidant','anti-puffiness']),
('BENZOYL PEROXIDE',      'Benzoyl Peroxide',     'Antibacterial agent that kills acne-causing bacteria; can be drying.',                                       ARRAY['anti-acne','antibacterial']),
('KOJIC ACID',            'Kojic Acid',           'Tyrosinase inhibitor that reduces melanin production for brighter skin.',                                     ARRAY['brightening','anti-hyperpigmentation']),
('GREEN TEA EXTRACT',     'EGCG / Green Tea',     'Polyphenol-rich antioxidant that protects skin and calms inflammation.',                                     ARRAY['antioxidant','anti-inflammatory','soothing']),
('PEPTIDES',              'Peptides',             'Short chains of amino acids that signal collagen production and firm skin.',                                  ARRAY['anti-aging','collagen-boosting','firming']);

-- INGREDIENT FLAGS
-- Skin types: NORMAL, OILY, DRY, COMBINATION, SENSITIVE

-- NIACINAMIDE (id=1) - good for everyone, especially oily/sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(1,'NORMAL','BENEFICIAL'),(1,'OILY','BENEFICIAL'),(1,'DRY','BENEFICIAL'),
(1,'COMBINATION','BENEFICIAL'),(1,'SENSITIVE','BENEFICIAL');

-- RETINOL (id=2) - avoid sensitive, caution dry
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(2,'NORMAL','BENEFICIAL'),(2,'OILY','BENEFICIAL'),(2,'DRY','CAUTION'),
(2,'COMBINATION','BENEFICIAL'),(2,'SENSITIVE','CAUTION');

-- ASCORBIC ACID (id=3) - caution sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(3,'NORMAL','BENEFICIAL'),(3,'OILY','BENEFICIAL'),(3,'DRY','BENEFICIAL'),
(3,'COMBINATION','BENEFICIAL'),(3,'SENSITIVE','CAUTION');

-- HYALURONIC ACID (id=4) - good for everyone
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(4,'NORMAL','BENEFICIAL'),(4,'OILY','BENEFICIAL'),(4,'DRY','BENEFICIAL'),
(4,'COMBINATION','BENEFICIAL'),(4,'SENSITIVE','BENEFICIAL');

-- SALICYLIC ACID (id=5) - great for oily/combo, avoid dry/sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(5,'NORMAL','BENEFICIAL'),(5,'OILY','BENEFICIAL'),(5,'DRY','AVOID'),
(5,'COMBINATION','BENEFICIAL'),(5,'SENSITIVE','CAUTION');

-- GLYCOLIC ACID (id=6) - avoid sensitive, caution dry
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(6,'NORMAL','BENEFICIAL'),(6,'OILY','BENEFICIAL'),(6,'DRY','CAUTION'),
(6,'COMBINATION','BENEFICIAL'),(6,'SENSITIVE','AVOID');

-- LACTIC ACID (id=7) - gentle AHA, ok for sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(7,'NORMAL','BENEFICIAL'),(7,'OILY','BENEFICIAL'),(7,'DRY','BENEFICIAL'),
(7,'COMBINATION','BENEFICIAL'),(7,'SENSITIVE','NEUTRAL');

-- CERAMIDE NP (id=8) - great for dry/sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(8,'NORMAL','BENEFICIAL'),(8,'OILY','NEUTRAL'),(8,'DRY','BENEFICIAL'),
(8,'COMBINATION','BENEFICIAL'),(8,'SENSITIVE','BENEFICIAL');

-- CERAMIDE AP (id=9)
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(9,'NORMAL','BENEFICIAL'),(9,'OILY','NEUTRAL'),(9,'DRY','BENEFICIAL'),
(9,'COMBINATION','BENEFICIAL'),(9,'SENSITIVE','BENEFICIAL');

-- PANTHENOL (id=10)
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(10,'NORMAL','BENEFICIAL'),(10,'OILY','BENEFICIAL'),(10,'DRY','BENEFICIAL'),
(10,'COMBINATION','BENEFICIAL'),(10,'SENSITIVE','BENEFICIAL');

-- TOCOPHEROL (id=11)
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(11,'NORMAL','BENEFICIAL'),(11,'OILY','NEUTRAL'),(11,'DRY','BENEFICIAL'),
(11,'COMBINATION','NEUTRAL'),(11,'SENSITIVE','BENEFICIAL');

-- ALCOHOL DENAT. (id=16) - bad for dry/sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(16,'NORMAL','CAUTION'),(16,'OILY','CAUTION'),(16,'DRY','AVOID'),
(16,'COMBINATION','CAUTION'),(16,'SENSITIVE','AVOID');

-- FRAGRANCE (id=17) - bad for sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(17,'NORMAL','NEUTRAL'),(17,'OILY','NEUTRAL'),(17,'DRY','CAUTION'),
(17,'COMBINATION','NEUTRAL'),(17,'SENSITIVE','AVOID');

-- SLS (id=18) - bad for dry/sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(18,'NORMAL','CAUTION'),(18,'OILY','CAUTION'),(18,'DRY','AVOID'),
(18,'COMBINATION','CAUTION'),(18,'SENSITIVE','AVOID');

-- GLYCERIN (id=22) - good for all
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(22,'NORMAL','BENEFICIAL'),(22,'OILY','NEUTRAL'),(22,'DRY','BENEFICIAL'),
(22,'COMBINATION','BENEFICIAL'),(22,'SENSITIVE','BENEFICIAL');

-- ALOE VERA (id=23) - great for sensitive
INSERT INTO ingredient_flags (ingredient_id, skin_type, flag) VALUES
(23,'NORMAL','BENEFICIAL'),(23,'OILY','BENEFICIAL'),(23,'DRY','BENEFICIAL'),
(23,'COMBINATION','BENEFICIAL'),(23,'SENSITIVE','BENEFICIAL');

-- INGREDIENT INTERACTIONS
INSERT INTO ingredient_interactions (ingredient_a_id, ingredient_b_id, severity, description) VALUES
(2, 5, 'HIGH',   'Retinol + Salicylic Acid: Both are potent actives. Using together can cause severe irritation and dryness. Use on alternate evenings.'),
(2, 6, 'HIGH',   'Retinol + Glycolic Acid: Combining these can significantly increase skin sensitivity and cause peeling. Do not use in the same routine.'),
(3, 1, 'MEDIUM', 'High-concentration Vitamin C + Niacinamide: May reduce efficacy of both. Apply Vitamin C first, wait 15 min, then apply Niacinamide.'),
(5, 6, 'MEDIUM', 'Salicylic Acid + Glycolic Acid: Using multiple acids together increases risk of over-exfoliation. Use on separate days.'),
(2, 7, 'MEDIUM', 'Retinol + Lactic Acid: Can cause irritation. If combining, use a low concentration of both and monitor skin reaction.');

-- SAMPLE PRODUCTS
INSERT INTO products (name, brand, category, description, image_url) VALUES
('Ultra Repair Cream',        'First Aid Beauty',  'MOISTURIZER', 'Intense hydration cream for dry and sensitive skin.',           NULL),
('Ordinary Niacinamide 10%',  'The Ordinary',      'SERUM',       '10% Niacinamide + 1% Zinc serum for pores and shine control.', NULL),
('CeraVe Moisturizing Cream', 'CeraVe',            'MOISTURIZER', 'Rich moisturizer with ceramides and hyaluronic acid.',          NULL),
('Paula BHA Exfoliant 2%',    'Paula''s Choice',   'EXFOLIANT',   '2% BHA liquid exfoliant for unclogging pores.',                 NULL),
('Retinol 0.5% Serum',        'The Ordinary',      'SERUM',       'Pure retinol in squalane for anti-aging.',                      NULL);

-- PRODUCT INGREDIENTS (simplified)
-- Ultra Repair Cream: HA, Ceramide, Allantoin, Glycerin
INSERT INTO product_ingredients (product_id, ingredient_id, position) VALUES
(1, 4, 1),(1, 8, 2),(1, 14, 3),(1, 22, 4);

-- Niacinamide 10%: Niacinamide, Glycerin, Propylene Glycol
INSERT INTO product_ingredients (product_id, ingredient_id, position) VALUES
(2, 1, 1),(2, 22, 2),(2, 20, 3);

-- CeraVe: Ceramide, HA, Glycerin, Allantoin
INSERT INTO product_ingredients (product_id, ingredient_id, position) VALUES
(3, 8, 1),(3, 9, 2),(3, 4, 3),(3, 22, 4),(3, 14, 5);

-- Paula BHA: Salicylic Acid, Glycerin
INSERT INTO product_ingredients (product_id, ingredient_id, position) VALUES
(4, 5, 1),(4, 22, 2);

-- Retinol Serum: Retinol, Tocopherol
INSERT INTO product_ingredients (product_id, ingredient_id, position) VALUES
(5, 2, 1),(5, 11, 2);
