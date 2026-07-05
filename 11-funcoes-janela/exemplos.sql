/*
    Funcoes de janela - SQL Server
*/

-- 1. ROW_NUMBER: numera linhas por produto dentro de cada cliente.
SELECT TOP (100)
    CustomerKey,
    ProductKey,
    OrderDateKey,
    SalesAmount,
    ROW_NUMBER() OVER
    (
        PARTITION BY CustomerKey
        ORDER BY OrderDateKey DESC
    ) AS NumeroPedidoCliente
FROM FactInternetSales;

-- 2. Ultima venda de cada cliente.
WITH VendasNumeradas AS
(
    SELECT
        CustomerKey,
        SalesOrderNumber,
        OrderDateKey,
        SalesAmount,
        ROW_NUMBER() OVER
        (
            PARTITION BY CustomerKey
            ORDER BY OrderDateKey DESC, SalesOrderNumber DESC
        ) AS Ordem
    FROM FactInternetSales
)
SELECT *
FROM VendasNumeradas
WHERE Ordem = 1;

-- 3. Ranking de produtos por valor vendido.
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
    ValorVendas,
    RANK() OVER (ORDER BY ValorVendas DESC) AS RankingComSalto,
    DENSE_RANK() OVER (ORDER BY ValorVendas DESC) AS RankingSemSalto
FROM VendasProduto;

-- 4. Percentual do produto no total geral.
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
    ValorVendas,
    SUM(ValorVendas) OVER () AS ValorTotalGeral,
    CAST(100.0 * ValorVendas / NULLIF(SUM(ValorVendas) OVER (), 0) AS DECIMAL(10, 2)) AS PercentualTotal
FROM VendasProduto;

-- 5. Acumulado por data.
WITH VendasDia AS
(
    SELECT
        OrderDateKey,
        SUM(SalesAmount) AS ValorDia
    FROM FactInternetSales
    GROUP BY OrderDateKey
)
SELECT
    OrderDateKey,
    ValorDia,
    SUM(ValorDia) OVER
    (
        ORDER BY OrderDateKey
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ValorAcumulado
FROM VendasDia
ORDER BY OrderDateKey;
