# 09 - GROUP BY

Exemplos de agrupamento em SQL Server, com referência complementar a um padrão Oracle.

## Conteúdos

- Agregações com `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`.
- Agrupamento por uma ou mais colunas.
- Diferença entre `WHERE` e `HAVING`.
- Uso do resultado agregado como filtro para recuperar registros detalhados.

## Diferença rápida

- `WHERE` filtra linhas antes do agrupamento.
- `HAVING` filtra grupos depois do agrupamento.

## Do agregado ao detalhe

Quando a regra depende da soma por chave, mas o resultado precisa manter todas as colunas originais, faça a agregação em uma CTE e depois relacione as chaves aprovadas à base detalhada. O exemplo está em `../10-subconsultas-cte/cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql`.

A soma recebe um alias na CTE e deve ser referenciada pelo alias da CTE, não como `T1.SUM(coluna)`. O padrão evita recalcular a mesma agregação em cada linha e permite que o otimizador escolha uma estratégia de agregação e junção. Valide a vantagem no plano de execução.
