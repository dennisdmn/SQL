/*
Objetivo
--------
Comparar origem, candidata e referencia por volume, chaves, documentos, centros e valor.

Motivo
------
Conciliacao nao deve olhar apenas o total financeiro. Uma base pode ter o mesmo valor,
mas documentos ou chaves diferentes.
*/

/* 1. Resumo geral de varias bases */
SELECT
    'origem_excel' AS base,
    COUNT(*) AS qtd_linhas,
    COUNT(DISTINCT chave_recon) AS qtd_chaves,
    COUNT(DISTINCT documento) AS qtd_documentos,
    COUNT(DISTINCT centro_lucro) AS qtd_centros_lucro,
    SUM(COALESCE(valor, 0)) AS total_valor
FROM staging.origem_excel

UNION ALL

SELECT
    'candidata' AS base,
    COUNT(*) AS qtd_linhas,
    COUNT(DISTINCT chave_recon) AS qtd_chaves,
    COUNT(DISTINCT documento) AS qtd_documentos,
    COUNT(DISTINCT centro_lucro) AS qtd_centros_lucro,
    SUM(COALESCE(valor, 0)) AS total_valor
FROM staging.pre_ncarga_candidata

UNION ALL

SELECT
    'referencia' AS base,
    COUNT(*) AS qtd_linhas,
    COUNT(DISTINCT chave_recon) AS qtd_chaves,
    COUNT(DISTINCT documento) AS qtd_documentos,
    COUNT(DISTINCT centro_lucro) AS qtd_centros_lucro,
    SUM(COALESCE(valor, 0)) AS total_valor
FROM oficial.pre_ncarga_referencia;

/* 2. Comparacao por chave */
WITH cand AS (
    SELECT
        chave_recon,
        COUNT(*) AS linhas_cand,
        COUNT(DISTINCT documento) AS documentos_cand,
        SUM(COALESCE(valor, 0)) AS valor_cand
    FROM staging.pre_ncarga_candidata
    GROUP BY chave_recon
),
ref AS (
    SELECT
        chave_recon,
        COUNT(*) AS linhas_ref,
        COUNT(DISTINCT documento) AS documentos_ref,
        SUM(COALESCE(valor, 0)) AS valor_ref
    FROM oficial.pre_ncarga_referencia
    GROUP BY chave_recon
)
SELECT
    COALESCE(c.chave_recon, r.chave_recon) AS chave_recon,
    CASE
        WHEN c.chave_recon IS NOT NULL AND r.chave_recon IS NOT NULL THEN 'COMUM'
        WHEN c.chave_recon IS NOT NULL THEN 'SOMENTE_CANDIDATA'
        ELSE 'SOMENTE_REFERENCIA'
    END AS status_chave,
    COALESCE(c.linhas_cand, 0) AS linhas_cand,
    COALESCE(r.linhas_ref, 0) AS linhas_ref,
    COALESCE(c.linhas_cand, 0) - COALESCE(r.linhas_ref, 0) AS dif_linhas,
    COALESCE(c.documentos_cand, 0) AS documentos_cand,
    COALESCE(r.documentos_ref, 0) AS documentos_ref,
    COALESCE(c.valor_cand, 0) AS valor_cand,
    COALESCE(r.valor_ref, 0) AS valor_ref,
    COALESCE(c.valor_cand, 0) - COALESCE(r.valor_ref, 0) AS dif_valor
FROM cand c
FULL OUTER JOIN ref r
    ON c.chave_recon = r.chave_recon;

/*
Adaptacao
---------
SQLite nao suporta FULL OUTER JOIN diretamente. Nesse caso, use UNION de LEFT JOINs.
*/

