/*
    UPDATE com validacao de linhas e valores
    ----------------------------------------
    Objetivo: alterar dados com conferencia antes/depois e possibilidade de ROLLBACK.

    Exemplo didatico:
    aplicar um ajuste de 10% no SalesAmount de uma tabela staging.
*/

/*
    1. Conferir o impacto antes do UPDATE.
*/
SELECT
    'ANTES_UPDATE' AS Etapa,
    COUNT(*) AS QtdeLinhas,
    SUM(SalesAmount) AS ValorVendas,
    MIN(SalesAmount) AS MenorValor,
    MAX(SalesAmount) AS MaiorValor
FROM dbo.Stg_FactInternetSales
WHERE OrderDateKey >= 20260101;

/*
    2. Guardar baseline em variaveis para comparar depois.
*/
DECLARE @LinhasAntes BIGINT;
DECLARE @ValorAntes DECIMAL(19, 4);

SELECT
    @LinhasAntes = COUNT(*),
    @ValorAntes = SUM(SalesAmount)
FROM dbo.Stg_FactInternetSales
WHERE OrderDateKey >= 20260101;

/*
    3. Executar dentro de transacao.
*/
BEGIN TRAN;

UPDATE dbo.Stg_FactInternetSales
SET SalesAmount = SalesAmount * 1.10
WHERE OrderDateKey >= 20260101;

/*
    4. Conferir quantas linhas foram afetadas na sessao atual.
*/
SELECT @@ROWCOUNT AS LinhasAfetadasPeloUpdate;

/*
    5. Comparar antes/depois ainda dentro da transacao.
*/
SELECT
    @LinhasAntes AS LinhasAntes,
    COUNT(*) AS LinhasDepois,
    COUNT(*) - @LinhasAntes AS DifLinhas,
    @ValorAntes AS ValorAntes,
    SUM(SalesAmount) AS ValorDepois,
    SUM(SalesAmount) - @ValorAntes AS DifValor
FROM dbo.Stg_FactInternetSales
WHERE OrderDateKey >= 20260101;

/*
    6. Conferir amostra das linhas alteradas.
*/
SELECT TOP (100) *
FROM dbo.Stg_FactInternetSales
WHERE OrderDateKey >= 20260101
ORDER BY OrderDateKey;

/*
    7. Se estiver correto, confirme.
*/
COMMIT;

/*
    8. Se estiver errado, use ROLLBACK no lugar do COMMIT.
*/
-- ROLLBACK;

/*
    Observacao:
    Se o update deveria alterar valores, DifValor deve mudar conforme a regra.
    Se o update deveria alterar apenas classificacao/status, valores financeiros deveriam permanecer iguais.
*/
