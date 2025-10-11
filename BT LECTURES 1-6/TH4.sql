-- ======================== BÀI 1: Truy vấn dữ liệu ========================
SET SQL_SAFE_UPDATES = 0;

UPDATE offices
SET phone = '+84 123 456 456'
WHERE officeCode = 8;

SET SQL_SAFE_UPDATES = 1; 

-- 1. Nhân viên hỗ trợ của mỗi khách hàng
SELECT c.customerNumber,
       c.salesRepEmployeeNumber,
       e.officeCode
FROM customers c
JOIN employees e
     ON c.salesRepEmployeeNumber = e.employeeNumber;

-- 2. Thông tin thanh toán
SELECT p.customerNumber,
       c.creditLimit,
       p.checkNumber,
       p.paymentDate,
       p.amount
FROM payments p
JOIN customers c
     ON p.customerNumber = c.customerNumber;

-- 3. Đơn hàng đang xử lý hoặc có số lượng đặt >= 45
SELECT DISTINCT o.orderNumber
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE o.status = 'In Process'
   OR od.quantityOrdered >= 45;

-- 4. View chứa thông tin đơn hàng – sản phẩm
CREATE VIEW order_info AS
SELECT od.orderNumber,
       od.productCode,
       p.productName,
       od.quantityOrdered
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode;


-- ======================== BÀI 2: Chỉnh sửa dữ liệu ========================

-- 1. Thêm chi nhánh mới
INSERT INTO offices (officeCode, city, phone, addressLine1, country, postalCode, territory)
VALUES (8, 'Ha Noi', '+84 123 123 123', '19 Le Thanh Nghi', 'Viet Nam', 'VN2022', 'VN');

-- 2. Cập nhật số điện thoại
UPDATE offices
SET phone = '+84 123 456 456'
WHERE officeCode = 8;

-- 3. Xóa chi nhánh
DELETE FROM offices
WHERE officeCode = 8;

-- 4. Thao tác trên orderdetails
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES (10425, 'S32_2509', 10, 15.34, 7);

UPDATE orderdetails
SET quantityOrdered = 20
WHERE orderNumber = 10425
  AND productCode = 'S32_2509';

DELETE FROM orderdetails
WHERE orderNumber = 10425
  AND productCode = 'S32_2509';


-- ======================== BÀI 3: Phân tích truy vấn sai ========================

-- 1. UNION: sửa đúng
SELECT orderNumber, customerNumber
FROM orders
WHERE status = 'In Process'
UNION
SELECT od.orderNumber, o.customerNumber
FROM orderdetails od
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE quantityOrdered >= 45;

-- 2. INSERT: sửa đúng
INSERT INTO orders (orderNumber, orderDate, requiredDate, status, customerNumber)
VALUES ('VN10000', '2022-09-12', '2022-09-15', 'In Process', 121);


-- ======================== BÀI 4: Truy vấn tổng hợp ========================

-- 1. Nhân viên chưa có khách hàng
SELECT e.officeCode, e.employeeNumber
FROM employees e
LEFT JOIN customers c
     ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.customerNumber IS NULL;

-- 2. Doanh thu mỗi chi nhánh
SELECT e.officeCode,
       SUM(p.amount) AS revenue
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.officeCode
ORDER BY e.officeCode;

-- 3. View thống kê văn phòng, nhân viên, khách hàng theo quốc gia
CREATE VIEW country_stats AS
SELECT o.country,
       COUNT(DISTINCT o.officeCode) AS num_offices,
       COUNT(DISTINCT e.employeeNumber) AS num_employees,
       COUNT(DISTINCT c.customerNumber) AS num_customers
FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY o.country;

-- 4. Sản phẩm chưa bán ở Pháp
SELECT p.productCode, p.productName
FROM products p
WHERE p.productCode NOT IN (
    SELECT od.productCode
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    JOIN customers c ON o.customerNumber = c.customerNumber
    WHERE c.country = 'France'
);

-- 5. Tạo bảng offices_usa
CREATE TABLE offices_usa (
    officeCode TINYINT PRIMARY KEY,
    city VARCHAR(50),
    phone VARCHAR(50)
);

-- 6. Thêm dữ liệu chi nhánh Mỹ vào offices_usa
INSERT INTO offices_usa (officeCode, city, phone)
SELECT officeCode, city, phone
FROM offices
WHERE country = 'USA';
