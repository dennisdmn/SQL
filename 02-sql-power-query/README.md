# 02 - SQL com Power Query

Esta pasta reúne exemplos de conexão do Power Query com SQL Server.

## Abordagens

1. Navegar pelo banco com `Sql.Database` e aplicar transformações em M.
2. Enviar uma consulta SQL nativa pelo parâmetro `Query`.
3. Criar uma função M parametrizada para reaproveitar servidor e banco.

## Quando usar consulta nativa SQL

Use SQL nativo quando a regra for melhor executada pelo banco, principalmente em filtros, joins, agregações e seleção de poucas colunas. Isso evita trazer volume desnecessário para o Power Query.

## Atenção

- Troque `NOTEBOOK-VAIO\\SQLEXPRESS` pelo seu servidor.
- Troque `AdventureWorksDW2016` pelo banco real.
- Evite concatenar parâmetros digitados pelo usuário diretamente em SQL; prefira parâmetros controlados ou consultas validadas.
