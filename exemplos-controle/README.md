# Exemplos aplicados à Controladoria

Pasta destinada a exemplos simbólicos de SQL aplicados a rotinas de Controladoria, FP&A, auditoria e conciliação.

## Objetivo

Transformar aprendizados conceituais em scripts pequenos, fáceis de entender e reutilizáveis.

## Exemplos incluídos

| Arquivo | Objetivo |
|---|---|
| `conciliacao-fagl-fpg5-excecoes.sql` | Demonstra como conciliar duas bases e aplicar uma tabela de exceções sem esconder a divergência original. |

## Princípio adotado

A conciliação deve preservar duas visões:

1. **Status técnico**: resultado puro da comparação entre as bases.
2. **Status final**: resultado após aplicação de exceções aprovadas, justificadas ou pendentes.

Esse padrão melhora rastreabilidade, governança e explicação futura em fechamento mensal.
