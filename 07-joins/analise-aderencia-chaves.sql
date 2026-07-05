/*
    Analise de aderencia de chaves antes de aplicar JOIN
    ----------------------------------------------------
    Objetivo: validar se as chaves entre uma tabela fato e uma tabela dimensao
    casam corretamente antes de montar uma consulta final.

    Exemplo usado:
    - Fato:      FactInternetSales      alias Fato
    - Dimensao:  DimProduct             alias Dim
    - Chave:     ProductKey
    - Valores:   SalesAmount, TaxAmt, Freight

    Troque os nomes das tabelas e colunas para o seu caso.
*/

/*
    1. Conferir tipo de dados das chaves.
    Se os tipos forem diferentes, o SQL pode converter implicitamente e piorar performance
    ou falhar em chaves textuais com formatos diferentes.
*/
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE (TABLE_NAME = 'FactInternetSales' AND COLUMN_NAME = 'ProductKey')
   OR (TABLE_NAME = 'DimProduct' AND COLUMN_NAME = 'ProductKey')
ORDER BY TABLE_NAME;

/*
    2. Conferir volume, chaves distintas e nulos na chave da fato.
    Chave nula na fato normalmente nao casa com dimensao.
*/
SELECT
    COUNT(*) AS LinhasFato,
    COUNT(ProductKey) AS ChavesPreenchidas,
    COUNT(DISTINCT ProductKey) AS ChavesDistintas,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END) AS ChavesNulas
FROM FactInternetSales;

/*
    3. Conferir se a chave da dimensao e unica.
    Se houver duplicidade na dimensao, o join pode multiplicar linhas e valores.
*/
SELECT
    ProductKey,
    COUNT(*) AS QtdeNaDimensao
FROM DimProduct
GROUP BY ProductKey
HAVING COUNT(*) > 1
ORDER BY QtdeNaDimensao DESC;

/*
    4. Medir cobertura da fato na dimensao.
    Mostra quantas linhas da fato encontram ou nao encontram correspondente na dimensao.
*/
SELECT
    COUNT(*) AS LinhasFato,
    SUM(CASE WHEN Dim.ProductKey IS NOT NULL THEN 1 ELSE 0 END) AS LinhasComCorrespondencia,
    SUM(CASE WHEN Dim.ProductKey IS NULL THEN 1 ELSE 0 END) AS LinhasSemCorrespondencia,
    CAST(
        100.0 * SUM(CASE WHEN Dim.ProductKey IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0)
        AS DECIMAL(5, 2)
    ) AS PercentualAderencia
FROM FactInternetSales AS Fato
LEFT JOIN DimProduct AS Dim
    ON Dim.ProductKey = Fato.ProductKey;

/*
    5. Listar chaves da fato que nao existem na dimensao.
    Use TOP para diagnostico inicial em bases grandes.
*/
SELECT TOP (100)
    Fato.ProductKey,
    COUNT(*) AS QtdeLinhasFato,
    SUM(Fato.SalesAmount) AS ValorVendasSemProduto
FROM FactInternetSales AS Fato
LEFT JOIN DimProduct AS Dim
    ON Dim.ProductKey = Fato.ProductKey
WHERE Dim.ProductKey IS NULL
GROUP BY Fato.ProductKey
ORDER BY ValorVendasSemProduto DESC;

/*
    6. Verificar chaves da dimensao que nao aparecem na fato.
    Isso nao e necessariamente erro; pode indicar produto sem venda no periodo.
*/
SELECT TOP (100)
    Dim.ProductKey,
    Dim.EnglishProductName
FROM DimProduct AS Dim
LEFT JOIN FactInternetSales AS Fato
    ON Fato.ProductKey = Dim.ProductKey
WHERE Fato.ProductKey IS NULL
ORDER BY Dim.ProductKey;

/*
    7. Comparar linhas antes e depois do join.
    Em um relacionamento N:1 esperado, o LEFT JOIN nao deveria aumentar linhas da fato.
*/
SELECT 'Antes do join' AS Etapa, COUNT(*) AS QtdeLinhas
FROM FactInternetSales
UNION ALL
SELECT 'Depois do LEFT JOIN' AS Etapa, COUNT(*) AS QtdeLinhas
FROM FactInternetSales AS Fato
LEFT JOIN DimProduct AS Dim
    ON Dim.ProductKey = Fato.ProductKey;

