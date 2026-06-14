# Guia de organização do repositório SQL

## Finalidade

Este guia define um padrão simples para manter o repositório organizado, legível e útil como apoio profissional.

## Critérios de organização

### 1. Organizar por tema

Prefira separar scripts por assunto:

```text
SELECAO/
SALDOS/
SQLite/
exemplos-controle/
docs/
```

### 2. Nomear arquivos de forma descritiva

Use nomes que expliquem o objetivo do script.

Exemplos:

```text
consulta_tabela_com_alias.sql
saldo_acumulado_com_partition_by.sql
conciliacao_fagl_fpg5_excecoes.sql
```

### 3. Documentar o dialeto SQL

No cabeçalho do script, informe se o exemplo é:

- SQL genérico;
- T-SQL;
- SQLite;
- Oracle SQL;
- PostgreSQL;
- outro dialeto específico.

### 4. Separar aprendizado técnico de aplicação de negócio

Exemplos de sintaxe devem ficar em pastas técnicas, como `SELECAO` ou `SALDOS`.

Casos com contexto de Controladoria, FP&A, conciliação, auditoria ou fechamento mensal devem ficar em `exemplos-controle`.

### 5. Evitar exceções escondidas no código

Quando houver IDs, chaves, contratos ou documentos excepcionados, prefira criar uma tabela de exceções.

Exemplo conceitual:

```text
base_origem
base_destino
tabela_excecoes
resultado_final
```

Assim, a regra fica auditável e reaproveitável.

## Padrão sugerido para cabeçalho de scripts

```sql
/*
Objetivo: explicar de forma curta o que o script faz.
Dialeto: SQL genérico / T-SQL / SQLite / Oracle SQL.
Contexto: estudo, conciliação, conferência, saldo, auditoria etc.
Observação: adaptar nomes de tabelas e colunas antes de usar em produção.
*/
```

## Padrão recomendado para commits

Use mensagens curtas e objetivas:

```text
docs: atualiza README principal
feat: adiciona exemplo de conciliação com exceções
refactor: reorganiza scripts de seleção
chore: padroniza nomes de arquivos
```

## Próximas evoluções sugeridas

- Renomear scripts antigos para incluir extensão `.sql`.
- Criar README específico em cada pasta.
- Separar exemplos por dialeto SQL.
- Criar casos aplicados de Controladoria, como conciliação, aging, saldos e conferência de valores.
