-- Exemplo ficticio: saldo contábil por empresa e conta em agosto de 2026.
CREATE TABLE relatorios.saldo_contabil_202608 AS
WITH lancamentos_mes AS (
    SELECT
        l.empresa_id,
        l.conta_id,
        NVL(l.debito, 0) - NVL(l.credito, 0) AS movimento
    FROM financeiro.lancamentos l
    WHERE l.data_contabil >= DATE '2026-08-01'
      AND l.data_contabil <  DATE '2026-09-01'
),
saldo_por_conta AS (
    SELECT
        m.empresa_id,
        m.conta_id,
        SUM(m.movimento) AS saldo
    FROM lancamentos_mes m
    GROUP BY m.empresa_id, m.conta_id
)
SELECT
    s.empresa_id,
    c.codigo_conta,
    c.descricao_conta,
    s.saldo
FROM saldo_por_conta s
JOIN cadastro.contas_contabeis c
    ON c.conta_id = s.conta_id;
