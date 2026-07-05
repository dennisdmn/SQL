/*
    07 - Joins
    Exemplos com tabelas do AdventureWorksDW2016.
*/

-- 1. LEFT JOIN: traz todas as vendas e, quando existir, os dados do produto.
SELECT TOP (100)
    Vendas.SalesOrderNumber,
    Vendas.ProductKey,
    Produto.EnglishProductName,
    Vendas.SalesAmount
FROM FactInternetSales AS Vendas
LEFT JOIN DimProduct AS Produto
    ON Produto.ProductKey = Vendas.ProductKey;

-- 2. RIGHT JOIN: equivalente a inverter a ordem das tabelas de um LEFT JOIN.
-- Normalmente, prefira escrever a tabela principal primeiro e usar LEFT JOIN.
SELECT TOP (100)
    Vendas.SalesOrderNumber,
    Produto.ProductKey,
    Produto.EnglishProductName,
    Vendas.SalesAmount
FROM FactInternetSales AS Vendas
RIGHT JOIN DimProduct AS Produto
    ON Produto.ProductKey = Vendas.ProductKey;

-- 3. INNER JOIN: traz apenas registros que existem nos dois lados.
SELECT TOP (100)
    Vendas.SalesOrderNumber,
    Vendas.ProductKey,
    Produto.EnglishProductName,
    Vendas.SalesAmount
FROM FactInternetSales AS Vendas
INNER JOIN DimProduct AS Produto
    ON Produto.ProductKey = Vendas.ProductKey;

-- 4. FULL OUTER JOIN: mostra correspondencias e tambem faltantes dos dois lados.
SELECT TOP (100)
    Vendas.SalesOrderNumber,
    COALESCE(Vendas.ProductKey, Produto.ProductKey) AS ProductKey,
    Produto.EnglishProductName,
    Vendas.SalesAmount
FROM FactInternetSales AS Vendas
FULL OUTER JOIN DimProduct AS Produto
    ON Produto.ProductKey = Vendas.ProductKey;

-- 5. Join com mais de uma tabela.
SELECT TOP (100)
    Vendas.SalesOrderNumber,
    Produto.EnglishProductName,
    Cliente.FirstName,
    Cliente.LastName,
    Vendas.SalesAmount
FROM FactInternetSales AS Vendas
INNER JOIN DimProduct AS Produto
    ON Produto.ProductKey = Vendas.ProductKey
INNER JOIN DimCustomer AS Cliente
    ON Cliente.CustomerKey = Vendas.CustomerKey;

-- 6. Join com chave composta.
-- Use quando a combinacao de campos, e nao apenas um campo isolado, identifica o relacionamento.
SELECT TOP (100)
    A.SalesOrderNumber,
    A.SalesOrderLineNumber,
    A.ProductKey,
    B.ProductKey AS ProductKey_Comparacao
FROM FactInternetSales AS A
LEFT JOIN FactInternetSales AS B
    ON B.SalesOrderNumber = A.SalesOrderNumber
   AND B.SalesOrderLineNumber = A.SalesOrderLineNumber;

-- 7. CROSS JOIN: cria todas as combinacoes entre as tabelas.
-- Use com cuidado, pois o volume cresce rapidamente.
SELECT TOP (100)
    Produto.ProductKey,
    Produto.EnglishProductName,
    Moeda.CurrencyKey,
    Moeda.CurrencyName
FROM DimProduct AS Produto
CROSS JOIN DimCurrency AS Moeda;

-- 8. Encontrar vendas sem cadastro de produto correspondente.
SELECT TOP (100)
    Vendas.*
FROM FactInternetSales AS Vendas
LEFT JOIN DimProduct AS Produto
    ON Produto.ProductKey = Vendas.ProductKey
WHERE Produto.ProductKey IS NULL;
