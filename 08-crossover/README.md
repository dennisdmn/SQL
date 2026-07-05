# 08 - Crossover

A pasta original continha um arquivo de apoio compactado (`Apoio.zip`). Como o conteúdo está em formato binário/compactado, ele foi registrado no manifesto em `assets/MANIFESTO_BINARIOS.md`.

## Conceito útil

Em SQL, crossover normalmente aparece como cruzamento de possibilidades, combinação de listas ou comparação entre conjuntos. Dependendo do caso, isso pode ser feito com:

- `CROSS JOIN`, quando todas as combinações são desejadas.
- `INNER JOIN`, quando só interessam pares correspondentes.
- `LEFT JOIN` com `IS NULL`, quando o objetivo é encontrar itens ausentes em outro conjunto.

## Alerta

`CROSS JOIN` multiplica as linhas das tabelas envolvidas. Uma tabela com 1.000 linhas cruzada com outra de 1.000 linhas gera 1.000.000 de combinações.
