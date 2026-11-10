-- Exemplo fictício: carteira de recebíveis por cliente em 31/08/2026.
CREATE TABLE relatorios_carteira_clientes AS
WITH movimentos_validos AS (
    SELECT
        l.cliente_id,
        l.documento_id,
        l.data_vencimento,
        IFNULL(l.valor_debito, 0) - IFNULL(l.valor_credito, 0) AS saldo_documento,
        CAST(
            julianday('2026-08-31') - julianday(l.data_vencimento)
            AS INTEGER
        ) AS dias_atraso
    FROM financeiro_lancamentos AS l
    INNER JOIN cadastro_contas AS c
        ON c.conta_id = l.conta_id
       AND c.natureza = 'RECEBIVEL'
    WHERE date(l.data_contabil) <= date('2026-08-31')
),
resumo_cliente AS (
    SELECT
        cliente_id,
        COUNT(DISTINCT documento_id) AS documentos_abertos,
        ROUND(SUM(saldo_documento), 2) AS total_em_aberto,
        MAX(
            CASE
                WHEN dias_atraso > 0 THEN dias_atraso
                ELSE 0
            END
        ) AS maior_atraso_dias
    FROM movimentos_validos
    WHERE ABS(saldo_documento) > 0.01
    GROUP BY cliente_id
),
clientes_ativos AS (
    SELECT
        c.cliente_id,
        c.nome_cliente,
        c.segmento,
        r.documentos_abertos,
        r.total_em_aberto,
        r.maior_atraso_dias
    FROM resumo_cliente AS r
    INNER JOIN cadastro_clientes AS c
        ON c.cliente_id = r.cliente_id
       AND c.ativo = 1
),
clientes_classificados AS (
    SELECT
        cliente_id,
        nome_cliente,
        segmento,
        documentos_abertos,
        total_em_aberto,
        maior_atraso_dias,
        DENSE_RANK() OVER (
            ORDER BY total_em_aberto DESC
        ) AS ranking_exposicao
    FROM clientes_ativos
)
SELECT
    cliente_id,
    nome_cliente,
    segmento,
    r.documentos_abertos,
    r.total_em_aberto,
    r.maior_atraso_dias,
    r.ranking_exposicao,
    CASE
        WHEN r.maior_atraso_dias > 90 THEN 'ALTO'
        WHEN r.maior_atraso_dias > 30 THEN 'MEDIO'
        ELSE 'BAIXO'
    END AS faixa_risco
FROM clientes_classificados AS r;
