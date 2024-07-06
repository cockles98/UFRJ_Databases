-- Este arquivo SQL está escrito para MySQL
-- Conjunto de caracteres e collation para o arquivo
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET collation_connection = 'utf8mb4_unicode_ci';

-- 1. Quais são as informações das Categorias cadastradas na base de dados?
SELECT * FROM Categories;

-- 2. Quais os Nomes e Sobrenomes dos Funcionários nascidos após os anos 50?
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(BirthDate) > 1950;

-- 3. Quais os Nomes, Contatos e Endereços dos clientes residentes no ‘Brazil’ ou na ‘Argentina’?
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Country IN ('Brazil', 'Argentina');

-- 4. Quais os Nomes, Contatos e Endereços dos clientes que não residem nem no ‘Brazil’, nem na ‘Germany’, nem na ‘France’, e nem nos ‘USA’?
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Country NOT IN ('Brazil', 'Germany', 'France', 'USA');

-- 5. Quais os Nomes e valores dos Produtos cujos Preços estão entre 205.0 e 305.0, inclusive?
SELECT ProductName, Price
FROM Products
WHERE Price BETWEEN 205.0 AND 305.0;

-- 6. Quais os Nomes e as Cidades dos clientes cujos Nomes iniciam por B ou R?
SELECT CustomerName, City
FROM Customers
WHERE CustomerName LIKE 'B%' OR CustomerName LIKE 'R%';

-- 7. Qual a lista de Cidades onde há um fornecedor de produto?
SELECT DISTINCT City
FROM Suppliers;

-- 8. Qual o Ranking de Produtos por preço? Isto é, liste os nomes e preços dos produtos ordenados do maior para o menor preço.
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC;

-- 9. Forneça as quantidades X e Y para o departamento de marketing completar a frase:
-- "Atendemos à cliente de Y nacionalidades diferentes, residentes em X cidades pelo mundo".
SELECT
    (SELECT COUNT(DISTINCT City) FROM Customers) AS X,
    (SELECT COUNT(DISTINCT Country) FROM Customers) AS Y;

-- 10. Qual o maior preço, o menor preço, a média de preços e a faixa de preços dos produtos comercializados?
SELECT
    MAX(Price) AS MaxPrice,
    MIN(Price) AS MinPrice,
    AVG(Price) AS AvgPrice,
    MAX(Price) - MIN(Price) AS PriceRange
FROM Products;

-- 11. Qual a lista de “nomes completos” dos funcionários e as suas idades em 31 de dezembro do ano corrente?
SELECT
    CONCAT(FirstName, ' ', LastName) AS FullName,
    TIMESTAMPDIFF(YEAR, BirthDate, '2024-12-31') AS Age
FROM Employees;

-- 12. Apresente uma lista com o Nome de Produto, sua unidade de comercialização, e uma nova coluna contendo a classificação do produto por “Faixa de preço”.
SELECT
    ProductName,
    Unit,
    CASE
        WHEN Price <= 10.00 THEN 'Preço baixo'
        WHEN Price BETWEEN 10.01 AND 49.99 THEN 'Preço médio'
        WHEN Price BETWEEN 50.00 AND 99.99 THEN 'Preço alto'
        ELSE 'Preço Elevado'
    END AS FaixaDePreco
FROM Products;

-- 13. Qual o Ranking das Cidades por quantidade de clientes? E o ranking dos países?
-- Ranking das Cidades por quantidade de clientes
SELECT City, COUNT(*) AS NumClientes
FROM Customers
GROUP BY City
ORDER BY NumClientes DESC;

-- Ranking dos Países por quantidade de clientes
SELECT Country, COUNT(*) AS NumClientes
FROM Customers
GROUP BY Country
ORDER BY NumClientes DESC;
