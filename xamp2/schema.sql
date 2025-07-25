-- 💣 Reset the table (for development)
DROP TABLE IF EXISTS products;

-- 🧱 Recreate with image + dual currency
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    price REAL,          -- Price in Naira (₦)
    price_usd REAL,      -- Price in USD
    batch_no TEXT,
    expiry_date TEXT,
    quantity INTEGER,
    subtype TEXT,
    image_url TEXT       -- New: URL for product image
);

-- 🧹 Clear data if anything remains
DELETE FROM products;

-- 💻 Insert inventory with Naira & USD pricing, and images
INSERT INTO products (name, description, price, price_usd, batch_no, expiry_date, quantity, subtype, image_url) VALUES

-- 💻 Laptops
('ASUS ROG Zephyrus G16', 'High-performance gaming laptop.', 6560000, 4100, 'BW-001', '2026-12-31', 10, 'Laptop', 'https://m.media-amazon.com/images/I/61PEBTiIq6L._UF894%2C1000_QL80_.jpg'),
('Lenovo Legion 7i', 'Advanced cooling, top-tier internals.', 7520000, 4700, 'OJ-005', '2025-08-30', 8, 'Laptop', 'https://cdn-images-pc/lenovo-legion-7i.jpg'),
('Razer Blade 16', 'Thin design with powerful internals.', 7520000, 4700, 'LM-010', '2025-09-30', 7, 'Laptop', 'https://cdn-images-pc/razer-blade-16.jpg'),
('Alienware m18 R2', 'Large display gaming laptop.', 7200000, 4500, 'CC-022', '2026-03-01', 4, 'Laptop', 'https://cdn-images-pc/alienware-m18.jpg'),
('MSI Raider GE78', 'Fast refresh display, powerful GPU.', 7360000, 4600, 'MS-303', '2026-01-15', 6, 'Laptop', 'https://cdn-images-pc/msi-raider-ge78.jpg'),

-- 🖱 Mice
('Logitech G502 X Plus', 'Customizable buttons, RGB.', 92800, 58, 'MX-101', '2027-05-01', 20, 'Mouse', 'https://cdn-images-pc/logitech-g502x.jpg'),
('Razer DeathAdder V3 Pro', 'Lightweight FPS mouse.', 115200, 72, 'RZ-888', '2026-11-30', 15, 'Mouse', 'https://cdn-images-pc/razer-deathadder.jpg'),

-- 🎧 Headphones
('SteelSeries Arctis Nova Pro', 'Immersive audio, noise canceling.', 192000, 120, 'ST-303', '2026-08-20', 12, 'Headphones', 'https://cdn-images-pc/steelseries-nova-pro.jpg'),
('HyperX Cloud Alpha Wireless', 'Excellent battery life and comfort.', 152000, 95, 'HX-404', '2026-09-12', 10, 'Headphones', 'https://cdn-images-pc/hyperx-alpha.jpg'),

-- 🎮 Gamepads
('Xbox Wireless Controller', 'Responsive triggers and ergonomic grip.', 96000, 60, 'XP-505', '2027-04-01', 18, 'Gamepad', 'https://cdn-images-pc/xbox-controller.jpg'),
('DualSense PS5 Controller', 'Adaptive triggers and haptic feedback.', 104000, 65, 'DS-777', '2027-04-10', 14, 'Gamepad', 'https://cdn-images-pc/ps5-controller.jpg'),

-- 🖥 Monitors
('ASUS ROG Swift PG32UQ', '4K UHD 144Hz gaming monitor.', 640000, 400, 'MN-321', '2026-10-10', 6, 'Monitor', 'https://cdn-images-pc/asus-rog-monitor.jpg'),
('LG UltraGear 27GN950-B', 'Nano IPS 4K display, 144Hz refresh.', 624000, 390, 'LG-999', '2026-11-15', 5, 'Monitor', 'https://cdn-images-pc/lg-ultragear.jpg'),

-- 🧰 Accessories
('Cooler Master Laptop Stand', 'Adjustable height and ventilation.', 32000, 20, 'AC-101', '2027-03-01', 30, 'Accessory', 'https://cdn-images-pc/coolermaster-stand.jpg'),
('Logitech StreamCam', 'Full HD webcam for streaming.', 64000, 40, 'WB-202', '2026-12-01', 25, 'Accessory', 'https://cdn-images-pc/streamcam.jpg');
