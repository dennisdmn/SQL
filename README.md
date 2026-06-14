# SQL

Repositório de estudos, exemplos e referências práticas de SQL, com foco em consultas, manipulação de tabelas, saldos acumulados, SQLite, T-SQL e casos de uso aplicados à Controladoria, FP&A e conciliações financeiras.

## Objetivo

Este repositório serve como base de consulta profissional para exemplos simples e reutilizáveis de SQL.

A proposta é manter scripts pequenos, comentados e fáceis de adaptar para rotinas de análise, auditoria, conciliação, conferência de bases e estudos de linguagem SQL.

## Estrutura sugerida

```text
SQL/
├── SELECAO/                  # Consultas SELECT, filtros, alias, renomeação e boas práticas de leitura
├── SALDOS/                   # Exemplos de saldo acumulado, janelas e cálculos com OVER/PARTITION BY
├── SQLite/                   # Comandos específicos de SQLite
├── exemplos-controle/        # Casos simbólicos aplicados à Controladoria e conciliações
├── docs/                     # Documentação de apoio, padrões e guias de uso
└── README.md                 # Visão geral do repositório
```

## Como usar

1. Escolha a pasta pelo assunto.
2. Leia o `README.md` da pasta, quando existir.
3. Abra o script SQL correspondente.
4. Adapte nomes de tabelas, colunas, filtros e sintaxe ao banco utilizado.

## Padrões recomendados

- Usar nomes de arquivos descritivos.
- Informar o dialeto SQL quando houver comandos específicos, por exemplo: T-SQL, SQLite, Oracle SQL, PostgreSQL ou SQL genérico.
- Comentar o objetivo do script no início do arquivo.
- Evitar regras de negócio escondidas em listas fixas dentro do código.
- Para exceções operacionais, preferir tabela de exceções em vez de `WHERE NOT IN (...)` fixo no script.

## Caso aplicado incluído

Foi incluído um exemplo simbólico e simples de conciliação entre duas fontes, inspirado no raciocínio FAGL x FPG5:

- base contábil;
- base operacional;
- tabela de exceções;
- conciliação técnica;
- classificação final após exceções.

Consulte:

```text
exemplos-controle/conciliacao-fagl-fpg5-excecoes.sql
```

## Observação profissional

Este repositório não deve ser visto apenas como coleção de comandos SQL, mas como uma biblioteca pessoal de padrões analíticos. A evolução natural é separar os scripts por finalidade de negócio, manter documentação mínima e registrar aprendizados reutilizáveis para rotinas futuras.
