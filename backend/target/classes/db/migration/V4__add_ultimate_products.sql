-- V5__add_ultimate_products.sql
-- Финальное пополнение: хиты K-Beauty, люкс и бестселлеры аптеки!

INSERT INTO products (name, brand, category, description, image_url) VALUES
--  CLEANSERS (Умывалки и гидрофильные масла)
('Superfood Antioxidant Cleanser', 'Youth To The People', 'CLEANSER', 'Rich gel cleanser packed with cold-pressed green juice.', null),
('Clean It Zero Cleansing Balm', 'Banila Co', 'CLEANSER', 'Hypoallergenic cleanser that transforms from a sherbet-like balm into a smooth oil.', null),
('Acne Foaming Wash 10% Benzoyl Peroxide', 'PanOxyl', 'CLEANSER', 'Maximum strength antimicrobial foaming wash kills acne-causing bacteria.', null),
('Deep Cleansing Oil', 'DHC', 'CLEANSER', 'Olive oil-based facial cleanser that dissolves makeup thoroughly.', null),
('Milky Jelly Cleanser', 'Glossier', 'CLEANSER', 'Conditioning face wash that leaves skin soft and visibly clear.', null),

--  TONERS (Тонеры)
('Heartleaf 77% Soothing Toner', 'Anua', 'TONER', 'Highly soothing toner with 77% heartleaf extract for sensitive skin.', null),
('Rice Toner', 'I''m From', 'TONER', 'Formulated with 77.78% rice extract to hydrate and brighten dull skin.', null),
('Cream Skin Toner & Moisturizer', 'Laneige', 'TONER', '2-in-1 formula that preps and softens like a toner and moisturizes like a cream.', null),
('Witch Hazel Toner with Rose Petal', 'Thayers', 'TONER', 'Alcohol-free, soothing witch hazel toner with aloe vera.', null),
('No.3 Super Quaking Complexion Toner', 'numbuzin', 'TONER', 'Fermentation toner that improves skin tone and texture.', null),

--  SERUMS (Сыворотки)
('C E Ferulic', 'SkinCeuticals', 'SERUM', 'Patented daytime vitamin C serum that delivers advanced environmental protection.', null),
('Glow Deep Serum: Rice + Alpha-Arbutin', 'Beauty of Joseon', 'SERUM', 'Lightweight serum to fade dark spots and improve skin glow.', null),
('Revitalift 1.5% Pure Hyaluronic Acid', 'L''Oreal Paris', 'SERUM', 'Intensively hydrating serum that visibly plumps skin.', null),
('Discoloration Correcting Serum', 'Good Molecules', 'SERUM', 'Formulated with advanced tranexamic acid to improve hyperpigmentation.', null),
('Good Genes All-In-One Lactic Acid', 'Sunday Riley', 'SERUM', 'Clarifying lactic acid treatment to smooth and brighten.', null),
('Plum Plump Hyaluronic Acid Serum', 'Glow Recipe', 'SERUM', 'Hydrating serum with 5 molecular weights of hyaluronic acid.', null),

--  MOISTURIZERS (Кремы)
('Ultra Facial Cream', 'Kiehl''s', 'MOISTURIZER', '24-hour daily moisturizer that leaves skin comfortable and visibly well-balanced.', null),
('The Dewy Skin Cream', 'Tatcha', 'MOISTURIZER', 'Rich, moisturizing cream with plumping hydration and antioxidant-packed Japanese purple rice.', null),
('Ceramide Ato Concentrate Cream', 'Illiyoon', 'MOISTURIZER', 'Deeply hydrating body and face cream for sensitive and dry skin.', null),
('SoonJung 2x Barrier Intensive Cream', 'Etude House', 'MOISTURIZER', 'Hypoallergenic cream formulated with panthenol and madecassoside.', null),
('The True Cream Aqua Bomb', 'belif', 'MOISTURIZER', 'Ultra-lightweight gel-cream that instantly cools and refreshes skin.', null),
('Magic Cream', 'Charlotte Tilbury', 'MOISTURIZER', 'Award-winning moisturizer for hydrated, glowing, plumper-looking skin.', null),

--  EXFOLIANTS (Пилинги и кислоты)
('AHA BHA PHA 30 Days Miracle Toner', 'SOME BY MI', 'EXFOLIANT', 'Daily exfoliating toner targeting acne and uneven skin texture.', null),
('Glow Tonic', 'Pixi', 'EXFOLIANT', 'Highly concentrated, invigorating facial toner with 5% glycolic acid.', null),
('Overnight Exfoliating Treatment', 'Good Molecules', 'EXFOLIANT', 'AHA and BHA blend to resurface and renew skin overnight.', null),
('Mandelic Acid 10% + HA', 'The Ordinary', 'EXFOLIANT', 'Superficial dermal peeling that is gentler than other alpha hydroxy acids.', null),

--  SUNSCREENS (Солнцезащитные)
('Relief Sun: Rice + Probiotics', 'Beauty of Joseon', 'SUNSCREEN', 'Lightweight and creamy organic sunscreen that is comfortable on skin.', null),
('Birch Juice Moisturizing Sun Cream', 'Round Lab', 'SUNSCREEN', 'Hydrating sunscreen that doubles as a moisturizer without white cast.', null),
('Hyaluronic Acid Watery Sun Gel', 'Isntree', 'SUNSCREEN', 'Eight types of hyaluronic acid replenish moisture while protecting from UV rays.', null),
('UV Clear Broad-Spectrum SPF 46', 'EltaMD', 'SUNSCREEN', 'Oil-free sunscreen helps calm and protect sensitive skin types prone to breakouts.', null),
('Urban Environment Oil-Free Sunscreen', 'Shiseido', 'SUNSCREEN', 'Ultra-light, oil-free sun protection lotion for the face.', null);