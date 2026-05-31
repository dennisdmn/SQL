/*
Objetivo
--------
Salvar o progresso de processos longos e permitir retomada.

Motivo
------
Se a sessao cair no lote 1500 de 3224, voce nao quer recomecar do zero.
Com checkpoint, o processo continua a partir do ultimo lote concluido.
*/

/* 1. Tabela de controle de lotes */
CREATE TABLE checkpoint.controle_lotes (
    lote INTEGER NOT NULL,
    qtd_docs_lote INTEGER NOT NULL,
    qtd_linhas_encontradas INTEGER NOT NULL,
    dt_inicio_lote TIMESTAMP,
    dt_fim_lote TIMESTAMP,
    status_lote VARCHAR(30) NOT NULL,
    PRIMARY KEY (lote)
);

/* 2. Tabela de resultado incremental */
CREATE TABLE checkpoint.sap_recorte (
    lote INTEGER,
    empresa_sap VARCHAR(20),
    bupla_sap VARCHAR(100),
    conta_contrato_sap VARCHAR(100),
    polo_sap VARCHAR(100),
    documento_original_sap VARCHAR(100),
    documento_compensacao_sap VARCHAR(100),
    centro_lucro_sap VARCHAR(100),
    vencimento_liquido_sap DATE,
    augrd_sap VARCHAR(10),
    indicador_estatistico VARCHAR(20),
    bloqueio_compensacao VARCHAR(20)
);

/* 3. Descobrir ultimo lote concluido */
SELECT
    COALESCE(MAX(lote), 0) AS ultimo_lote_processado
FROM checkpoint.controle_lotes
WHERE status_lote = 'PROCESSADO';

/* 4. Definir proximo lote */
-- Pseudocodigo:
-- proximo_lote = ultimo_lote_processado + 1

/* 5. Evitar reprocessamento */
SELECT
    COUNT(*) AS lote_ja_processado
FROM checkpoint.controle_lotes
WHERE lote = 123
  AND status_lote = 'PROCESSADO';

/* 6. Registrar sucesso do lote */
INSERT INTO checkpoint.controle_lotes (
    lote,
    qtd_docs_lote,
    qtd_linhas_encontradas,
    dt_inicio_lote,
    dt_fim_lote,
    status_lote
)
VALUES (
    123,
    900,
    6455,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    'PROCESSADO'
);

/*
Cuidados
--------
1. Grave checkpoint em schema ou pasta separada.
2. Nunca apague tabelas oficiais para reiniciar um checkpoint.
3. Se precisar reiniciar, apague somente tabelas do proprio checkpoint.
4. Relatorios finais devem mostrar quantos lotes foram processados e quantos faltam.
*/

