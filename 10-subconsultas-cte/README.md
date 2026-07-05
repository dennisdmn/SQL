# 10 - Subconsultas e CTE

Subconsultas e CTEs ajudam a dividir consultas grandes em etapas menores.

## Quando usar

- Para filtrar uma tabela com base no resultado de outra consulta.
- Para organizar uma regra complexa em blocos legíveis.
- Para reaproveitar um resultado intermediário dentro da mesma consulta.

## Diferença rápida

- **Subconsulta:** fica dentro do `WHERE`, `FROM` ou `SELECT`.
- **CTE:** começa com `WITH Nome AS (...)` e deixa a consulta mais organizada.
