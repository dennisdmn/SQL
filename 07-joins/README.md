# 07 - Joins

Exemplos de junção entre tabelas no SQL Server.

## Antes de fazer join

Rode primeiro `analise-aderencia-chaves.sql`. Esse roteiro verifica se as chaves estão prontas para relacionamento e ajuda a evitar três problemas comuns:

- linhas da tabela principal desaparecendo;
- valores duplicando por chave repetida na dimensão;
- join aumentando a quantidade de linhas sem explicação.

## O que validar

- Tipo de dados das chaves.
- Chaves nulas na tabela fato.
- Duplicidades na chave da dimensão.
- Chaves órfãs: existem na fato, mas não existem na dimensão.
- Cobertura percentual do relacionamento.
- Quantidade de linhas antes e depois do join.

## Tipos cobertos

- `LEFT JOIN`: mantém tudo da tabela da esquerda.
- `RIGHT JOIN`: mantém tudo da tabela da direita.
- `INNER JOIN`: mantém apenas registros com correspondência dos dois lados.
- `FULL OUTER JOIN`: mantém registros de ambos os lados, mesmo sem correspondência.
- Join com chave composta.
- Crossover/cruzamento com `CROSS JOIN`.

## Join com resultado agregado

Uma CTE agregada pode funcionar como um conjunto de chaves qualificadas. Ao fazer `INNER JOIN` desse conjunto com a base original, o resultado mantém o detalhe apenas das chaves que passaram pelo `HAVING` e pode incluir o total agregado sem recalculá-lo.

Veja `../10-subconsultas-cte/cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql`. Antes de usar, confirme que a CTE devolve no máximo uma linha por chave; caso contrário, o join pode multiplicar linhas e valores.

## Regra de ouro

Antes de escolher o join, responda: “qual tabela precisa manter todos os registros?”. Essa resposta geralmente define entre `LEFT`, `RIGHT`, `INNER` ou `FULL`.

Antes de confiar no resultado, compare a quantidade de linhas e os totais principais antes e depois do join.
