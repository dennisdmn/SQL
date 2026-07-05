# 12 - Transações Seguras

Transações ajudam a testar alterações antes de confirmar mudanças no banco.

## Ideia central

- `BEGIN TRAN`: inicia uma transação.
- `COMMIT`: confirma a alteração.
- `ROLLBACK`: desfaz a alteração.

## Quando usar

- Antes de `UPDATE` em massa.
- Antes de `DELETE`.
- Em rotinas que precisam alterar mais de uma tabela de forma consistente.

## Regra prática

Antes de qualquer `UPDATE` ou `DELETE`, escreva primeiro o `SELECT` com o mesmo `WHERE`. Se o `SELECT` trouxe as linhas certas, só então transforme em alteração.
