# Boas praticas SQL para IA e estudo humano

Esta pasta e um guia didatico de tecnicas SQL usadas em rotinas reais de conciliacao, validacao, carga incremental, enriquecimento de dados e processamento de bases grandes.

Ela foi criada para ser usada por dois publicos:

1. **Estudo humano**: apoiar quem esta aprendendo SQL com exemplos comentados, objetivos claros e motivos praticos.
2. **IA de codificacao**: servir como referencia de padroes seguros antes de uma automacao propor, alterar ou executar scripts SQL.

Os exemplos usam SQL tradicional sempre que possivel. Algumas tecnicas precisam de adaptacao conforme o banco, principalmente em Oracle, SQL Server, PostgreSQL, SQLite, MySQL ou SAS PROC SQL.

## Objetivos da pasta

1. Mostrar tecnicas SQL que reduzem risco em processos de dados.
2. Ensinar como validar uma base antes de alterar ou publicar dados.
3. Demonstrar como comparar origem, candidata e referencia.
4. Explicar como normalizar chaves para evitar falsos erros de match.
5. Mostrar como aplicar regras de enriquecimento com prioridade.
6. Ensinar processamento por lotes e checkpoint para bases grandes.
7. Criar uma referencia objetiva para automacoes futuras.

## Principios gerais

1. **Validar antes de alterar**: nenhum `UPDATE`, `DELETE`, `INSERT` definitivo ou carga oficial deve acontecer antes de diagnosticos.
2. **Usar staging**: trabalhe primeiro em tabelas temporarias, schemas de staging, `WORK`, `TEMP` ou checkpoint.
3. **Normalizar chaves**: antes de comparar, padronize texto, espacos, maiusculas, tipos e zeros a esquerda.
4. **Medir em cada etapa**: conte linhas, chaves, documentos, centros e valores totais.
5. **Comparar por granularidade**: alem do total financeiro, compare por chave, documento, centro e valor.
6. **Processar por lotes**: bases grandes devem ser divididas para reduzir risco, tempo de bloqueio e consumo de recursos.
7. **Criar checkpoint**: processos longos precisam de retomada a partir do ultimo lote concluido.
8. **Separar validacao de gravacao**: primeiro prove em staging; so depois considere gravacao definitiva.
9. **Proteger credenciais**: nunca escreva senha, token ou segredo em codigo, logs, commits ou exemplos.
10. **Registrar decisoes**: consultas devem deixar claro o que foi filtrado, agregado, conciliado e descartado.

## Mapa dos arquivos

| Arquivo | Tema | Objetivo |
| --- | --- | --- |
| `01_metadados_e_prechecks.sql` | Metadados e pre-checks | Verificar tabelas, colunas, volumes e campos obrigatorios antes de processar |
| `02_resumos_e_conciliacao.sql` | Resumos e conciliacao | Comparar origem, candidata e referencia por linhas, chaves, documentos, centros e valores |
| `03_normalizacao_de_chaves.sql` | Normalizacao de chaves | Padronizar texto, tratar zeros a esquerda e criar colunas tecnicas de comparacao |
| `04_joins_por_regras_priorizadas.sql` | Joins por regras | Aplicar regras sequenciais de match, preservando a base principal |
| `05_processamento_por_lotes.sql` | Processamento por lotes | Dividir documentos em lotes para consultar bases grandes com menor risco |
| `06_checkpoint_e_retomada.sql` | Checkpoint e retomada | Salvar progresso de lotes e permitir retomada apos queda de sessao |
| `dados-fake-excel/` | Bases ficticias em Excel | Praticar as tecnicas com dados pequenos e auditaveis |
| `PROMPT_AUTOMACAO.md` | Prompt para IA | Orientar uma automacao a seguir estes padroes em tarefas futuras |

## Como estudar

Uma boa ordem de estudo e:

1. Leia este `README.md`.
2. Abra `01_metadados_e_prechecks.sql` para entender como inspecionar o ambiente.
3. Estude `02_resumos_e_conciliacao.sql` para aprender a comparar bases.
4. Leia `03_normalizacao_de_chaves.sql` antes de qualquer join importante.
5. Estude `04_joins_por_regras_priorizadas.sql` para entender match por prioridade.
6. Use `05_processamento_por_lotes.sql` quando o volume for grande.
7. Use `06_checkpoint_e_retomada.sql` para processos longos.
8. Abra `dados-fake-excel/bases_fake_repasses_sql.xlsx` para praticar com bases pequenas.
9. Use `PROMPT_AUTOMACAO.md` para orientar uma IA de codificacao.

