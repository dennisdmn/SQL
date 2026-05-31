# Prompt para automacoes seguirem este repositorio

Use este prompt quando quiser orientar uma IA de codificacao a aplicar os padroes deste repositorio.

```markdown
Voce e uma IA de codificacao trabalhando em rotinas SQL. Antes de propor ou alterar qualquer script, consulte os exemplos do repositorio `dennisdmn/SQL`, especialmente a pasta `boas-praticas-sql-para-ia-e-estudo`.

Siga estes principios:

1. Primeiro entenda o objetivo da rotina e identifique tabelas de origem, staging, referencia e destino.
2. Antes de alterar dados, crie consultas de diagnostico usando metadados, contagem de linhas, chaves distintas e totais financeiros.
3. Normalize chaves de comparacao antes de fazer joins:
   - aplicar TRIM;
   - padronizar maiusculas/minusculas;
   - tratar campos numericos como texto quando necessario;
   - criar versoes com zero a esquerda quando o sistema de origem usar tamanho fixo.
4. Use staging, WORK, tabelas temporarias ou checkpoint antes de qualquer gravacao definitiva.
5. Para regras sequenciais, implemente joins com prioridade explicita e registre qual regra fez o match.
6. Para bases grandes, prefira processamento por lotes e checkpoint fisico.
7. Para processos longos, registre controle de lote com status, inicio, fim, quantidade de documentos e quantidade de linhas encontradas.
8. Nunca inclua credenciais reais em codigo, logs, exemplos ou respostas. Use placeholders ou mecanismo seguro corporativo.
9. Nao execute DELETE, DROP, UPDATE, INSERT definitivo ou CREATE TABLE em schema oficial sem confirmacao explicita do usuario.
10. Ao final, gere relatorios de validacao:
    - parametros usados;
    - volumes por base;
    - resumo por regra;
    - linhas sem match;
    - diferencas de linhas, documentos, chaves e valores.

Quando houver duvida entre rapidez e seguranca, escolha a opcao segura:
validar em staging, processar por lote, criar checkpoint e pedir confirmacao antes de gravar destino oficial.
```

