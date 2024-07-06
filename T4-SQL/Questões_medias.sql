-- Este arquivo SQL está escrito para MySQL
-- Conjunto de caracteres e collation para o arquivo
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET collation_connection = 'utf8mb4_unicode_ci';

-- 14. Quais os Nomes, Contatos e Endereços dos Clientes que fizeram pedidos em 1998?
SELECT DISTINCT Customers.CustomerName, Customers.ContactName, Customers.Address
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) = 1998;

-- 15. Quais os países (nacionalidade) dos clientes que fizeram pedidos em fevereiro de 1998?
SELECT DISTINCT Customers.Country
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) = 1998 AND MONTH(Orders.OrderDate) = 2;

-- 16. Quais os clientes que compraram mais de 10 produtos diferentes? E os que compraram mais de 100 produtos repetidos ou não?
-- Clientes que compraram mais de 10 produtos diferentes
SELECT Customers.CustomerName, COUNT(DISTINCT OrderDetails.ProductID) AS NumProdutosDiferentes
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerName
HAVING COUNT(DISTINCT OrderDetails.ProductID) > 10;

-- Clientes que compraram mais de 100 produtos (repetidos ou não)
SELECT Customers.CustomerName, SUM(OrderDetails.Quantity) AS TotalProdutos
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerName
HAVING SUM(OrderDetails.Quantity) > 100;

-- 17. Quais as faixas de preços dos produtos de cada Categoria, ou seja, qual o maior e o menor preço dos produtos de cada categoria?
SELECT Categories.CategoryName,
       MIN(Products.Price) AS MinPrice,
       MAX(Products.Price) AS MaxPrice
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName;

-- 18. Quais Empregados atenderam à Clientes brasileiros?
SELECT DISTINCT Employees.FirstName, Employees.LastName
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Country = 'Brazil';

-- 19. Quais produtos os brasileiros mais compraram?
SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Country = 'Brazil'
GROUP BY Products.ProductName
ORDER BY TotalQuantity DESC;

-- 20. Quais produtos foram vendidos para clientes dos USA em 1997?
SELECT DISTINCT Products.ProductName
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Country = 'USA' AND YEAR(Orders.OrderDate) = 1997;

-- 21. Qual o Cliente que comprou mais em 1996, em quantidade de produtos e em valor, e qual foi o Funcionário que mais o atendeu?
-- Cliente que comprou mais em quantidade de produtos
SELECT Customers.CustomerName, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(Orders.OrderDate) = 1996
GROUP BY Customers.CustomerName
ORDER BY TotalQuantity DESC
LIMIT 1;

-- Cliente que comprou mais em valor
SELECT Customers.CustomerName, SUM(OrderDetails.Quantity * Products.Price) AS TotalValue
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE YEAR(Orders.OrderDate) = 1996
GROUP BY Customers.CustomerName
ORDER BY TotalValue DESC
LIMIT 1;

-- Funcionário que mais atendeu o cliente que comprou mais em valor
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS NumOrders
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.CustomerName = (
    SELECT Customers.CustomerName
    FROM Customers
    JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE YEAR(Orders.OrderDate) = 1996
    GROUP BY Customers.CustomerName
    ORDER BY SUM(OrderDetails.Quantity * Products.Price) DESC
    LIMIT 1
)
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY NumOrders DESC
LIMIT 1;

-- 22. Quais os clientes que residem na mesma cidade?
SELECT City, GROUP_CONCAT(CustomerName SEPARATOR ', ') AS Clientes
FROM Customers
GROUP BY City
HAVING COUNT(CustomerName) > 1;

-- 23. Quais os clientes que não fizeram pedidos?
SELECT Customers.CustomerName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

-- 24. Há funcionários que não venderam?
SELECT Employees.FirstName, Employees.LastName
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.OrderID IS NULL;

-- 25. Quais funcionários foram responsáveis por menos de 50 pedidos?
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS NumOrders
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName
HAVING COUNT(Orders.OrderID) < 50;

-- 26. Quais Cliente e Fornecedor são do mesmo país?
SELECT Customers.CustomerName, Suppliers.SupplierName, Customers.Country
FROM Customers
JOIN Suppliers ON Customers.Country = Suppliers.Country;

