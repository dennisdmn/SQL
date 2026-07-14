/*
Objetivo:
1. identificar contas (VKONT) cujo saldo agregado de BETRH seja menor que -0,01;
2. recuperar todas as linhas originais pertencentes a essas contas;
3. repetir a soma calculada em cada linha para facilitar análise e ordenação.

Oracle SQL. A CTE melhora a legibilidade e expõe ao otimizador uma agregação
seguida de junção. Isso pode ser mais eficiente do que recalcular a mesma soma
em subconsultas correlacionadas. A vantagem real depende do plano de execução,
dos índices, da seletividade e da distribuição dos dados.
*/

WITH CONTAS_FILTRADAS AS (
    SELECT
        VKONT,
        SUM(BETRH) AS SOMA_VALOR
    FROM BI.TB_STG_LAKE_SAP_CTAS_RECEB
    WHERE HKONT LIKE '1%'
    GROUP BY
        VKONT
    HAVING
        SUM(BETRH) < -0.01
)
SELECT
    T1.*,
    CF.SOMA_VALOR
FROM BI.TB_STG_LAKE_SAP_CTAS_RECEB T1
INNER JOIN CONTAS_FILTRADAS CF
    ON CF.VKONT = T1.VKONT
ORDER BY
    CF.SOMA_VALOR;

/*
Se o resultado detalhado também precisar conter somente HKONT iniciado por 1,
adicione antes do ORDER BY:

WHERE T1.HKONT LIKE '1%'

Validações recomendadas:
- confirme se VKONT pode ser nulo;
- compare COUNT(*), COUNT(DISTINCT VKONT) e SUM(BETRH);
- verifique se o filtro deve valer apenas para o cálculo ou também para o detalhe;
- compare o plano com a alternativa usando IN;
- evite TRIM(HKONT) se os dados já estiverem normalizados, pois a função pode
  impedir o uso de um índice convencional sobre HKONT.
*/
