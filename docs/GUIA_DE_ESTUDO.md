# Guia de Estudo SQL

Este guia sugere uma sequência para estudar os materiais do repositório.

## 1. SQL do zero

Comece por `00-sql-do-zero/sql-do-zero.sql` para entender o ciclo básico:

- criar tabela;
- inserir dados;
- consultar;
- atualizar;
- apagar;
- usar transação com `COMMIT` e `ROLLBACK`.

## 2. Fundamentos

Use `00-fundamentos/comentarios.sql` para entender comentários e leitura básica de scripts.

## 3. Consultas simples

Use `01-selecao/exemplos.sql` para praticar:

- selecionar tabelas;
- escolher colunas;
- renomear campos;
- filtrar linhas;
- procurar texto com `LIKE`;
- trabalhar com intervalos de datas;
- criar coluna calculada.

## 4. Funções

Use `03-funcoes-sql/exemplos.sql` como catálogo. Ele serve para consultar rapidamente como usar funções de texto, número, data, nulos e regras condicionais.

## 5. Modelagem e chaves

Antes de joins, estude `05-modelagem-e-chaves/`. Essa parte explica chave primária, chave estrangeira, tabela fato, tabela dimensão e relacionamento 1 para N.

## 6. Aderência de chaves antes de joins

Antes de cruzar tabelas reais, rode `07-joins/analise-aderencia-chaves.sql` para responder:

- a chave da dimensão é única?
- a chave da fato está preenchida?
- há chaves órfãs na fato?
- o join aumenta indevidamente a quantidade de linhas?
- os tipos das chaves são compatíveis?
- os valores principais permanecem coerentes antes/depois?

Esse passo evita totais errados, duplicidades invisíveis e perda de registros.

## 7. Relacionamentos

Depois avance para `07-joins/exemplos.sql`. Os joins são essenciais para cruzar tabelas fato e dimensão.

## 8. Agregações

Use `09-group-by/exemplos.sql` para criar indicadores, contagens e somatórios. Em seguida, veja `10-subconsultas-cte/cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql` para filtrar grupos com `HAVING` e retornar as linhas detalhadas das chaves aprovadas.

## 9. Subconsultas, CTE e funções de janela

Use:

- `10-subconsultas-cte/exemplos.sql` para organizar consultas em etapas;
- `10-subconsultas-cte/cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql` para o padrão agregado + detalhe no Oracle;
- `11-funcoes-janela/exemplos.sql` para ranking, acumulado, última linha por grupo e percentuais.

No exemplo Oracle, a CTE calcula uma vez a soma por `VKONT` e o `JOIN` recupera o detalhe. Isso pode permitir um plano mais eficiente do que subconsultas correlacionadas, mas deve ser confirmado pelo plano de execução; CTE não garante materialização.

## 10. Cargas de dados

Quando precisar importar CSV, consulte `04-arquivos-csv-no-sql/importar-csv.sql`. Use sempre tabela staging antes de mexer na tabela final.

## 11. Power Query

Para Power BI ou Excel, veja `02-sql-power-query/`. A recomendação é empurrar filtros e agregações pesadas para o SQL Server sempre que possível.

## 12. Alterações seguras

Antes de `UPDATE` ou `DELETE`, consulte:

- `12-transacoes-seguras/update-delete-com-rollback.sql`;
- `12-transacoes-seguras/update-com-validacao-de-totais.sql`.

## 13. Validações operacionais

Use `13-validacoes-e-boas-praticas/` para rotinas de segurança recorrentes:

- comparar linhas e valores antes/depois;
- copiar uma tabela vazia com `SELECT ... INTO ... WHERE 1 = 0`;
- apagar tabela se existir com `DROP TABLE IF EXISTS`;
- lembrar que cópia vazia não carrega índices, chaves e constraints;
- revisar o checklist antes de rodar scripts de manutenção.

## Checklist antes de usar em produção

- Conferir banco, schema, nomes de tabelas e colunas.
- Remover ou justificar `NOLOCK`.
- Trocar caminhos locais de arquivos CSV.
- Validar tipo de dados e tratamento de nulos.
- Validar aderência de chaves antes de joins.
- Comparar linhas e valores antes/depois de joins e atualizações.
- Rodar primeiro com `TOP`, `FETCH FIRST` ou filtros pequenos, conforme o banco.
- Conferir plano de execução em consultas grandes.
- Verificar se funções aplicadas a colunas de filtro impedem o uso de índices.
