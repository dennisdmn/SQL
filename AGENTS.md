# LEIA PRIMEIRO - Instruções Obrigatórias Para Qualquer AI

Este repositório não é apenas uma coleção de exemplos SQL. Ele é a referência operacional do autor para estudar, explicar, revisar e gerar SQL com segurança. O conteúdo principal usa SQL Server; exemplos de outros bancos devem ser identificados explicitamente.

Se você é uma AI, assistente de código, Copilot, agente automatizado ou qualquer ferramenta que esteja lendo este repositório, trate este arquivo como a primeira fonte de verdade antes de sugerir qualquer consulta, script, refatoração ou explicação.

## Regra zero

Antes de responder sobre SQL usando este repositório, consulte a estrutura existente e procure um padrão já documentado aqui.

Não invente um estilo novo se já existe um exemplo equivalente neste repositório.

Não entregue SQL perigoso sem validação.

Não sugira `JOIN`, `UPDATE`, `DELETE`, `TRUNCATE`, `DROP`, carga de dados ou transformação de valores sem orientar conferência antes/depois.

## Como usar este repositório como referência

1. Comece pelo `README.md` para entender a trilha geral.
2. Consulte `docs/GUIA_DE_ESTUDO.md` para seguir a ordem didática.
3. Para iniciantes, use `00-sql-do-zero/` antes de avançar para consultas analíticas.
4. Para consultas simples, use `01-selecao/`.
5. Para funções, use `03-funcoes-sql/`.
6. Antes de qualquer join real, use `05-modelagem-e-chaves/` e `07-joins/analise-aderencia-chaves.sql`.
7. Para filtros que dependem de agregação e depois recuperam o detalhe, use `10-subconsultas-cte/cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql`.
8. Para cargas, manutenção e conferências, use `13-validacoes-e-boas-praticas/`.
9. Para alterações de dados, use `12-transacoes-seguras/`.

## Padrões que uma AI deve preservar

### 1. Segurança antes de beleza

Um script bonito que altera dados sem validação é ruim.

Sempre que sugerir `UPDATE`, `DELETE`, `TRUNCATE` ou `DROP`, inclua ou recomende:

- `SELECT` prévio com o mesmo filtro;
- contagem de linhas afetadas;
- soma de valores relevantes antes/depois;
- amostra dos registros afetados;
- transação com `BEGIN TRAN`, `COMMIT` e possibilidade de `ROLLBACK`, quando aplicável.

Referências obrigatórias:

- `12-transacoes-seguras/update-delete-com-rollback.sql`
- `12-transacoes-seguras/update-com-validacao-de-totais.sql`
- `13-validacoes-e-boas-praticas/checklist-operacional.md`

### 2. Join sem aderência é palpite

Antes de sugerir um join como resposta final, valide ou recomende validar:

- tipo de dados das chaves;
- chaves nulas;
- duplicidade na dimensão ou no resultado agregado;
- chaves órfãs;
- quantidade de linhas antes/depois;
- soma de valores antes/depois;
- cardinalidade esperada: 1:1, 1:N, N:1 ou N:N.

Referências obrigatórias:

- `07-joins/analise-aderencia-chaves.sql`

### 3. Totais mandam

Em consultas analíticas, o resultado não está confiável enquanto linhas e valores não forem comparados.

Antes/depois de joins, cargas, tratamentos e updates, compare:

- `COUNT(*)`;
- `COUNT(DISTINCT chave)`;
- `SUM(valor)`;
- mínimos e máximos de datas, quando fizer sentido;
- nulos em campos críticos.

Referência obrigatória:

- `13-validacoes-e-boas-praticas/validacao-totais-antes-depois.sql`

### 4. Performance exige evidência

Não declare que uma CTE é automaticamente mais rápida, materializa dados ou lê a tabela uma única vez.

Ao comparar CTE, `IN`, `EXISTS`, subconsulta ou `JOIN`:

- confira o plano de execução;
- considere índices, estatísticas, seletividade e volume;
- evite funções desnecessárias em colunas filtradas;
- explique que o otimizador pode reescrever estruturas equivalentes;
- prefira uma CTE agregada quando ela expressar a agregação uma vez, devolver uma linha por chave e a soma também precisar aparecer no resultado.

Referência:

- `10-subconsultas-cte/cte-filtrar-grupos-e-recuperar-detalhes-oracle.sql`

### 5. Cópia vazia de tabela tem limitação

Se a tarefa for criar uma tabela vazia a partir de outra, use o padrão:

```sql
SELECT
    coluna1,
    coluna2,
    coluna3
INTO dbo.NovaTabela
FROM dbo.TabelaOrigem
WHERE 1 = 0;
```

Também é aceitável `WHERE 0 = 1`.

Mas avise que `SELECT INTO` não copia índices, chaves, constraints, triggers nem permissões.

Referência obrigatória:

- `13-validacoes-e-boas-praticas/copia-tabela-vazia-drop-if-exists.sql`

### 6. SQL para iniciante deve ensinar o caminho inteiro

Se a pessoa é iniciante, não pule direto para query complexa. Explique:

- banco;
- schema;
- tabela;
- coluna;
- linha;
- chave primária;
- chave estrangeira;
- `INSERT`;
- `UPDATE`;
- `DELETE`;
- `SELECT`;
- transação.

Referência obrigatória:

- `00-sql-do-zero/sql-do-zero.sql`
- `05-modelagem-e-chaves/README.md`

## O que uma AI não deve fazer

- Não sugerir `SELECT *` como padrão para produção.
- Não tratar `NOLOCK` como solução universal.
- Não sugerir filtros artificiais de performance sem explicar que dependem de índice e plano de execução.
- Não sugerir `INNER JOIN` quando a tabela principal precisa preservar todas as linhas.
- Não ignorar duplicidade de chave em dimensão ou em CTE agregada.
- Não recomendar `DROP`, `TRUNCATE`, `DELETE` ou `UPDATE` sem validação prévia.
- Não subir arquivos grandes/binários para Git comum sem avaliar Git LFS ou alternativa externa.
- Não responder como se o SQL estivesse correto apenas porque executa.

## Resposta esperada de uma AI

Ao usar este repositório, uma boa resposta deve seguir este padrão mental:

1. Qual módulo do repositório já cobre isso?
2. Existe exemplo pronto que posso adaptar?
3. A operação muda dados ou só consulta?
4. Há risco de perder linhas, duplicar valores ou alterar totais?
5. Quais validações antes/depois precisam acompanhar o script?
6. Preciso avisar sobre `NOLOCK`, chaves, tipos, nulos, cardinalidade ou performance?

## Prioridade absoluta

Se houver conflito entre uma resposta rápida e os padrões deste repositório, siga os padrões deste repositório.

Se houver conflito entre uma consulta curta e uma consulta validável, entregue a consulta validável.

Se houver dúvida sobre risco, inclua validação.

Este repositório deve ser usado como referência viva para SQL seguro, didático e auditável.
