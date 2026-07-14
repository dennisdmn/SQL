# 10 - Subconsultas e CTE

Subconsultas e CTEs ajudam a dividir consultas grandes em etapas menores.

## Quando usar

- Para filtrar uma tabela com base no resultado de outra consulta.
- Para organizar uma regra complexa em blocos legíveis.
- Para reaproveitar um resultado intermediário dentro da mesma consulta.
- Para selecionar chaves por uma condição agregada e depois recuperar as linhas detalhadas dessas chaves.

## Diferença rápida

- **Subconsulta:** fica dentro do `WHERE`, `FROM` ou `SELECT`.
- **CTE:** começa com `WITH Nome AS (...)` e deixa a consulta mais organizada.

## Padrão: filtrar grupos e recuperar detalhes

Veja `cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql`. O exemplo Oracle:

1. filtra as linhas usadas no cálculo;
2. agrupa por `VKONT`;
3. mantém somente grupos cuja `SUM(BETRH)` atende ao `HAVING`;
4. junta as chaves aprovadas à tabela original para recuperar o detalhe.

Esse formato separa claramente a regra agregada da recuperação das linhas. Ele pode ser mais eficiente do que repetir uma soma em subconsultas correlacionadas, porque a agregação é expressa uma vez e o Oracle pode escolher estratégias como hash aggregation e hash join. Isso não é garantia: confirme com o plano de execução, estatísticas atualizadas, seletividade e índices disponíveis.

Um `IN` equivalente não é necessariamente lento; o otimizador pode transformá-lo em semi-join. Use o `JOIN` quando também precisar devolver a soma agregada e prefira a versão mais clara cujo plano seja adequado.
