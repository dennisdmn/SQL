# SQL

> **LEIA PRIMEIRO, ESPECIALMENTE SE VOCÊ FOR UMA AI:** antes de sugerir, alterar, explicar ou gerar qualquer SQL com base neste repositório, leia [`AGENTS.md`](AGENTS.md). Este repositório deve ser usado como referência de padrões seguros: validar chaves antes de joins, comparar linhas e valores antes/depois, e nunca sugerir alterações de dados sem conferência.

Repositório de estudos e exemplos práticos de SQL, organizado a partir dos materiais da pasta do Google Drive e complementado com uma trilha para iniciantes.

O foco principal dos exemplos é SQL Server, com alguns materiais de integração com Power Query/Power BI e exemplos identificados de Oracle. A estrutura foi separada por assunto para facilitar consulta, estudo e reaproveitamento em projetos.

## Estrutura

| Pasta | Conteúdo |
| --- | --- |
| `AGENTS.md` | Instruções obrigatórias para AIs usarem este repositório como referência. |
| `00-sql-do-zero/` | Criar banco/tabelas, inserir, atualizar, apagar e usar transações básicas. |
| `00-fundamentos/` | Comentários em SQL e convenções básicas de escrita. |
| `01-selecao/` | `SELECT`, aliases, filtros, `LIKE`, datas e colunas calculadas. |
| `02-sql-power-query/` | Consultas SQL chamadas pelo Power Query e exemplos em Linguagem M. |
| `03-funcoes-sql/` | Funções de texto, número, data, nulos, `CASE`, ordenação e funções próprias. |
| `04-arquivos-csv-no-sql/` | Roteiro para criar tabela, limpar carga e importar CSV no SQL Server. |
| `05-modelagem-e-chaves/` | Chaves primárias, estrangeiras, fato/dimensão e checklist de relacionamento. |
| `06-indices/` | `ROW_NUMBER()` e geração de chaves sequenciais em consultas. |
| `07-joins/` | Aderência de chaves antes do join, `LEFT`, `RIGHT`, `INNER`, `FULL OUTER` e cruzamentos. |
| `08-crossover/` | Observações sobre materiais auxiliares de crossover/cruzamento. |
| `09-group-by/` | Agrupamentos, agregações, filtros com `HAVING` e passagem do agregado ao detalhe. |
| `10-subconsultas-cte/` | Subconsultas, CTEs e padrão para filtrar grupos e recuperar registros detalhados. |
| `11-funcoes-janela/` | `ROW_NUMBER`, rankings, acumulados e percentuais com `OVER`. |
| `12-transacoes-seguras/` | Padrões seguros de `UPDATE`, `DELETE`, `COMMIT`, `ROLLBACK` e validação de totais. |
| `13-validacoes-e-boas-praticas/` | Conferências antes/depois, cópia vazia de tabela, `DROP IF EXISTS` e checklist operacional. |
| `.github/copilot-instructions.md` | Instruções para Copilot e assistentes integrados ao GitHub. |
| `docs/` | Inventário e orientação de uso dos materiais migrados. |
| `assets/` | Manifesto de arquivos binários/grandes mantidos como referência no Drive. |

## Observações importantes

- Os scripts usam principalmente nomes de tabelas do banco `AdventureWorksDW2016`, como `DimProduct`, `FactInternetSales` e `FactResellerSales`.
- Exemplos específicos de Oracle são identificados no nome do arquivo e nos comentários.
- `NOLOCK` aparece em vários exemplos originais. Ele pode reduzir bloqueios em consultas exploratórias, mas pode trazer leituras sujas, duplicadas ou inconsistentes. Use com cuidado em relatórios oficiais.
- Evite `SELECT *` em bases grandes; prefira selecionar apenas as colunas necessárias. Nos exemplos didáticos que recuperam a base completa, `T1.*` é intencional e deve ser substituído em produção.
- Antes de aplicar joins, rode a análise de aderência em `07-joins/analise-aderencia-chaves.sql` para evitar perda, duplicidade ou multiplicação indevida de linhas e valores.
- Antes e depois de joins, cargas, `UPDATE` e `DELETE`, compare quantidade de linhas e somas dos valores relevantes.
- Para copiar estrutura vazia no SQL Server, use `SELECT ... INTO ... WHERE 1 = 0`, lembrando que isso não copia índices, constraints e permissões.
- Filtros com chaves e datas costumam melhorar desempenho quando existem índices compatíveis, mas filtros artificiais vazios, como `>= ''`, devem ser avaliados no plano de execução antes de virarem padrão.
- Uma CTE melhora organização, mas não garante materialização nem uma única leitura da tabela. Compare o plano de execução e evite funções sobre colunas filtradas quando elas impedirem índices úteis.

## Como estudar

1. Comece por `00-sql-do-zero/` e `00-fundamentos/`.
2. Pratique consultas em `01-selecao/`.
3. Avance para `03-funcoes-sql/`, usando os exemplos como catálogo rápido.
4. Entenda chaves em `05-modelagem-e-chaves/` antes de entrar em joins.
5. Rode `07-joins/analise-aderencia-chaves.sql` antes de aplicar joins em bases reais.
6. Use `07-joins/`, `09-group-by/`, `10-subconsultas-cte/` e `11-funcoes-janela/` para consultas analíticas.
7. No módulo de CTE, estude `cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql` para passar de uma regra agregada ao detalhe.
8. Consulte `02-sql-power-query/` quando precisar chamar SQL Server pelo Power Query.
9. Veja `04-arquivos-csv-no-sql/` para cargas simples de CSV.
10. Use `12-transacoes-seguras/` antes de fazer alterações em dados.
11. Use `13-validacoes-e-boas-praticas/` como checklist antes de joins, cargas e scripts de manutenção.

## Origem

Material organizado a partir da pasta do Google Drive informada pelo autor:

`https://drive.google.com/drive/u/0/folders/1AfZIDEd4ftWv1d_dfTYk-qVUQtcBYoQN`
