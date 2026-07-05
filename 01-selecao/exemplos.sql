/*
    01 - Seleção
    Exemplos baseados em SQL Server e no banco AdventureWorksDW2016.
*/

-- 1. Seleciona a tabela inteira.
-- Indicado apenas para inspeções pequenas. Em bases grandes, prefira listar colunas.
SELECT *
FROM DimProduct;

-- 2. Seleciona a tabela com alias.
SELECT *
FROM DimProduct AS TabelaProduto;

-- 3. Seleciona usando NOLOCK.
-- Atenção: NOLOCK pode retornar leitura suja ou inconsistente.
SELECT *
FROM DimProduct AS TabProd WITH (NOLOCK);

-- 4. Seleciona colunas específicas.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd;

-- 5. Renomeia colunas usando a sintaxe Alias = Campo.
SELECT
    COD_PRODUTO  = TabProd.ProductKey,
    COD_PRODUTO2 = TabProd.ProductAlternateKey,
    DESC_PRODUTO = TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK);

-- 6. Renomeia colunas usando AS.
SELECT
    TabProd.ProductKey AS COD_PRODUTO,
    TabProd.ProductAlternateKey AS COD_PRODUTO2,
    TabProd.EnglishProductName AS DESC_PRODUTO
FROM DimProduct AS TabProd WITH (NOLOCK);

-- 7. Filtra uma única linha.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.ProductKey = 100;

-- 8. Filtra intervalo simples.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.ProductKey >= 100;

-- 9. Filtra intervalo fechado.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.ProductKey >= 100
  AND TabProd.ProductKey <= 115;

-- 10. Filtra intervalo e remove uma chave específica.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.ProductKey BETWEEN 100 AND 115
  AND TabProd.ProductKey <> 110;

-- 11. Filtra duas chaves com OR.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.ProductKey = 101
   OR TabProd.ProductKey = 107;

-- 12. Filtra lista de chaves com IN.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.ProductKey IN (101, 107, 125);

-- 13. Exclui uma lista de chaves com NOT IN.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.ProductKey NOT IN (1, 2, 3);

-- 14. LIKE equivalente a CONTEM.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.EnglishProductName LIKE '%WASHER%';

-- 15. NOT LIKE equivalente a NAO CONTEM.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.EnglishProductName NOT LIKE '%WASHER%';

-- 16. COMECA COM.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.EnglishProductName LIKE 'LOCK%';

-- 17. TERMINA COM.
SELECT
    TabProd.ProductKey,
    TabProd.ProductAlternateKey,
    TabProd.EnglishProductName
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.EnglishProductName LIKE '%LOCK';

-- 18. Filtro com chave e nome.
-- Observacao: filtros adicionais so melhoram performance quando ajudam o otimizador a usar indices.
-- Evite transformar filtros vazios em padrao sem avaliar o plano de execucao.
SELECT *
FROM DimProduct AS TabProd WITH (NOLOCK)
WHERE TabProd.EnglishProductName = 'BLADE'
  AND TabProd.ProductKey >= 0;

-- 19. Datas em campo no formato yyyymmdd.
SELECT *
FROM FactInternetSales
WHERE ProductKey = 310
  AND ShipDateKey > 20120101
  AND ShipDateKey < 20999999;

-- 20. Datas com BETWEEN.
SELECT *
FROM FactInternetSales
WHERE ProductKey = 310
  AND ShipDateKey BETWEEN 20120101 AND 20999999;

-- 21. Datas ate hoje, convertendo GETDATE para yyyymmdd.
SELECT *
FROM FactInternetSales
WHERE ProductKey = 310
  AND ShipDateKey BETWEEN 20120101 AND CONVERT(INT, CONVERT(VARCHAR(8), GETDATE(), 112));

-- 22. Tabela inteira com coluna calculada.
SELECT
    Vendas.*,
    ((Vendas.UnitPriceDiscountPct / 100.0) * Vendas.ExtendedAmount * -1) AS Desconto
FROM FactResellerSales AS Vendas WITH (NOLOCK);
