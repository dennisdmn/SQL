/*
    09 - GROUP BY e HAVING
*/

-- 1. Conta produtos por cor.
SELECT
    Color,
    COUNT(*) AS QtdeProdutos
FROM DimProduct
GROUP BY Color
ORDER BY QtdeProdutos DESC;

-- 2. Trata nulos antes de agrupar.
SELECT
    ISNULL(Color, 'SEM COR') AS Cor,
    COUNT(*) AS QtdeProdutos
FROM DimProduct
GROUP BY ISNULL(Color, 'SEM COR')
ORDER BY QtdeProdutos DESC;

-- 3. Soma vendas por produto.
SELECT
    Vendas.ProductKey,
    SUM(Vendas.SalesAmount) AS ValorVendas,
    COUNT(*) AS QtdeLinhas
FROM FactInternetSales AS Vendas
GROUP BY Vendas.ProductKey
ORDER BY ValorVendas DESC;

-- 4. Agrupa por produto trazendo descricao via join.
SELECT
    Produto.ProductKey,
    Produto.EnglishProductName,
    SUM(Vendas.SalesAmount) AS ValorVendas,
    COUNT(*) AS QtdeVendas
FROM FactInternetSales AS Vendas
INNER JOIN DimProduct AS Produto
    ON Produto.ProductKey = Vendas.ProductKey
GROUP BY
    Produto.ProductKey,
    Produto.EnglishProductName
ORDER BY ValorVendas DESC;

-- 5. WHERE filtra linhas antes de agrupar.
SELECT
    Vendas.ProductKey,
    SUM(Vendas.SalesAmount) AS ValorVendas
FROM FactInternetSales AS Vendas
WHERE Vendas.OrderDateKey >= 20120101
GROUP BY Vendas.ProductKey;

-- 6. HAVING filtra o resultado agregado.
SELECT
    Vendas.ProductKey,
    SUM(Vendas.SalesAmount) AS ValorVendas
FROM FactInternetSales AS Vendas
GROUP BY Vendas.ProductKey
HAVING SUM(Vendas.SalesAmount) > 10000
ORDER BY ValorVendas DESC;

-- 7. WHERE + HAVING juntos.
SELECT
    Vendas.ProductKey,
    COUNT(*) AS QtdeVendas,
    SUM(Vendas.SalesAmount) AS ValorVendas
FROM FactInternetSales AS Vendas
WHERE Vendas.OrderDateKey BETWEEN 20120101 AND 20121231
GROUP BY Vendas.ProductKey
HAVING COUNT(*) >= 10
ORDER BY ValorVendas DESC;
