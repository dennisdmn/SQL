/*
Objetivo
--------
Descobrir se as tabelas existem, quais colunas possuem e qual volume aproximado sera processado.

Motivo
------
Antes de rodar joins, agregacoes ou updates, confirme que esta usando a tabela correta.
Isso evita processar schema errado, tabela vazia ou layout inesperado.
*/

/* 1. Verificar tabelas disponiveis no schema */
SELECT
    table_schema,
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'staging'
ORDER BY table_name;

/* 2. Verificar colunas de uma tabela */
SELECT
    ordinal_position,
    column_name,
    data_type,
    character_maximum_length,
    numeric_precision,
    numeric_scale,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'staging'
  AND table_name = 'pre_ncarga_candidata'
ORDER BY ordinal_position;

/* 3. Pre-check de volume */
SELECT
    COUNT(*) AS qtd_linhas
FROM staging.pre_ncarga_candidata;

/* 4. Pre-check de campos obrigatorios */
SELECT
    SUM(CASE WHEN chave_recon IS NULL THEN 1 ELSE 0 END) AS qtd_chave_nula,
    SUM(CASE WHEN documento IS NULL THEN 1 ELSE 0 END) AS qtd_documento_nulo,
    SUM(CASE WHEN centro_lucro IS NULL THEN 1 ELSE 0 END) AS qtd_centro_nulo,
    SUM(CASE WHEN valor IS NULL THEN 1 ELSE 0 END) AS qtd_valor_nulo
FROM staging.pre_ncarga_candidata;

/*
Observacao
----------
Em Oracle, a consulta de metadados normalmente usa ALL_TABLES, ALL_TAB_COLUMNS
ou USER_TABLES/USER_TAB_COLUMNS.

Exemplo Oracle:

SELECT owner, table_name
FROM all_tables
WHERE owner = 'STAGING'
ORDER BY table_name;
*/

