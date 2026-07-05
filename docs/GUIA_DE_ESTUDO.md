# Guia de Estudo SQL

Este guia sugere uma sequência para estudar os materiais do repositório.

## 1. Fundamentos

Comece por `00-fundamentos/comentarios.sql` para entender comentários e leitura básica de scripts.

## 2. Consultas simples

Use `01-selecao/exemplos.sql` para praticar:

- selecionar tabelas;
- escolher colunas;
- renomear campos;
- filtrar linhas;
- procurar texto com `LIKE`;
- trabalhar com intervalos de datas;
- criar coluna calculada.

## 3. Funções

Use `03-funcoes-sql/exemplos.sql` como catálogo. Ele serve para consultar rapidamente como usar funções de texto, número, data, nulos e regras condicionais.

## 4. Relacionamentos

Depois avance para `07-joins/exemplos.sql`. Os joins são essenciais para cruzar tabelas fato e dimensão.

## 5. Agregações

Use `09-group-by/exemplos.sql` para criar indicadores, contagens e somatórios.

## 6. Cargas de dados

Quando precisar importar CSV, consulte `04-arquivos-csv-no-sql/importar-csv.sql`. Use sempre tabela staging antes de mexer na tabela final.

## 7. Power Query

Para Power BI ou Excel, veja `02-sql-power-query/`. A recomendação é empurrar filtros e agregações pesadas para o SQL Server sempre que possível.

## Checklist antes de usar em produção

- Conferir banco, schema, nomes de tabelas e colunas.
- Remover ou justificar `NOLOCK`.
- Trocar caminhos locais de arquivos CSV.
- Validar tipo de dados e tratamento de nulos.
- Rodar primeiro com `TOP` ou filtros pequenos.
- Conferir plano de execução em consultas grandes.
