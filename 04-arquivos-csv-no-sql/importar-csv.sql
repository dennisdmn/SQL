/*
    04 - Importacao de CSV no SQL Server
    Ajuste nomes de banco, schema, tabela, caminho e delimitador antes de executar.
*/

-- 1. Crie uma tabela staging para receber o arquivo.
CREATE TABLE dbo.Stg_BaseCSV
(
    IdLinha INT IDENTITY(1,1) NOT NULL,
    Coluna01 VARCHAR(255) NULL,
    Coluna02 VARCHAR(255) NULL,
    Coluna03 VARCHAR(255) NULL,
    DataCarga DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

-- 2. Limpe a staging quando a carga for substitutiva.
-- Atenção: TRUNCATE remove todos os registros rapidamente.
TRUNCATE TABLE dbo.Stg_BaseCSV;
GO

-- 3. Importe o CSV.
-- Ajuste FIELDTERMINATOR, ROWTERMINATOR, FIRSTROW e CODEPAGE conforme o arquivo.
BULK INSERT dbo.Stg_BaseCSV
FROM 'C:\\Importacao\\BASE.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

-- 4. Confira a quantidade de linhas importadas.
SELECT COUNT(*) AS QtdeLinhas
FROM dbo.Stg_BaseCSV;

-- 5. Faça validações básicas antes de usar os dados.
SELECT TOP (100) *
FROM dbo.Stg_BaseCSV
ORDER BY IdLinha;

-- 6. Exemplo de tratamento ao mover da staging para uma tabela final.
-- Troque conversoes e colunas pelo layout real do CSV.
/*
INSERT INTO dbo.TabelaFinal
(
    CampoTexto,
    CampoNumero,
    CampoData
)
SELECT
    NULLIF(TRIM(Coluna01), '') AS CampoTexto,
    TRY_CONVERT(DECIMAL(18, 2), REPLACE(Coluna02, ',', '.')) AS CampoNumero,
    TRY_CONVERT(DATE, Coluna03, 103) AS CampoData
FROM dbo.Stg_BaseCSV
WHERE Coluna01 IS NOT NULL;
*/