## Bases fake para pratica

A subpasta `dados-fake-excel/` contem um workbook pequeno e ficticio:

```text
dados-fake-excel/bases_fake_repasses_sql.xlsx
```

Ele inclui abas para treinar:

1. Extracao principal.
2. Extracao complementar que substitui chaves.
3. Base candidata.
4. Base de referencia.
5. Base SAP fake.
6. Controle de lotes.
7. Resultados esperados.

Use esse workbook para importar os dados em SQLite, PostgreSQL, SQL Server, Oracle ou outra ferramenta de estudo e reproduzir os exemplos desta pasta.

## Fluxo recomendado de trabalho

```text
1. Inventariar tabelas, colunas e schemas.
2. Validar se as entradas obrigatorias existem.
3. Medir volume inicial.
4. Criar uma base candidata em staging.
5. Normalizar chaves de comparacao.
6. Gerar resumo geral da candidata.
7. Comparar candidata contra referencia.
8. Investigar divergencias por chave.
9. Enriquecer dados por regras priorizadas.
10. Medir cobertura de match.
11. Processar completo em lotes, se necessario.
12. Salvar checkpoints de progresso.
13. Gerar relatorios finais.
14. Somente entao avaliar gravacao definitiva.
```

## Tecnicas cobertas

### 1. Consulta de metadados

Serve para descobrir se a tabela existe, quais colunas tem e se o layout esta correto.

Exemplo:

```sql
SELECT
    table_schema,
    table_name,
    table_type
FROM information_schema.tables
WHERE table_schema = 'staging'
ORDER BY table_name;
```

Use antes de montar qualquer script longo.

### 2. Pre-check de campos obrigatorios

Serve para identificar nulos em chaves essenciais.

Exemplo:

```sql
SELECT
    SUM(CASE WHEN chave_recon IS NULL THEN 1 ELSE 0 END) AS qtd_chave_nula,
    SUM(CASE WHEN documento IS NULL THEN 1 ELSE 0 END) AS qtd_documento_nulo,
    SUM(CASE WHEN valor IS NULL THEN 1 ELSE 0 END) AS qtd_valor_nulo
FROM staging.pre_ncarga_candidata;
```

Se uma chave obrigatoria vier nula, o join ou a conciliacao podem gerar conclusoes erradas.

### 3. Resumo de conciliacao

Serve para comparar bases por varios indicadores, nao apenas por valor.

Indicadores recomendados:

1. Quantidade de linhas.
2. Quantidade de chaves distintas.
3. Quantidade de documentos distintos.
4. Quantidade de centros de lucro distintos.
5. Soma do valor.

### 4. Normalizacao de chaves

Serve para evitar falsos `SEM_MATCH`.

Exemplo comum:

```text
11113593593
011113593593
```

Esses valores podem representar o mesmo documento se o sistema de destino usa 12 posicoes com zeros a esquerda.

Tecnicas usadas:

```sql
TRIM()
UPPER()
CAST()
LPAD()
COALESCE()
```

### 5. Joins por regras priorizadas

Serve para aplicar varias regras de match em ordem.

Exemplo conceitual:

```text
Regra B: empresa + polo + documento original + centro
Regra C: empresa + documento original + centro
Regra D: empresa + documento original + centro com restricao especifica
Regra E: empresa + polo + documento de compensacao + centro
```

O resultado deve informar qual regra fez o match:

```sql
CASE
    WHEN b.conta_contrato_sap IS NOT NULL THEN 'B'
    WHEN c.conta_contrato_sap IS NOT NULL THEN 'C'
    WHEN d.conta_contrato_sap IS NOT NULL THEN 'D'
    WHEN e.conta_contrato_sap IS NOT NULL THEN 'E'
    ELSE 'SEM_MATCH'
END AS regra_match
```

### 6. Processamento por lotes

Serve para bases grandes.

Em vez de consultar milhoes de documentos de uma vez, crie lotes:

```sql
CEILING(ROW_NUMBER() OVER (ORDER BY documento_busca) / 900.0) AS lote
```

Motivos para usar lotes:

1. Reduzir consumo de memoria.
2. Evitar timeout.
3. Controlar progresso.
4. Permitir retomada.
5. Facilitar diagnostico de gargalos.

### 7. Checkpoint e retomada

Serve para nao recomecar do zero se a execucao cair.

O checkpoint deve registrar:

1. Numero do lote.
2. Quantidade de documentos.
3. Quantidade de linhas encontradas.
4. Data/hora de inicio.
5. Data/hora de fim.
6. Status do lote.

