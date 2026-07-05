/*
    Validacao de totais antes e depois
    ----------------------------------
    Use este roteiro antes/depois de JOIN, carga, tratamento ou transformacao.

    A ideia e comparar:
    - quantidade de linhas;
    - quantidade de chaves distintas;
    - soma de valores;
    - min/max de datas;
    - nulos em campos importantes.
*/

/*
    1. Baseline da tabela principal antes do JOIN.
*/
SELECT
    'ANTES_JOIN' AS Etapa,
    COUNT(*) AS QtdeLinhas,
    COUNT(DISTINCT SalesOrderNumber) AS QtdePedidos,
    COUNT(DISTINCT ProductKey) AS QtdeProdutos,
    SUM(SalesAmount) AS ValorVendas,
    SUM(TaxAmt) AS ValorImposto,
    SUM(Freight) AS ValorFrete,
    MIN(OrderDateKey) AS MenorData,
    MAX(OrderDateKey) AS MaiorData
FROM FactInternetSales;

/*
    2. Medicao depois do JOIN.
    Em relacionamento N:1, as somas da fato devem permanecer iguais.
*/
SELECT
    'DEPOIS_LEFT_JOIN_PRODUTO' AS Etapa,
    COUNT(*) AS QtdeLinhas,
    COUNT(DISTINCT Fato.SalesOrderNumber) AS QtdePedidos,
    COUNT(DISTINCT Fato.ProductKey) AS QtdeProdutos,
    SUM(Fato.SalesAmount) AS ValorVendas,
    SUM(Fato.TaxAmt) AS ValorImposto,
    SUM(Fato.Freight) AS ValorFrete,
    MIN(Fato.OrderDateKey) AS MenorData,
    MAX(Fato.OrderDateKey) AS MaiorData
FROM FactInternetSales AS Fato
LEFT JOIN DimProduct AS Produto
    ON Produto.ProductKey = Fato.ProductKey;

/*
    3. Comparacao lado a lado.
*/
WITH Antes AS
(
    SELECT
        COUNT(*) AS QtdeLinhas,
        COUNT(DISTINCT SalesOrderNumber) AS QtdePedidos,
        SUM(SalesAmount) AS ValorVendas
    FROM FactInternetSales
),
Depois AS
(
    SELECT
        COUNT(*) AS QtdeLinhas,
        COUNT(DISTINCT Fato.SalesOrderNumber) AS QtdePedidos,
        SUM(Fato.SalesAmount) AS ValorVendas
    FROM FactInternetSales AS Fato
    LEFT JOIN DimProduct AS Produto
        ON Produto.ProductKey = Fato.ProductKey
)
SELECT
    Antes.QtdeLinhas AS LinhasAntes,
    Depois.QtdeLinhas AS LinhasDepois,
    Depois.QtdeLinhas - Antes.QtdeLinhas AS DifLinhas,
    Antes.QtdePedidos AS PedidosAntes,
    Depois.QtdePedidos AS PedidosDepois,
    Depois.QtdePedidos - Antes.QtdePedidos AS DifPedidos,
    Antes.ValorVendas AS ValorAntes,
    Depois.ValorVendas AS ValorDepois,
    Depois.ValorVendas - Antes.ValorVendas AS DifValor
FROM Antes
CROSS JOIN Depois;

/*
    4. Validacao apos transformacao ou carga em tabela staging.
*/
SELECT
    'STAGING' AS Etapa,
    COUNT(*) AS QtdeLinhas,
    SUM(SalesAmount) AS ValorVendas,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END) AS ProdutosNulos,
    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END) AS ClientesNulos
FROM dbo.Stg_FactInternetSales;

/*
    5. Regra pratica de leitura do resultado.

    Se DifLinhas = 0 e DifValor = 0:
        join provavelmente preservou a fato.

    Se DifLinhas > 0 ou DifValor aumentou:
        pode haver duplicidade na dimensao ou join N:N.

    Se DifLinhas < 0 ou DifValor reduziu:
        algum filtro ou INNER JOIN pode ter removido linhas da fato.
*/
