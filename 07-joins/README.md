# 07 - Joins

Exemplos de junção entre tabelas no SQL Server.

## Tipos cobertos

- `LEFT JOIN`: mantém tudo da tabela da esquerda.
- `RIGHT JOIN`: mantém tudo da tabela da direita.
- `INNER JOIN`: mantém apenas registros com correspondência dos dois lados.
- `FULL OUTER JOIN`: mantém registros de ambos os lados, mesmo sem correspondência.
- Join com chave composta.
- Crossover/cruzamento com `CROSS JOIN`.

## Regra de ouro

Antes de escolher o join, responda: “qual tabela precisa manter todos os registros?”. Essa resposta geralmente define entre `LEFT`, `RIGHT`, `INNER` ou `FULL`.
