-- V4__add_massive_products.sql

INSERT INTO products (name, brand, category, description, image_url) VALUES
--  CLEANSERS (Умывалки)
('Hydrating Cream-to-Foam Cleanser', 'CeraVe', 'CLEANSER', 'Cleanses, hydrates, and removes makeup without disrupting the protective skin barrier.', null),
('Daily Facial Cleanser', 'Cetaphil', 'CLEANSER', 'Gentle foaming cleanser for sensitive, combination to oily skin.', null),
('Toleriane Purifying Foaming Cream', 'La Roche-Posay', 'CLEANSER', 'Daily facial cleanser for normal to oily skin.', null),
('Matcha Hemp Hydrating Cleanser', 'Krave Beauty', 'CLEANSER', 'An antioxidant-rich jelly cleanser that cleans without stripping.', null),
('Low pH Good Morning Gel Cleanser', 'COSRX', 'CLEANSER', 'Gentle gel cleanser with slightly acidic pH.', null),
('Soy Makeup Removing Face Wash', 'Fresh', 'CLEANSER', 'A gentle, everyday cleanser for all skin types that removes impurities.', null),

--  TONERS (Тонеры)
('Supple Preparation Facial Toner', 'Dear, Klairs', 'TONER', 'Hydrates and calms the skin after cleansing while maintaining pH balance.', null),
('Gokujyun Premium Lotion', 'Hada Labo', 'TONER', 'Premium hyaluronic acid toner with 5 types of HA for intense hydration.', null),
('Centella Unscented Toner', 'Purito', 'TONER', 'Essential oil-free toner with 10% Centella Asiatica to soothe skin.', null),
('BHA Blackhead Power Liquid', 'COSRX', 'TONER', 'Exfoliating toner to clear pores and reduce blackheads.', null),
('Fat Water Pore-Refining Toner Serum', 'Fenty Skin', 'TONER', 'A 2-in-1 toner-serum combo that targets pores, improves dark spots.', null),

--  SERUMS (Сыворотки)
('Vitamin C 15% + PHA Serum', 'The INKEY List', 'SERUM', 'Antioxidant serum that brightens and protects skin.', null),
('B5 Hydrating Serum', 'La Roche-Posay', 'SERUM', 'Hyaluronic acid serum with vitamin B5 for intense hydration and plumping.', null),
('C-Firma Fresh Day Serum', 'Drunk Elephant', 'SERUM', 'Potent vitamin C serum designed to firm and brighten skin.', null),
('Niacinamide Dew Drops', 'Glow Recipe', 'SERUM', 'Highlighting skincare and makeup hybrid with niacinamide.', null),
('Snail Bee High Content Essence', 'Benton', 'SERUM', 'Multi-tasking essence with snail secretion filtrate and bee venom.', null),
('Advanced Night Repair', 'Estee Lauder', 'SERUM', 'Deep penetrating serum that reduces the look of multiple signs of aging.', null),
('Multi-Peptide + HA Serum', 'The Ordinary', 'SERUM', 'A universal formula that combines a comprehensive array of technologies to target multiple signs of aging.', null),

--  MOISTURIZERS (Кремы)
('Moisturizing Lotion', 'CeraVe', 'MOISTURIZER', 'Lightweight, oil-free moisturizer with hyaluronic acid and ceramides.', null),
('Hydro Boost Water Gel', 'Neutrogena', 'MOISTURIZER', 'Refreshing, light water gel that instantly quenches dry skin.', null),
('Protini Polypeptide Cream', 'Drunk Elephant', 'MOISTURIZER', 'Protein moisturizer that combines peptides and amino acids.', null),
('Cicaplast Baume B5', 'La Roche-Posay', 'MOISTURIZER', 'Multi-purpose soothing balm for dry skin irritations.', null),
('Green Tea Seed Cream', 'Innisfree', 'MOISTURIZER', 'Deeply hydrating cream packed with Jeju green tea extract.', null),
('Lala Retro Whipped Cream', 'Drunk Elephant', 'MOISTURIZER', 'Rescue cream infused with six rare African oils and plant ceramides.', null),
('Water Sleeping Mask', 'Laneige', 'MOISTURIZER', 'Overnight hydrating mask that leaves skin refreshed and glowing.', null),
('Natural Moisturizing Factors + HA', 'The Ordinary', 'MOISTURIZER', 'Keeps the outer layer of the skin protected and well-hydrated.', null),

--  EXFOLIANTS (Пилинги и кислоты)
('AHA 30% + BHA 2% Peeling Solution', 'The Ordinary', 'EXFOLIANT', '10-minute exfoliating facial to improve skin texture and radiance.', null),
('Skin Perfecting 8% AHA Gel', 'Paula''s Choice', 'EXFOLIANT', 'Gentle leave-on exfoliant that removes built-up dead skin.', null),
('T.L.C. Framboos Glycolic Night Serum', 'Drunk Elephant', 'EXFOLIANT', 'High-tech AHA/BHA gel that resurfaces dull, congested skin.', null),
('Liquid ExfoliKate', 'Kate Somerville', 'EXFOLIANT', 'Triple acid resurfacing treatment with 10% AHA and fruit enzymes.', null),

-- ️ SUNSCREENS (Солнцезащитные)
('UV Aqua Rich Watery Essence SPF 50+', 'Biore', 'SUNSCREEN', 'Lightweight watery essence sunscreen with high UV protection.', null),
('Centella Green Level Unscented Sun', 'Purito', 'SUNSCREEN', 'Gentle, unscented chemical sunscreen with Centella extract.', null),
('Clear Face Liquid Lotion Sunscreen SPF 55', 'Neutrogena', 'SUNSCREEN', 'Oil-free liquid sunscreen for acne-prone skin.', null),
('Daily UV Defense Sunscreen SPF 36', 'Innisfree', 'SUNSCREEN', 'Water-based sunscreen that delivers invisible protection.', null),
('Glowscreen SPF 40', 'Supergoop!', 'SUNSCREEN', 'Illuminating daily primer with broad spectrum SPF protection.', null);