-- 27. Quais os Produtos vendidos cujos Fornecedores e Clientes são ambos dos USA?
SELECT DISTINCT Products.ProductName
FROM Products
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Suppliers.Country = 'USA' AND Customers.Country = 'USA';

-- 28. Qual o total de vendas em quantidades de produtos e valor por Categoria de Produtos?
SELECT Categories.CategoryName,
       SUM(OrderDetails.Quantity) AS TotalQuantity,
       SUM(OrderDetails.Quantity * Products.Price) AS TotalValue
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Categories.CategoryName;

-- 29. Qual(is) a(s) Cidade(s) com o maior número de vendas em quantidade e em valor?
-- Cidade com o maior número de vendas em quantidade
SELECT Customers.City, SUM(OrderDetails.Quantity) AS TotalQuantity
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.City
ORDER BY TotalQuantity DESC
LIMIT 1;

-- Cidade com o maior número de vendas em valor
SELECT Customers.City, SUM(OrderDetails.Quantity * Products.Price) AS TotalValue
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.City
ORDER BY TotalValue DESC
LIMIT 1;

-- 30. Quais os clientes que não fizeram pedidos?
SELECT Customers.CustomerName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

-- 31. Qual o Top-10 (ranking dos dez primeiros) clientes que fizeram mais compras? (faça três SQL, uma para cada opção de quantificação: “por quantidade de pedidos”, “por quantidade de produtos comprados” e “por valor total das compras”).
-- Top-10 clientes por quantidade de pedidos
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS NumPedidos
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
ORDER BY NumPedidos DESC
LIMIT 10;

-- Top-10 clientes por quantidade de produtos comprados
SELECT Customers.CustomerName, SUM(OrderDetails.Quantity) AS TotalProdutos
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerName
ORDER BY TotalProdutos DESC
LIMIT 10;

-- Top-10 clientes por valor total das compras
SELECT Customers.CustomerName, SUM(OrderDetails.Quantity * Products.Price) AS TotalValor
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.CustomerName
ORDER BY TotalValor DESC
LIMIT 10;

-- 32. Qual o Top-10 das nacionalidades que mais compraram? Depois separe por ano.
-- Top-10 das nacionalidades que mais compraram
SELECT Customers.Country, SUM(OrderDetails.Quantity * Products.Price) AS TotalValor
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.Country
ORDER BY TotalValor DESC
LIMIT 10;

-- Separado por ano
SELECT Customers.Country, YEAR(Orders.OrderDate) AS Ano, SUM(OrderDetails.Quantity * Products.Price) AS TotalValor
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.Country, YEAR(Orders.OrderDate)
ORDER BY Ano, TotalValor DESC;

-- 33. Qual o Top-10 dos Funcionários que mais venderam? (faça pelas três quantificações). Depois responda: qual a idade que mais vendeu?
-- Top-10 funcionários por quantidade de pedidos
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS NumPedidos
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY NumPedidos DESC
LIMIT 10;

-- Top-10 funcionários por quantidade de produtos vendidos
SELECT Employees.FirstName, Employees.LastName, SUM(OrderDetails.Quantity) AS TotalProdutos
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY TotalProdutos DESC
LIMIT 10;

-- Top-10 funcionários por valor total das vendas
SELECT Employees.FirstName, Employees.LastName, SUM(OrderDetails.Quantity * Products.Price) AS TotalValor
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY TotalValor DESC
LIMIT 10;

-- Idade que mais vendeu
SELECT TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age, SUM(OrderDetails.Quantity * Products.Price) AS TotalValor
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Age
ORDER BY TotalValor DESC
LIMIT 1;

-- 34. Qual o Top-10 dos Produtos que mais venderam?
SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantidade
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantidade DESC
LIMIT 10;

-- 35. Há Frentista que entrega em todos os países? Qual o que entrega em mais países?
-- Frentista que entrega em todos os países
SELECT Employees.FirstName, Employees.LastName
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Employees.FirstName, Employees.LastName
HAVING COUNT(DISTINCT Customers.Country) = (SELECT COUNT(DISTINCT Country) FROM Customers);

-- Frentista que entrega em mais países
SELECT Employees.FirstName, Employees.LastName, COUNT(DISTINCT Customers.Country) AS NumPaises
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY NumPaises DESC
LIMIT 1;
