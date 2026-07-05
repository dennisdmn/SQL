/*
    Copia de tabela vazia e recriacao segura - SQL Server
    -----------------------------------------------------
    Objetivo: criar uma tabela com a mesma estrutura basica de outra,
    sem copiar dados.

    Padrao conhecido:
        SELECT ... INTO NovaTabela
        FROM TabelaOrigem
        WHERE 1 = 0;

    Tambem funciona com WHERE 0 = 1. A ideia e criar uma condicao sempre falsa.
*/

/*
    1. Apagar a tabela de destino se ela ja existir.
    SQL Server 2016+.
*/
DROP TABLE IF EXISTS dbo.Stg_FactInternetSales;
GO

/*
    2. Criar uma copia vazia da estrutura basica.
    Copia nomes de colunas e tipos inferidos do SELECT, mas nao copia:
    - primary key;
    - foreign key;
    - indices;
    - constraints;
    - triggers;
    - permissoes;
    - identity em todos os cenarios.
*/
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    ProductKey,
    CustomerKey,
    OrderDateKey,
    SalesAmount,
    TaxAmt,
    Freight
INTO dbo.Stg_FactInternetSales
FROM FactInternetSales
WHERE 1 = 0;
GO

/*
    3. Conferir se a tabela foi criada vazia.
*/
SELECT COUNT(*) AS QtdeLinhas
FROM dbo.Stg_FactInternetSales;

/*
    4. Ver estrutura criada.
*/
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'Stg_FactInternetSales'
ORDER BY ORDINAL_POSITION;

/*
    5. Alternativa para SQL Server antigo, sem DROP TABLE IF EXISTS.
*/
/*
IF OBJECT_ID('dbo.Stg_FactInternetSales', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Stg_FactInternetSales;
END;
GO
*/

/*
    6. Quando quiser apagar dados, mas manter a tabela, use DELETE ou TRUNCATE.
*/
/*
-- Remove todas as linhas e costuma ser mais rapido, mas nao permite WHERE.
TRUNCATE TABLE dbo.Stg_FactInternetSales;

-- Remove linhas com filtro.
DELETE FROM dbo.Stg_FactInternetSales
WHERE OrderDateKey < 20260101;
*/
