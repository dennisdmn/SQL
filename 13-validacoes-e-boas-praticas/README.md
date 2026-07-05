# 13 - Validações e Boas Práticas Operacionais

Este módulo reúne padrões práticos para evitar erros silenciosos em SQL.

## Ideia central

Antes e depois de uma operação importante, confira pelo menos:

- quantidade de linhas;
- soma de valores relevantes;
- quantidade de chaves distintas;
- nulos em campos críticos;
- impacto esperado da alteração.

## Conteúdos

- `copia-tabela-vazia-drop-if-exists.sql`: recriar tabela, copiar estrutura vazia com `WHERE 1 = 0` e observar limitações.
- `validacao-totais-antes-depois.sql`: comparar linhas e valores antes/depois de joins, cargas e transformações.
- `checklist-operacional.md`: checklist rápido para rodar antes de mexer em dados.

## Regras práticas

- Antes de `JOIN`, compare linhas e valores antes/depois.
- Antes de `UPDATE`, rode um `SELECT` com o mesmo `WHERE`.
- Antes de `DELETE`, rode um `SELECT COUNT(*)` e amostra das linhas afetadas.
- Antes de recriar tabela, confirme se ela pode ser descartada.
- Para cópia vazia de estrutura no SQL Server, use `SELECT ... INTO ... WHERE 1 = 0`.
- Lembre que `SELECT INTO` copia colunas e tipos básicos, mas não copia índices, chaves, constraints, triggers nem permissões.
