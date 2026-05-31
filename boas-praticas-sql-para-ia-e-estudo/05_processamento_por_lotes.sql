/*
Objetivo
--------
Processar uma base grande em partes menores.

Motivo
------
Consultas com milhoes de documentos podem travar a sessao, gerar log enorme ou forcar
o banco a fazer plano ruim. Lotes menores permitem controle, medicao e retomada.
*/

/* 1. Criar lista unica de documentos */
CREATE TABLE staging.docs_unicos AS
SELECT DISTINCT documento_key AS documento_busca
FROM staging.pre_candidata_normalizada
WHERE documento_key IS NOT NULL

UNION

SELECT DISTINCT documento_z12_key AS documento_busca
FROM staging.pre_candidata_normalizada
WHERE documento_z12_key IS NOT NULL;

/* 2. Numerar lotes */
-- Exemplo com ROW_NUMBER. Ajuste a sintaxe ao banco.
CREATE TABLE staging.docs_lote AS
SELECT
    documento_busca,
    CEILING(ROW_NUMBER() OVER (ORDER BY documento_busca) / 900.0) AS lote
FROM staging.docs_unicos;

/* 3. Consultar um lote especifico */
SELECT
    documento_busca
FROM staging.docs_lote
WHERE lote = 1;

/* 4. Exemplo conceitual de filtro por lista */
SELECT
    s.*
FROM sap.contas_receber s
WHERE s.bukrs = '3000'
  AND s.stakz IS NULL
  AND s.augrs IS NULL
  AND (
        s.opbel IN ('011113593593', '020204765651')
     OR s.augbl IN ('011113593593', '020204765651')
  );

/*
Observacao
----------
Alguns bancos limitam a quantidade de itens em IN.
Oracle, por exemplo, historicamente limita IN a 1000 expressoes.
Por isso um lote de 900 documentos deixa margem.
*/

/*
Boa pratica
-----------
Registre por lote:
    lote
    qtd_docs_lote
    qtd_linhas_encontradas
    data_inicio
    data_fim
    status
*/

