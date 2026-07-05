/*
    Subconsultas e CTE - SQL Server
*/

-- 1. Subconsulta no WHERE.
-- Produtos que tiveram venda.
SELECT
    Produto.ProductKey,
    Produto.EnglishProductName
FROM DimProduct AS Produto
WHERE Produto.ProductKey IN
(
    SELECT DISTINCT Vendas.ProductKey
    FROM FactInternetSales AS Vendas
);

-- 2. Subconsulta no FROM.
-- Primeiro agrega vendas por produto; depois filtra o agregado.
SELECT
    VendasProduto.ProductKey,
    VendasProduto.ValorVendas
FROM
(
    SELECT
        ProductKey,
        SUM(SalesAmount) AS ValorVendas
    FROM FactInternetSales
    GROUP BY ProductKey
) AS VendasProduto
WHERE VendasProduto.ValorVendas > 10000;

-- 3. CTE para deixar a mesma regra mais legivel.
WITH VendasProduto AS
(
    SELECT
        ProductKey,
        SUM(SalesAmount) AS ValorVendas
    FROM FactInternetSales
    GROUP BY ProductKey
)
SELECT
    ProductKey,
    ValorVendas
FROM VendasProduto
WHERE ValorVendas > 10000
ORDER BY ValorVendas DESC;

-- 4. CTE em etapas.
WITH VendasProduto AS
(
    SELECT
        ProductKey,
        SUM(SalesAmount) AS ValorVendas
    FROM FactInternetSales
    GROUP BY ProductKey
),
ProdutosClassificados AS
(
    SELECT
        ProductKey,
        ValorVendas,
        CASE
            WHEN ValorVendas >= 100000 THEN 'ALTO'
            WHEN ValorVendas >= 10000 THEN 'MEDIO'
            ELSE 'BAIXO'
        END AS FaixaVendas
    FROM VendasProduto
)
SELECT *
FROM ProdutosClassificados
ORDER BY ValorVendas DESC;
