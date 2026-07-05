# Checklist Operacional SQL

Use antes de rodar scripts que alteram, cruzam ou recriam dados.

## Antes de JOIN

- A chave da dimensão é única?
- A chave da fato tem nulos?
- Existem chaves da fato sem correspondência na dimensão?
- O total de linhas antes e depois permanece coerente?
- A soma dos valores principais permanece igual quando o join deveria ser N:1?
- O tipo das chaves é igual nos dois lados?

## Antes de UPDATE

- Rodei `SELECT` com o mesmo `WHERE`?
- Sei quantas linhas serão alteradas?
- Sei o valor total antes da alteração?
- Tenho como comparar depois?
- A alteração está dentro de transação quando houver risco?

## Antes de DELETE

- Rodei `SELECT COUNT(*)` com o mesmo `WHERE`?
- Conferi uma amostra das linhas que serão apagadas?
- A tabela é final ou staging?
- Existe backup, carga original ou forma de recompor?

## Antes de DROP ou recriação de tabela

- A tabela pode ser descartada?
- Existem dependências, views, procedures ou relatórios usando a tabela?
- Preciso preservar índices, chaves, constraints ou permissões?
- Se usar `SELECT INTO ... WHERE 1 = 0`, sei que ele não copia todos os metadados?

## Depois da execução

- Comparei linhas antes/depois?
- Comparei somas antes/depois?
- Validei nulos em campos críticos?
- Conferi amostras de registros alterados?
- Registrei qualquer divergência encontrada?
