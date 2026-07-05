# Checklist de Chaves

Use este checklist antes de criar relacionamentos, joins ou modelos no Power BI.

## Perguntas rápidas

- A chave da tabela dimensão é única?
- A chave da tabela fato está preenchida?
- Existem chaves na fato que não existem na dimensão?
- Os tipos de dados das chaves são iguais?
- Há espaços, zeros à esquerda ou diferenças de caixa em chaves textuais?
- O join esperado é 1 para N, N para 1 ou N para N?
- O join vai preservar todas as linhas necessárias?
- O total de linhas depois do join faz sentido?

## Sinais de problema

- Total financeiro aumenta depois do join.
- Quantidade de linhas dobra ou multiplica sem explicação.
- Registros somem depois de trocar `LEFT JOIN` por `INNER JOIN`.
- Chave aparentemente igual não casa por tipo diferente, espaço ou formatação.
- Tabela dimensão tem mais de uma linha para a mesma chave.

## Regra prática

Antes de aplicar o join definitivo, rode contagens de aderência. O arquivo `07-joins/analise-aderencia-chaves.sql` traz um roteiro pronto.
