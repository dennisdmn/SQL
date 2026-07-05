# Inventário da Pasta SQL no Google Drive

Pasta de origem: `https://drive.google.com/drive/u/0/folders/1AfZIDEd4ftWv1d_dfTYk-qVUQtcBYoQN`

Este inventário registra o que foi encontrado no Drive e como foi aproveitado no repositório.

## Raiz

| Item original | Destino no GitHub | Observação |
| --- | --- | --- |
| `Comentarios_SQL_Exemplos.txt` | `00-fundamentos/comentarios.sql` | Migrado como exemplo comentado. |
| `1. SELECAO/` | `01-selecao/` | Migrado e documentado. |
| `2. SQL - PQ/` | `02-sql-power-query/` | Migrado como exemplos M/Power Query. |
| `3. FUNÇÕES PRÓPRIAS SQL/` | `03-funcoes-sql/` | Migrado como catálogo de funções SQL. |
| `4. ARQUIVOS CSV NO SQL/` | `04-arquivos-csv-no-sql/` | Scripts migrados; CSV grande referenciado em manifesto. |
| `6. INDICES/` | `06-indices/` | Migrado como exemplo de `ROW_NUMBER()`. |
| `7. JOINS/` | `07-joins/` | Migrado como guia de junções. |
| `8. CROSSOVER/` | `08-crossover/` | Havia arquivo `.zip`; mantido como referência em manifesto. |
| `9. GROUP BY/` | `09-group-by/` | Migrado como exemplos de agregação. |

## Arquivos grandes ou binários

Arquivos como `.xlsm`, `.pbix`, `.pptx`, `.zip` e o CSV grande não foram gravados diretamente no repositório porque não são bons candidatos para versionamento textual no Git. Eles foram documentados em `assets/MANIFESTO_BINARIOS.md` com os respectivos links do Drive.

## Critério usado

- Conteúdo textual foi transformado em arquivos versionáveis (`.sql`, `.pq`, `.md`).
- Exemplos foram comentados e agrupados por assunto.
- Pontos de atenção foram documentados, especialmente `NOLOCK`, `SELECT *`, filtros artificiais de performance e importação de CSV.
- Materiais binários ficaram referenciados, sem apagar nada do Drive.
