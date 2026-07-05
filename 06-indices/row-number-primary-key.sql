/*
    ROW_NUMBER como chave sequencial da consulta.
    Nao substitui uma chave primaria fisica da tabela.
*/

SELECT
    ROW_NUMBER() OVER (ORDER BY ProductKey) AS Linha,
    ProductKey,
    ProductAlternateKey,
    EnglishProductName
FROM DimProduct
ORDER BY ProductKey;

-- Exemplo usando CTE para filtrar por numero sequencial calculado.
WITH ProdutosNumerados AS
(
    SELECT
        ROW_NUMBER() OVER (ORDER BY ProductKey) AS Linha,
        ProductKey,
        ProductAlternateKey,
        EnglishProductName
    FROM DimProduct
)
SELECT *
FROM ProdutosNumerados
WHERE Linha BETWEEN 1 AND 100;
