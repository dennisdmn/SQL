/*
    03 - Funcoes SQL
    Exemplos para SQL Server.
*/

-- 1. COUNT: conta linhas.
SELECT COUNT(*) AS QTD_LINHAS
FROM DimProduct;

-- 2. COUNT com filtro.
SELECT COUNT(*) AS QTD_PRODUTOS_BIKE
FROM DimProduct
WHERE EnglishProductName LIKE '%BIKE%';

-- 3. UPPER e LOWER: padronizam caixa de texto.
SELECT
    EnglishProductName,
    UPPER(EnglishProductName) AS Nome_Maiusculo,
    LOWER(EnglishProductName) AS Nome_Minusculo
FROM DimProduct;

-- 4. LEFT e RIGHT: extraem caracteres das pontas do texto.
SELECT
    ProductAlternateKey,
    LEFT(ProductAlternateKey, 2) AS DoisPrimeiros,
    RIGHT(ProductAlternateKey, 2) AS DoisUltimos
FROM DimProduct;

-- 5. CHARINDEX: localiza a posicao de um texto dentro de outro.
SELECT
    EnglishProductName,
    CHARINDEX('Bike', EnglishProductName) AS PosicaoBike
FROM DimProduct;

-- 6. LEN: mede quantidade de caracteres, desconsiderando espacos finais.
SELECT
    EnglishProductName,
    LEN(EnglishProductName) AS QtdeCaracteres
FROM DimProduct;

-- 7. SUBSTRING: extrai parte de um texto.
SELECT
    ProductAlternateKey,
    SUBSTRING(ProductAlternateKey, 1, 3) AS Prefixo
FROM DimProduct;

-- 8. LTRIM, RTRIM e TRIM: removem espacos.
SELECT
    '  texto com espaco  ' AS Original,
    LTRIM('  texto com espaco  ') AS SemEspacoEsquerda,
    RTRIM('  texto com espaco  ') AS SemEspacoDireita,
    TRIM('  texto com espaco  ') AS SemEspacosLaterais;

-- 9. REPLACE: substitui texto.
SELECT
    EnglishProductName,
    REPLACE(EnglishProductName, 'Bike', 'Bicycle') AS NomeAjustado
FROM DimProduct;

-- 10. CONCAT: concatena campos tratando NULL com mais seguranca que +.
SELECT
    CONCAT(ProductAlternateKey, ' - ', EnglishProductName) AS Produto
FROM DimProduct;

-- 11. REPLICATE: repete caracteres, util para preenchimento.
SELECT
    ProductKey,
    RIGHT(REPLICATE('0', 6) + CAST(ProductKey AS VARCHAR(6)), 6) AS ProductKey_6_Digitos
FROM DimProduct;

-- 12. ABS: valor absoluto.
SELECT
    -125.45 AS ValorOriginal,
    ABS(-125.45) AS ValorAbsoluto;

-- 13. ROUND, FLOOR e CEILING: arredondamentos.
SELECT
    125.678 AS Valor,
    ROUND(125.678, 2) AS Arredondado_2_Casas,
    FLOOR(125.678) AS Arredonda_Para_Baixo,
    CEILING(125.678) AS Arredonda_Para_Cima;

-- 14. GETDATE: data e hora atuais do servidor SQL.
SELECT GETDATE() AS Agora;

-- 15. CONVERT para datas em formatos comuns.
SELECT
    GETDATE() AS DataOriginal,
    CONVERT(DATE, GETDATE()) AS SomenteData,
    CONVERT(VARCHAR(8), GETDATE(), 112) AS Data_YYYYMMDD,
    CONVERT(VARCHAR(10), GETDATE(), 103) AS Data_DDMMYYYY;

-- 16. DATEPART: extrai partes da data.
SELECT
    GETDATE() AS DataReferencia,
    DATEPART(YEAR, GETDATE()) AS Ano,
    DATEPART(MONTH, GETDATE()) AS Mes,
    DATEPART(DAY, GETDATE()) AS Dia,
    DATEPART(WEEKDAY, GETDATE()) AS DiaSemana;

-- 17. DATEADD: soma ou subtrai partes da data.
SELECT
    GETDATE() AS Hoje,
    DATEADD(DAY, 7, GETDATE()) AS Mais_7_Dias,
    DATEADD(MONTH, -1, GETDATE()) AS Menos_1_Mes;

-- 18. IS NULL e IS NOT NULL.
SELECT *
FROM DimProduct
WHERE Color IS NULL;

SELECT *
FROM DimProduct
WHERE Color IS NOT NULL;

-- 19. ISNULL e COALESCE: substituem nulos.
SELECT
    EnglishProductName,
    ISNULL(Color, 'SEM COR') AS Cor_ISNULL,
    COALESCE(Color, 'SEM COR') AS Cor_COALESCE
FROM DimProduct;

-- 20. CASE WHEN: cria classificacoes condicionais.
SELECT
    ProductKey,
    EnglishProductName,
    ListPrice,
    CASE
        WHEN ListPrice IS NULL THEN 'SEM PRECO'
        WHEN ListPrice < 100 THEN 'BAIXO'
        WHEN ListPrice < 1000 THEN 'MEDIO'
        ELSE 'ALTO'
    END AS FaixaPreco
FROM DimProduct;

-- 21. DATEDIFF: calcula diferenca entre datas.
SELECT
    BirthDate,
    DATEDIFF(YEAR, BirthDate, GETDATE()) AS IdadeAproximada
FROM DimCustomer
WHERE BirthDate IS NOT NULL;

-- 22. DATEDIFF com cluster de idade.
SELECT
    CustomerKey,
    BirthDate,
    CASE
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) < 18 THEN 'MENOR DE 18'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 18 AND 30 THEN '18 A 30'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 31 AND 45 THEN '31 A 45'
        WHEN DATEDIFF(YEAR, BirthDate, GETDATE()) BETWEEN 46 AND 60 THEN '46 A 60'
        ELSE 'ACIMA DE 60'
    END AS FaixaEtaria
FROM DimCustomer
WHERE BirthDate IS NOT NULL;

-- 23. ORDER BY: ordenacao crescente e decrescente.
SELECT
    ProductKey,
    EnglishProductName,
    ListPrice
FROM DimProduct
ORDER BY ListPrice DESC, EnglishProductName ASC;

-- 24. Funcao propria: exemplo para calcular idade aproximada.
-- Ajuste o schema e permissoes antes de executar em ambiente real.
CREATE OR ALTER FUNCTION dbo.fn_IdadeAproximada
(
    @DataNascimento DATE,
    @DataReferencia DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Idade INT;

    SET @Idade = DATEDIFF(YEAR, @DataNascimento, @DataReferencia);

    IF DATEADD(YEAR, @Idade, @DataNascimento) > @DataReferencia
        SET @Idade = @Idade - 1;

    RETURN @Idade;
END;
GO

-- 25. Uso da funcao propria.
SELECT
    CustomerKey,
    BirthDate,
    dbo.fn_IdadeAproximada(BirthDate, CONVERT(DATE, GETDATE())) AS Idade
FROM DimCustomer
WHERE BirthDate IS NOT NULL;
