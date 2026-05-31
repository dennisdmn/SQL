/*
Objetivo
--------
Aplicar regras de enriquecimento com prioridade, preservando a base principal.

Motivo
------
Em conciliacoes, uma mesma linha pode ser encontrada por regras diferentes.
E necessario definir uma ordem: B primeiro, depois C, depois D, depois E.

Exemplo de regras:
    B: empresa + polo + documento original + centro, com restricao diferente de 05
    C: empresa + documento original + centro, com restricao diferente de 05
    D: empresa + documento original + centro, com restricao = 05
    E: empresa + polo + documento compensacao + centro, com restricao = 05
*/

/* 1. Base SAP recortada previamente */
WITH sap_base AS (
    SELECT
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        polo_sap,
        documento_original_sap,
        documento_compensacao_sap,
        centro_lucro_sap,
        vencimento_liquido_sap,
        COALESCE(augrd_sap, '01') AS augrd_sap
    FROM staging.sap_recorte
),
regra_b AS (
    SELECT
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        polo_sap,
        documento_original_sap,
        centro_lucro_sap,
        MAX(vencimento_liquido_sap) AS vencimento_liquido_sap
    FROM sap_base
    WHERE augrd_sap <> '05'
    GROUP BY
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        polo_sap,
        documento_original_sap,
        centro_lucro_sap
),
regra_c AS (
    SELECT
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        documento_original_sap,
        centro_lucro_sap,
        MAX(vencimento_liquido_sap) AS vencimento_liquido_sap
    FROM sap_base
    WHERE augrd_sap <> '05'
    GROUP BY
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        documento_original_sap,
        centro_lucro_sap
),
regra_d AS (
    SELECT
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        documento_original_sap,
        centro_lucro_sap,
        MAX(vencimento_liquido_sap) AS vencimento_liquido_sap
    FROM sap_base
    WHERE augrd_sap = '05'
    GROUP BY
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        documento_original_sap,
        centro_lucro_sap
),
regra_e AS (
    SELECT
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        polo_sap,
        documento_compensacao_sap,
        centro_lucro_sap,
        MAX(vencimento_liquido_sap) AS vencimento_liquido_sap
    FROM sap_base
    WHERE augrd_sap = '05'
    GROUP BY
        empresa_sap,
        bupla_sap,
        conta_contrato_sap,
        polo_sap,
        documento_compensacao_sap,
        centro_lucro_sap
)
SELECT
    COALESCE(b.conta_contrato_sap, c.conta_contrato_sap, d.conta_contrato_sap, e.conta_contrato_sap) AS conta_contrato,
    a.chave_recon_key AS chave_recon,
    a.empresa_key AS empresa,
    COALESCE(b.bupla_sap, c.bupla_sap, d.bupla_sap, e.bupla_sap) AS bupla,
    a.polo_key AS polo,
    a.documento_key AS documento,
    a.documento_z12_key AS documento_z12,
    a.centro_lucro_key AS centro_lucro,
    a.valor,
    COALESCE(b.vencimento_liquido_sap, c.vencimento_liquido_sap, d.vencimento_liquido_sap, e.vencimento_liquido_sap) AS vencimento_liquido,
    CASE
        WHEN b.conta_contrato_sap IS NOT NULL THEN 'B'
        WHEN c.conta_contrato_sap IS NOT NULL THEN 'C'
        WHEN d.conta_contrato_sap IS NOT NULL THEN 'D'
        WHEN e.conta_contrato_sap IS NOT NULL THEN 'E'
        ELSE 'SEM_MATCH'
    END AS regra_match
FROM staging.pre_candidata_normalizada a
LEFT JOIN regra_b b
    ON a.empresa_key = b.empresa_sap
   AND a.polo_key = b.polo_sap
   AND (a.documento_key = b.documento_original_sap OR a.documento_z12_key = b.documento_original_sap)
   AND a.centro_lucro_key = b.centro_lucro_sap
LEFT JOIN regra_c c
    ON a.empresa_key = c.empresa_sap
   AND (a.documento_key = c.documento_original_sap OR a.documento_z12_key = c.documento_original_sap)
   AND a.centro_lucro_key = c.centro_lucro_sap
LEFT JOIN regra_d d
    ON a.empresa_key = d.empresa_sap
   AND (a.documento_key = d.documento_original_sap OR a.documento_z12_key = d.documento_original_sap)
   AND a.centro_lucro_key = d.centro_lucro_sap
LEFT JOIN regra_e e
    ON a.empresa_key = e.empresa_sap
   AND a.polo_key = e.polo_sap
   AND (a.documento_key = e.documento_compensacao_sap OR a.documento_z12_key = e.documento_compensacao_sap)
   AND a.centro_lucro_key = e.centro_lucro_sap;

/*
Validacao apos join
-------------------
Sempre faca resumo por regra_match para saber cobertura e valores.
*/

