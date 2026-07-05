# 05 - Modelagem e Chaves

Este módulo explica conceitos que ajudam a entender joins, qualidade de dados e relacionamento entre tabelas.

## Conceitos essenciais

- **Chave primária:** identifica uma linha de forma única dentro da tabela.
- **Chave estrangeira:** aponta para a chave de outra tabela.
- **Tabela dimensão:** descreve entidades, como cliente, produto, calendário e loja.
- **Tabela fato:** registra eventos ou movimentos, como venda, pagamento, estoque e pedido.
- **Relacionamento 1 para N:** uma linha da dimensão pode se relacionar com muitas linhas da fato.

## Por que isso importa

Antes de fazer join, é preciso saber se a chave realmente funciona como chave. Se houver duplicidade, nulos ou tipos incompatíveis, o join pode sumir com registros, duplicar valores ou gerar totais errados.

## Arquivos

- `modelo-vendas.sql`: exemplo pequeno de modelo com cliente, produto e venda.
- `checklist-chaves.md`: perguntas rápidas antes de relacionar tabelas.