/*
    8. Comparar linhas e valores antes/depois do join.
    Este e o teste mais importante para relatorios financeiros ou indicadores.
*/
WITH Antes AS
(
    SELECT
        COUNT(*) AS QtdeLinhas,
        COUNT(DISTINCT SalesOrderNumber) AS QtdePedidos,
        COUNT(DISTINCT ProductKey) AS QtdeProdutos,
        SUM(SalesAmount) AS ValorVendas,
        SUM(TaxAmt) AS ValorImposto,
        SUM(Freight) AS ValorFrete
    FROM FactInternetSales
),
Depois AS
(
    SELECT
        COUNT(*) AS QtdeLinhas,
        COUNT(DISTINCT Fato.SalesOrderNumber) AS QtdePedidos,
        COUNT(DISTINCT Fato.ProductKey) AS QtdeProdutos,
        SUM(Fato.SalesAmount) AS ValorVendas,
        SUM(Fato.TaxAmt) AS ValorImposto,
        SUM(Fato.Freight) AS ValorFrete
    FROM FactInternetSales AS Fato
    LEFT JOIN DimProduct AS Dim
        ON Dim.ProductKey = Fato.ProductKey
)
SELECT
    Antes.QtdeLinhas AS LinhasAntes,
    Depois.QtdeLinhas AS LinhasDepois,
    Depois.QtdeLinhas - Antes.QtdeLinhas AS DifLinhas,
    Antes.QtdePedidos AS PedidosAntes,
    Depois.QtdePedidos AS PedidosDepois,
    Depois.QtdePedidos - Antes.QtdePedidos AS DifPedidos,
    Antes.QtdeProdutos AS ProdutosAntes,
    Depois.QtdeProdutos AS ProdutosDepois,
    Depois.QtdeProdutos - Antes.QtdeProdutos AS DifProdutos,
    Antes.ValorVendas AS VendasAntes,
    Depois.ValorVendas AS VendasDepois,
    Depois.ValorVendas - Antes.ValorVendas AS DifVendas,
    Antes.ValorImposto AS ImpostoAntes,
    Depois.ValorImposto AS ImpostoDepois,
    Depois.ValorImposto - Antes.ValorImposto AS DifImposto,
    Antes.ValorFrete AS FreteAntes,
    Depois.ValorFrete AS FreteDepois,
    Depois.ValorFrete - Antes.ValorFrete AS DifFrete
FROM Antes
CROSS JOIN Depois;

/*
    9. Teste de multiplicacao por duplicidade na dimensao.
    Se aparecer resultado, cada linha da fato pode estar encontrando mais de uma linha na dimensao.
*/
SELECT TOP (100)
    Fato.ProductKey,
    COUNT(*) AS LinhasDepoisDoJoin,
    SUM(Fato.SalesAmount) AS ValorVendasDepoisDoJoin
FROM FactInternetSales AS Fato
LEFT JOIN DimProduct AS Dim
    ON Dim.ProductKey = Fato.ProductKey
GROUP BY
    Fato.SalesOrderNumber,
    Fato.SalesOrderLineNumber,
    Fato.ProductKey
HAVING COUNT(*) > 1
ORDER BY LinhasDepoisDoJoin DESC;

/*
    10. Para chaves textuais: normalizar antes de comparar.
    Use quando houver espacos, diferenca de caixa ou zeros a esquerda.
*/
/*
SELECT
    Fato.CodigoProduto,
    Dim.CodigoProduto
FROM MinhaFato AS Fato
LEFT JOIN MinhaDimensao AS Dim
    ON UPPER(TRIM(Dim.CodigoProduto)) = UPPER(TRIM(Fato.CodigoProduto));
*/

/*
    11. Decisao do tipo de join.

    - Use INNER JOIN se so interessam registros com correspondencia dos dois lados.
    - Use LEFT JOIN se a tabela da esquerda precisa ser preservada integralmente.
    - Use FULL OUTER JOIN para auditoria de divergencias entre dois conjuntos.
    - Evite aceitar aumento de linhas ou valores sem explicar a cardinalidade.
*/
