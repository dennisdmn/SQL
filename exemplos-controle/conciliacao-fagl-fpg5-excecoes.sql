/*
Objetivo: demonstrar, de forma simbólica e simples, como conciliar duas bases
          e administrar exceções por tabela auxiliar.

Contexto: exemplo inspirado em conciliação FAGL x FPG5.
Dialeto: SQL genérico, com pequenos ajustes possivelmente necessários conforme o banco.

Ideia principal:
- A conciliação técnica mostra o que bateu ou divergiu.
- A tabela de exceções registra o que foi aceito, justificado ou ficou pendente.
- O status final não apaga o status técnico original.
*/

/* ============================================================
   1. Bases simbólicas
   ============================================================ */

CREATE TABLE fagl_contabil (
    empresa      VARCHAR(10),
    conta_razao  VARCHAR(20),
    chave_recon  VARCHAR(50),
    valor_fagl   DECIMAL(18, 2)
);

CREATE TABLE fpg5_operacional (
    empresa      VARCHAR(10),
    conta_razao  VARCHAR(20),
    chave_recon  VARCHAR(50),
    valor_fpg5   DECIMAL(18, 2)
);

CREATE TABLE excecoes_conciliacao (
    empresa        VARCHAR(10),
    conta_razao    VARCHAR(20),
    chave_recon    VARCHAR(50),
    tipo_excecao   VARCHAR(30),
    justificativa  VARCHAR(255),
    status_excecao VARCHAR(30),
    responsavel    VARCHAR(100),
    data_aprovacao DATE
);

/* ============================================================
   2. Dados pequenos para aprendizado
   ============================================================ */

INSERT INTO fagl_contabil (empresa, conta_razao, chave_recon, valor_fagl) VALUES
('3000', '1102010002', 'CHV001', 100.00),
('3000', '1102010002', 'CHV002', 250.00),
('3000', '1102010002', 'CHV003', 500.00),
('3000', '1102010002', 'CHV004', 900.00);

INSERT INTO fpg5_operacional (empresa, conta_razao, chave_recon, valor_fpg5) VALUES
('3000', '1102010002', 'CHV001', 100.00),
('3000', '1102010002', 'CHV002', 240.00),
('3000', '1102010002', 'CHV005', 700.00);

INSERT INTO excecoes_conciliacao (
    empresa,
    conta_razao,
    chave_recon,
    tipo_excecao,
    justificativa,
    status_excecao,
    responsavel,
    data_aprovacao
) VALUES
('3000', '1102010002', 'CHV002', 'ACEITAR_DIFERENCA', 'Diferença validada manualmente no fechamento.', 'APROVADA', 'Controladoria', DATE '2026-05-22'),
('3000', '1102010002', 'CHV004', 'AGUARDAR_REPROCESSAMENTO', 'Chave ainda não apareceu na base operacional.', 'PENDENTE', 'Controladoria', DATE '2026-05-22');

/* ============================================================
   3. Conciliação técnica
   ============================================================

   Observação:
   - FULL JOIN permite enxergar itens existentes apenas em uma das bases.
   - COALESCE monta a chave consolidada quando um dos lados está ausente.
*/

WITH conciliacao_tecnica AS (
    SELECT
        COALESCE(fagl.empresa, fpg5.empresa) AS empresa,
        COALESCE(fagl.conta_razao, fpg5.conta_razao) AS conta_razao,
        COALESCE(fagl.chave_recon, fpg5.chave_recon) AS chave_recon,
        fagl.valor_fagl,
        fpg5.valor_fpg5,
        COALESCE(fagl.valor_fagl, 0) - COALESCE(fpg5.valor_fpg5, 0) AS diferenca,
        CASE
            WHEN fagl.chave_recon IS NOT NULL
             AND fpg5.chave_recon IS NOT NULL
             AND ABS(fagl.valor_fagl - fpg5.valor_fpg5) <= 0.01
                THEN 'CONCILIADO'
            WHEN fagl.chave_recon IS NOT NULL
             AND fpg5.chave_recon IS NULL
                THEN 'SOMENTE_FAGL'
            WHEN fagl.chave_recon IS NULL
             AND fpg5.chave_recon IS NOT NULL
                THEN 'SOMENTE_FPG5'
            ELSE 'DIVERGENTE'
        END AS status_tecnico
    FROM fagl_contabil fagl
    FULL JOIN fpg5_operacional fpg5
        ON  fagl.empresa = fpg5.empresa
        AND fagl.conta_razao = fpg5.conta_razao
        AND fagl.chave_recon = fpg5.chave_recon
)

/* ============================================================
   4. Resultado final com exceções
   ============================================================

   A tabela de exceções não elimina a divergência.
   Ela apenas muda a classificação final para fins operacionais.
*/

SELECT
    c.empresa,
    c.conta_razao,
    c.chave_recon,
    c.valor_fagl,
    c.valor_fpg5,
    c.diferenca,
    c.status_tecnico,
    e.tipo_excecao,
    e.justificativa,
    e.status_excecao,
    e.responsavel,
    e.data_aprovacao,
    CASE
        WHEN e.status_excecao = 'APROVADA'
            THEN 'EXCECAO_APROVADA'
        WHEN e.status_excecao = 'PENDENTE'
            THEN 'PENDENTE_COM_JUSTIFICATIVA'
        ELSE c.status_tecnico
    END AS status_final
FROM conciliacao_tecnica c
LEFT JOIN excecoes_conciliacao e
    ON  c.empresa = e.empresa
    AND c.conta_razao = e.conta_razao
    AND c.chave_recon = e.chave_recon
ORDER BY
    c.empresa,
    c.conta_razao,
    c.chave_recon;

/* ============================================================
   5. Leitura esperada do exemplo
   ============================================================

   CHV001: conciliada automaticamente.
   CHV002: divergente tecnicamente, mas exceção aprovada.
   CHV003: somente FAGL, sem exceção.
   CHV004: somente FAGL, com justificativa pendente.
   CHV005: somente FPG5, sem exceção.

   Aprendizado:
   - status_tecnico mostra a verdade da comparação.
   - status_final mostra a decisão operacional após exceções.
*/
