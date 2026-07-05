# 11 - Funções de Janela

Funções de janela calculam rankings, acumulados e comparações sem perder o nível de detalhe das linhas.

## Funções úteis

- `ROW_NUMBER()`: numeração única por ordenação.
- `RANK()`: ranking com empate e salto.
- `DENSE_RANK()`: ranking com empate sem salto.
- `SUM() OVER`: total por grupo ou acumulado.
- `LAG()` e `LEAD()`: valor anterior e próximo.

## Quando usar

- Deduplicar registros.
- Pegar o último pedido de cada cliente.
- Criar ranking de vendas.
- Calcular acumulado por data.
