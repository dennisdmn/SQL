/*
Objetivo
--------
Padronizar campos usados em comparacoes, especialmente documentos financeiros.

Motivo
------
Muitas falhas de match acontecem porque uma tabela guarda documento como numero
sem zeros a esquerda e outra guarda como texto com tamanho fixo.

Exemplo:
    11113593593
    011113593593

Sao o mesmo documento se a regra do sistema usa 12 posicoes com zero a esquerda.
*/

/* 1. Normalizar texto basico */
CREATE TABLE staging.pre_candidata_normalizada AS
SELECT
    TRIM(CAST(chave_recon AS VARCHAR(100))) AS chave_recon_key,
    UPPER(TRIM(CAST(empresa AS VARCHAR(20)))) AS empresa_key,
    UPPER(TRIM(CAST(polo AS VARCHAR(100)))) AS polo_key,
    TRIM(CAST(documento AS VARCHAR(100))) AS documento_key,
    UPPER(TRIM(CAST(centro_lucro AS VARCHAR(100)))) AS centro_lucro_key,
    valor
FROM staging.pre_ncarga_candidata;

/* 2. Criar versao com zero a esquerda */
-- PostgreSQL / Oracle-like:
SELECT
    documento_key,
    LPAD(documento_key, 12, '0') AS documento_z12_key
FROM staging.pre_candidata_normalizada;

/* 3. Exemplo em SQL Server */
SELECT
    documento_key,
    RIGHT(REPLICATE('0', 12) + documento_key, 12) AS documento_z12_key
FROM staging.pre_candidata_normalizada;

/* 4. Usar as duas formas no match */
SELECT
    a.documento_key,
    a.documento_z12_key,
    s.opbel
FROM staging.pre_candidata_normalizada a
LEFT JOIN sap.contas_receber s
    ON a.documento_key = s.opbel
    OR a.documento_z12_key = s.opbel;

/*
Boa pratica
-----------
Crie colunas padronizadas com sufixo _key:
    documento_key
    documento_z12_key
    centro_lucro_key
    empresa_key

Assim voce preserva o dado original e deixa claro qual coluna e usada para join.
*/

