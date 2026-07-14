# Instruções Para Copilot e Assistentes de AI

Antes de sugerir qualquer SQL neste repositório, leia `AGENTS.md` e trate aquelas regras como obrigatórias.

## Prioridade

1. Siga `AGENTS.md`.
2. Consulte `README.md` para localizar o módulo correto.
3. Use os exemplos existentes antes de criar padrões novos.
4. Para `JOIN`, use primeiro `07-joins/analise-aderencia-chaves.sql`.
5. Para filtro por condição agregada seguido de detalhe, consulte `10-subconsultas-cte/cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql`.
6. Para `UPDATE`, `DELETE`, `TRUNCATE` ou `DROP`, use `12-transacoes-seguras/` e `13-validacoes-e-boas-praticas/`.

## Regras rápidas

- Não sugira alteração de dados sem validação antes/depois.
- Não sugira join analítico sem comparação de linhas e valores.
- Não trate `NOLOCK` como padrão seguro.
- Não use `SELECT *` como padrão de produção.
- Sempre que houver risco financeiro ou de indicador, compare `COUNT(*)` e `SUM(valor)` antes/depois.
- Não afirme que uma CTE é automaticamente mais rápida ou materializada; confirme performance no plano de execução.
- Ao juntar uma CTE agregada ao detalhe, confirme que ela devolve uma linha por chave para não multiplicar registros.

Este repositório privilegia SQL seguro, auditável e didático.
