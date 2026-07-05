# 01 - Seleção

Exemplos básicos e intermediários de consulta em SQL Server.

## O que há aqui

- Seleção de tabela inteira.
- Uso de alias para tabela e colunas.
- Filtros com `WHERE`, `AND`, `OR`, `IN`, `NOT IN`.
- Busca textual com `LIKE` e `NOT LIKE`.
- Filtros por datas em formato `yyyymmdd`.
- Coluna calculada no `SELECT`.

## Recomendações

- Prefira `SELECT coluna1, coluna2` em vez de `SELECT *` quando souber quais campos precisa.
- Use `AS` para aliases quando isso deixar o script mais legível.
- Use `IN` para listas de valores; fica mais claro do que repetir vários `OR`.
- Para datas em campos inteiros no padrão `yyyymmdd`, mantenha o formato com 8 dígitos.
- Valide qualquer técnica de performance com plano de execução e índice real da tabela.
