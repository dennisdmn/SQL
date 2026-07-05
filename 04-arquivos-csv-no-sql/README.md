# 04 - Arquivos CSV no SQL

Roteiro para importar arquivos CSV no SQL Server.

## Fluxo recomendado

1. Criar uma tabela de destino ou staging.
2. Validar separador, codificação e cabeçalho do CSV.
3. Limpar a tabela staging com `TRUNCATE TABLE` quando for carga substitutiva.
4. Importar com `BULK INSERT` ou assistente do SQL Server.
5. Conferir quantidade de linhas, nulos e tipos de dados.
6. Só depois mover para tabelas finais.

## Cuidados

- Nunca rode `TRUNCATE TABLE` em tabela final sem backup ou confirmação.
- Para CSV grande, prefira staging e validações antes de alimentar modelo final.
- Padronize decimal, datas e encoding do arquivo antes da carga.
