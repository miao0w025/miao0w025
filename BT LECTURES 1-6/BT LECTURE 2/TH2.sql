
-- Câu 1: Thông tin tên, dòng sản phẩm, giá của dòng 'Motorcycles'
SELECT productName, productLine, buyPrice
FROM products
WHERE productLine = 'Motorcycles';

-- Câu 2: Truy vấn sai đã sửa
-- Sai: viết COUNT sai cú pháp, số để trong dấu nháy
-- Đúng:
SELECT productName, productLine, buyPrice
FROM products
WHERE buyPrice < 20 OR buyPrice > 90;

-- Câu 3.1: Các loại tình trạng giao hàng (status)
SELECT DISTINCT status
FROM orders;

-- Câu 3.2: Số đơn hàng đã giao dịch thành công trong tháng 4/2003
SELECT COUNT(orderNumber) AS tongDonHang
FROM orders
WHERE status = 'Shipped'
  AND orderDate >= '2003-04-01'
  AND orderDate < '2003-05-01';

-- Câu 4: Số lượng khách hàng quốc tế theo từng khu vực (state IS NULL)
SELECT country, COUNT(customerNumber) AS soKhachHang
FROM customers
WHERE state IS NULL
GROUP BY country;

-- Câu 5: Mã đơn hàng và ngày đặt trong tháng 2/2003
SELECT orderNumber, orderDate
FROM orders
WHERE orderDate BETWEEN '2003-02-01' AND '2003-02-28';

-- Câu 6: Truy vấn sai đã sửa
-- Sai: COUNT viết sai, có dấu phẩy dư
-- Đúng:
SELECT city, COUNT(customerNumber) AS soKhachHang
FROM customers
GROUP BY city
ORDER BY soKhachHang DESC;

-- Câu 7: 5 khách hàng có creditLimit lớn nhất
SELECT customerName, phone, addressLine1, creditLimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;

-- Câu 8: Thông tin sản phẩm dòng 'Classic Cars', sắp xếp theo tên
SELECT productName, productDescription, quantityInStock
FROM products
WHERE productLine = 'Classic Cars'
ORDER BY productName ASC;

-- Câu 9: Đơn đặt hàng có tổng tiền > 1000 và số lượng > 500
SELECT o.orderNumber,
       SUM(od.quantityOrdered * od.priceEach) AS tongTien,
       SUM(od.quantityOrdered) AS tongSoLuong
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber
HAVING tongTien > 1000 AND tongSoLuong > 500
ORDER BY tongTien DESC;

-- Câu 10: Tổng giá trị đơn hàng của KH có phone = 6505555787
SELECT c.customerName,
       SUM(od.quantityOrdered * od.priceEach) AS tongGiaTriDonHang
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE c.phone = '6505555787'
GROUP BY c.customerName;

-- Câu 10.2: Số tiền đã thanh toán của KH có mã 129
SELECT customerNumber, SUM(amount) AS tongThanhToan
FROM payments
WHERE customerNumber = 129
GROUP BY customerNumber;

-- Câu 11: Tổng giá trị đơn hàng của KH mã 119
SELECT c.customerNumber,
       SUM(od.quantityOrdered * od.priceEach) AS tongGiaTriDonHang
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE c.customerNumber = 119
GROUP BY c.customerNumber;

-- Câu 11.2: Số tiền đã thanh toán của KH mã 119
SELECT customerNumber, SUM(amount) AS tongThanhToan
FROM payments
WHERE customerNumber = 119
GROUP BY customerNumber;

-- Câu 12: Nhận xét (chỉ cần SELECT để so sánh 2 khách hàng 119 và 129)
SELECT c.customerNumber,
       SUM(od.quantityOrdered * od.priceEach) AS tongGiaTriDonHang,
       (SELECT SUM(amount) FROM payments p WHERE p.customerNumber = c.customerNumber) AS tongThanhToan
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE c.customerNumber IN (119, 129)
GROUP BY c.customerNumber;
