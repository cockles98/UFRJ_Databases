-- Este arquivo SQL está escrito para MySQL
-- Conjunto de caracteres e collation para o arquivo
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET collation_connection = 'utf8mb4_unicode_ci';

-- 36. Quais os países onde há fornecedores que nunca venderam?
SELECT Country
FROM Suppliers
WHERE SupplierID NOT IN (
    SELECT DISTINCT SupplierID
    FROM Products
    JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
);

-- 37. Quais os fornecedores que nunca venderam e não têm produtos com preços acima de $200.00?
SELECT SupplierName
FROM Suppliers
WHERE SupplierID NOT IN (
    SELECT DISTINCT SupplierID
    FROM Products
    JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
)
AND SupplierID NOT IN (
    SELECT SupplierID
    FROM Products
    WHERE Price > 200.00
);

-- 38. Qual o nome do Produto mais vendido em 1997?
SELECT Products.ProductName
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE YEAR(Orders.OrderDate) = 1997
GROUP BY Products.ProductName
ORDER BY SUM(OrderDetails.Quantity) DESC
LIMIT 1;

-- 39. Quais os nomes dos produtos não vendidos em 1997?
SELECT ProductName
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM OrderDetails
    JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
    WHERE YEAR(OrderDate) = 1997
);

-- 40. Qual o percentual de vendas de produtos, considerando todas as vendas efetuadas, realizadas por funcionários com 50 anos ou mais?
SELECT
    (SUM(CASE
            WHEN TIMESTAMPDIFF(YEAR, Employees.BirthDate, CURDATE()) >= 50 THEN OrderDetails.Quantity * Products.Price
            ELSE 0
         END)
     /
     SUM(OrderDetails.Quantity * Products.Price)) * 100 AS PercentualVendas
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID;
