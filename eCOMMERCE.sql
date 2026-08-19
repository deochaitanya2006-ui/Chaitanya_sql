DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    password VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') DEFAULT 'Other',
    date_of_birth DATE,
    registered_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_line VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    country VARCHAR(50) DEFAULT 'India',
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE,
    contact_phone VARCHAR(15),
    address VARCHAR(150)
);
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    discount_percent DECIMAL(5,2) DEFAULT 0 CHECK (discount_percent BETWEEN 0 AND 100),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    description TEXT,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending','Confirmed','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (address_id) REFERENCES Addresses(address_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    payment_method ENUM('Credit Card','Debit Card','UPI','Net Banking','Cash on Delivery') NOT NULL,
    payment_status ENUM('Pending','Successful','Failed','Refunded') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Gadgets, devices and accessories'),
('Fashion', 'Clothing, footwear and accessories'),
('Home & Kitchen', 'Furniture, decor and kitchen appliances'),
('Books', 'Fiction, non-fiction and academic books'),
('Sports', 'Sports gear and fitness equipment');

SELECT * FROM Categories;
INSERT INTO Suppliers (supplier_name, contact_email, contact_phone, address) VALUES
('TechWorld Distributors', 'contact@techworld.com', '9876543210', 'Mumbai, Maharashtra'),
('FashionHub Pvt Ltd', 'sales@fashionhub.com', '9823456712', 'Nagpur, Maharashtra'),
('HomeEssentials Co', 'info@homeessentials.com', '9765432109', 'Pune, Maharashtra'),
('BookLand Publishers', 'orders@bookland.com', '9654321098', 'Delhi'),
('SportsGear Inc', 'support@sportsgear.com', '9543210987', 'Bengaluru, Karnataka');

SELECT * FROM Suppliers;
INSERT INTO Customers (first_name, last_name, email, phone, password, gender, date_of_birth) VALUES
('Chaitanya', 'Deshmukh', 'chaitanya@example.com', '9000000001', 'hashed_pw_1', 'Male', '2003-05-14'),
('Parth', 'Salankar', 'parth@example.com', '9000000002', 'hashed_pw_2', 'Male', '2003-08-22'),
('Sneha', 'Kulkarni', 'sneha@example.com', '9000000003', 'hashed_pw_3', 'Female', '2002-11-10'),
('Rohan', 'Patil', 'rohan@example.com', '9000000004', 'hashed_pw_4', 'Male', '2001-02-28'),
('Ananya', 'Sharma', 'ananya@example.com', '9000000005', 'hashed_pw_5', 'Female', '2003-07-19');

SELECT * FROM Customers;
INSERT INTO Addresses (customer_id, address_line, city, state, pincode, is_default) VALUES
(1, '12 MG Road', 'Akola', 'Maharashtra', '444001', TRUE),
(2, '45 Civil Lines', 'Nagpur', 'Maharashtra', '440001', TRUE),
(3, '78 FC Road', 'Pune', 'Maharashtra', '411005', TRUE),
(4, '23 Andheri West', 'Mumbai', 'Maharashtra', '400058', TRUE),
(5, '9 Sector 15', 'Chandigarh', 'Chandigarh', '160015', TRUE);

SELECT * FROM Addresses;
INSERT INTO Products (product_name, category_id, supplier_id, price, discount_percent, stock_quantity, description) VALUES
('Wireless Bluetooth Earbuds', 1, 1, 1999.00, 10.00, 150, 'Noise-cancelling wireless earbuds with 24hr battery'),
('Smartwatch Pro', 1, 1, 4999.00, 15.00, 80, 'Fitness tracking smartwatch with AMOLED display'),
('Men Casual Shirt', 2, 2, 899.00, 5.00, 200, '100% cotton casual shirt'),
('Women Running Shoes', 2, 2, 2499.00, 20.00, 120, 'Lightweight running shoes for daily training'),
('Non-Stick Cookware Set', 3, 3, 3499.00, 12.00, 60, '5-piece non-stick cookware set'),
('LED Table Lamp', 3, 3, 799.00, 0.00, 90, 'Adjustable brightness LED table lamp'),
('The Silent Patient (Novel)', 4, 4, 399.00, 8.00, 250, 'Bestselling psychological thriller'),
('DBMS Textbook', 4, 4, 650.00, 0.00, 100, 'Database Management Systems academic textbook'),
('Yoga Mat', 5, 5, 599.00, 10.00, 180, 'Anti-slip yoga mat 6mm thickness'),
('Dumbbell Set 10kg', 5, 5, 2199.00, 5.00, 70, 'Pair of rubber coated dumbbells');

SELECT * FROM Products;
INSERT INTO Orders (customer_id, address_id, order_status, total_amount) VALUES
(1, 1, 'Delivered', 6398.00),
(2, 2, 'Shipped', 899.00),
(3, 3, 'Pending', 3499.00),
(4, 4, 'Confirmed', 2499.00),
(1, 1, 'Delivered', 999.00);

SELECT * FROM Orders;
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 1999.00),
(1, 2, 1, 4999.00),
(2, 3, 1, 899.00),
(3, 5, 1, 3499.00),
(4, 4, 1, 2499.00),
(5, 7, 1, 399.00),
(5, 9, 1, 599.00);

SELECT * FROM Order_Items;
INSERT INTO Payments (order_id, payment_method, payment_status, amount_paid) VALUES
(1, 'UPI', 'Successful', 6398.00),
(2, 'Credit Card', 'Successful', 899.00),
(3, 'Cash on Delivery', 'Pending', 3499.00),
(4, 'Debit Card', 'Successful', 2499.00),
(5, 'UPI', 'Successful', 998.00);
SELECT * FROM Payments;
INSERT INTO Cart (customer_id, product_id, quantity) VALUES
(3, 10, 1),
(4, 6, 2),
(5, 8, 1);

SELECT * FROM Cart;
