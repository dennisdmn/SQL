# SQL

Repositório de estudos e exemplos práticos de SQL, organizado a partir dos materiais da pasta do Google Drive.

O foco principal dos exemplos é SQL Server, com alguns materiais de integração com Power Query/Power BI. A estrutura foi separada por assunto para facilitar consulta, estudo e reaproveitamento em projetos.

## Estrutura

| Pasta | Conteúdo |
| --- | --- |
| `00-fundamentos/` | Comentários em SQL e convenções básicas de escrita. |
| `01-selecao/` | `SELECT`, aliases, filtros, `LIKE`, datas e colunas calculadas. |
| `02-sql-power-query/` | Consultas SQL chamadas pelo Power Query e exemplos em Linguagem M. |
| `03-funcoes-sql/` | Funções de texto, número, data, nulos, `CASE`, ordenação e funções próprias. |
| `04-arquivos-csv-no-sql/` | Roteiro para criar tabela, limpar carga e importar CSV no SQL Server. |
| `06-indices/` | `ROW_NUMBER()` e geração de chaves sequenciais em consultas. |
| `07-joins/` | `LEFT`, `RIGHT`, `INNER`, `FULL OUTER`, chaves compostas e cruzamentos. |
| `08-crossover/` | Observações sobre materiais auxiliares de crossover/cruzamento. |
| `09-group-by/` | Agrupamentos, agregações e filtros com `HAVING`. |
| `docs/` | Inventário e orientação de uso dos materiais migrados. |
| `assets/` | Manifesto de arquivos binários/grandes mantidos como referência no Drive. |

## Observações importantes

- Os scripts usam nomes de tabelas do banco `AdventureWorksDW2016`, como `DimProduct`, `FactInternetSales` e `FactResellerSales`.
- `NOLOCK` aparece em vários exemplos originais. Ele pode reduzir bloqueios em consultas exploratórias, mas pode trazer leituras sujas, duplicadas ou inconsistentes. Use com cuidado em relatórios oficiais.
- Evite `SELECT *` em bases grandes; prefira selecionar apenas as colunas necessárias.
- Filtros com chaves e datas costumam melhorar desempenho quando existem índices compatíveis, mas filtros artificiais vazios, como `>= ''`, devem ser avaliados no plano de execução antes de virarem padrão.

## Como estudar

1. Comece por `00-fundamentos/` e `01-selecao/`.
2. Avance para `03-funcoes-sql/`, usando os exemplos como catálogo rápido.
3. Use `07-joins/` e `09-group-by/` para consultas analíticas.
4. Consulte `02-sql-power-query/` quando precisar chamar SQL Server pelo Power Query.
5. Veja `04-arquivos-csv-no-sql/` para cargas simples de CSV.

## Origem

Material organizado a partir da pasta do Google Drive informada pelo autor:

`https://drive.google.com/drive/u/0/folders/1AfZIDEd4ftWv1d_dfTYk-qVUQtcBYoQN`
