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
- Quando uma alteração pode afetar valores financeiros, quantidades ou indicadores.

## Regra prática

Antes de qualquer `UPDATE` ou `DELETE`, escreva primeiro o `SELECT` com o mesmo `WHERE`. Se o `SELECT` trouxe as linhas certas, só então transforme em alteração.

## Validação mínima

Antes e depois da alteração, confira:

- quantidade de linhas afetadas;
- soma de valores relevantes;
- nulos em campos críticos;
- uma amostra das linhas alteradas;
- se a diferença encontrada bate com a regra aplicada.

## Arquivos

- `update-delete-com-rollback.sql`: padrão básico de alteração com transação.
- `update-com-validacao-de-totais.sql`: exemplo com contagem e soma antes/depois do `UPDATE`.
