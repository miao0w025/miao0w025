USE classicmodels; 

SELECT COUNT(orderNumber) AS tongDonHang
FROM orders
WHERE orderDate >= '2005-05-01'
  AND orderDate < '2005-06-01';
-- 3.2. In ra các trạng thái đơn hàng
SELECT DISTINCT status
FROM orders;

-- 3.3. Top 5 sản phẩm tồn kho nhiều nhất
SELECT productName,
       quantityInStock AS tongXe
FROM products
ORDER BY tongXe DESC
LIMIT 5;

-- 3.4. Quốc gia không có nhân viên hỗ trợ
SELECT DISTINCT country
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

-- 3.5. Giá sản phẩm năm nay và dự đoán năm sau (+20%)
SELECT productName,
       buyPrice AS giaBanNamNay,
       buyPrice * 1.2 AS giaBanNamSau
FROM products;

-- 3.6. 5 sản phẩm có chênh lệch giá cao nhất
SELECT productName,
       ABS(MSRP - buyPrice) AS chenhLechGia
FROM products
ORDER BY chenhLechGia DESC
LIMIT 5;

-- 3.7. Top 5 khách hàng chi tiêu nhiều nhất
SELECT customerNumber,
       SUM(amount) AS tongChiTieu
FROM payments
GROUP BY customerNumber
ORDER BY tongChiTieu DESC
LIMIT 5;

-- 3.8. Tổng doanh thu từ sản phẩm S18_1749
SELECT productCode,
       SUM(quantityOrdered * priceEach) AS tongTien
FROM orderdetails
WHERE productCode = 'S18_1749';

-- 3.9. Đếm số đơn hàng của sản phẩm S18_1749
SELECT productCode,
       COUNT(DISTINCT orderNumber) AS tongDonHang
FROM orderdetails
WHERE productCode = 'S18_1749';

-- 3.10. Top 3 sản phẩm bán nhiều nhất
SELECT productCode,
       SUM(quantityOrdered) AS tongSoLuong
FROM orderdetails
GROUP BY productCode
ORDER BY tongSoLuong DESC
LIMIT 3;

-- 3.11. Sản phẩm có giá bán giữa 50 và 100
SELECT *
FROM orderdetails
WHERE priceEach BETWEEN 50 AND 100;

-- 3.12. Trung bình hạn mức tín dụng khách hàng Mỹ
SELECT country,
       AVG(creditLimit) AS tbCredit
FROM customers
WHERE country = 'USA';

-- 3.13. Các đơn hàng bị tranh chấp
SELECT *
FROM orders
WHERE status = 'Disputed';

-- 3.14. Thống kê số khách hàng quốc tế (không phải USA)
SELECT country,
       COUNT(customerNumber) AS soKhachHangQuocTe
FROM customers
WHERE country <> 'USA'
GROUP BY country;

-- 3.15. Liệt kê các chức danh nhân viên
SELECT DISTINCT jobTitle
FROM employees;