Exemplo:

```sql
SELECT
    COALESCE(MAX(lote), 0) AS ultimo_lote_processado
FROM checkpoint.controle_lotes
WHERE status_lote = 'PROCESSADO';
```

### 8. Relatorios finais

Ao final, gere pelo menos:

1. Parametros usados.
2. Volumes por base.
3. Controle por lote.
4. Resumo do recorte externo.
5. Resumo por regra de match.
6. Amostra sem match.
7. Amostra com match.
8. Totais finais da candidata.

## Padroes de nome

Use nomes claros e tecnicos:

```text
*_candidata
*_referencia
*_normalizada
*_recorte
*_controle_lotes
*_resumo_geral
*_resumo_match
*_sem_match
```

Para chaves padronizadas, prefira:

```text
chave_recon_key
empresa_key
polo_key
documento_key
documento_z12_key
centro_lucro_key
```

## Adaptacao por banco

### Oracle

Metadados:

```sql
SELECT owner, table_name
FROM all_tables
WHERE owner = 'STAGING';
```

Zero a esquerda:

```sql
LPAD(documento, 12, '0')
```

Atencao: historicamente, `IN (...)` tem limite de 1000 expressoes. Use lotes menores, como 900.

### SQL Server

Zero a esquerda:

```sql
RIGHT(REPLICATE('0', 12) + documento, 12)
```

Data/hora atual:

```sql
GETDATE()
```

### PostgreSQL

Zero a esquerda:

```sql
LPAD(documento, 12, '0')
```

Data/hora atual:

```sql
CURRENT_TIMESTAMP
```

### SQLite

SQLite e simples e otimo para estudo, mas nao tem tudo que bancos corporativos tem.

Pontos de atencao:

1. `FULL OUTER JOIN` precisa ser simulado com `UNION`.
2. Tipos sao mais flexiveis.
3. Algumas funcoes variam em relacao a Oracle/PostgreSQL/SQL Server.

## Como uma IA deve usar esta pasta

Uma IA de codificacao deve:

1. Ler o `README.md` antes de propor alteracoes SQL sensiveis.
2. Usar os arquivos numerados como exemplos de padroes.
3. Preferir consultas de diagnostico antes de qualquer mudanca.
4. Criar staging/checkpoint quando houver risco.
5. Evitar gravacao definitiva sem confirmacao explicita.
6. Explicar quais tecnicas do guia esta usando.
7. Apontar riscos de performance quando houver join grande, `GROUP BY` amplo ou leitura completa de tabela externa.

## O que uma IA nao deve fazer

1. Nao deve escrever senha real em script.
2. Nao deve rodar `DELETE`, `DROP`, `TRUNCATE`, `UPDATE` ou `INSERT` definitivo sem confirmacao.
3. Nao deve substituir uma tabela oficial sem validacao.
4. Nao deve ignorar divergencias pequenas sem registrar.
5. Nao deve assumir que documentos numericos e textuais batem sem normalizacao.
6. Nao deve processar base enorme de uma vez se lote/checkpoint for viavel.

## Checklist antes de gravar dados definitivos

Antes de qualquer carga oficial, confirme:

1. A origem esta correta.
2. A candidata foi criada em staging.
3. As chaves foram normalizadas.
4. Os totais batem ou as diferencas foram explicadas.
5. A cobertura de match foi medida.
6. Linhas sem match foram avaliadas.
7. O script foi testado em amostra.
8. O processamento completo foi validado.
9. O plano de rollback existe.
10. O usuario aprovou explicitamente a gravacao.

## Padrao de seguranca

Nao coloque senha real, token, hash, connection string sensivel ou segredo em:

1. Scripts SQL.
2. Markdown.
3. Logs.
4. Commits.
5. Comentarios.
6. Exemplos.
7. Prompts.

Use placeholders:

```sql
-- Exemplo conceitual, nao usar senha real:
-- PASSWORD = '***'
```

Ou mecanismos corporativos:

1. Conexao salva.
2. Vault.
3. Variavel de ambiente segura.
4. Auth domain.
5. Secret manager.

Se uma credencial aparecer acidentalmente, nao repita o segredo. Oriente rotacao, revogacao e limpeza/restricao dos logs.

## Resultado esperado

Ao seguir estes exemplos, uma rotina SQL deve produzir:

1. Menos risco operacional.
2. Mais rastreabilidade.
3. Diagnosticos claros.
4. Reprocessamento controlado.
5. Melhor entendimento para humanos.
6. Melhores instrucoes para IAs de codificacao.
