# Boas praticas SQL para IA e estudo humano

Esta pasta reune tecnicas de SQL usadas em rotinas reais de conciliacao, carga incremental, validacao de dados e enriquecimento com bases externas.

O objetivo e servir para dois publicos:

1. Pessoas iniciantes em SQL que querem entender a tecnica, o motivo e o uso pratico.
2. Agentes de IA de codificacao que precisam de exemplos de padroes seguros antes de alterar dados.

Os exemplos usam SQL tradicional sempre que possivel. Quando uma tecnica depende do banco, ha observacoes para adaptar em Oracle, SQL Server, PostgreSQL, SQLite ou SAS PROC SQL.

## Principios

1. Validar antes de alterar.
2. Trabalhar primeiro em tabelas temporarias ou de staging.
3. Normalizar chaves antes de comparar.
4. Medir volume, chaves e valores em cada etapa.
5. Processar bases grandes em lotes.
6. Criar checkpoints para permitir retomada.
7. Separar consulta, validacao e gravacao definitiva.
8. Nunca registrar credenciais em scripts ou logs.

## Mapa dos exemplos

| Arquivo | Tema | Quando usar |
| --- | --- | --- |
| `01_metadados_e_prechecks.sql` | Metadados e validacao inicial | Antes de ler ou transformar tabelas |
| `02_resumos_e_conciliacao.sql` | Totais, chaves e diferencas | Para comparar origem, candidata e referencia |
| `03_normalizacao_de_chaves.sql` | Texto, zeros a esquerda e chaves padronizadas | Quando documentos nao batem por formato |
| `04_joins_por_regras_priorizadas.sql` | Regras B/C/D/E com prioridade | Para enriquecer uma base com regras sequenciais |
| `05_processamento_por_lotes.sql` | Lotes e listas de documentos | Para evitar consultas pesadas em tabelas grandes |
| `06_checkpoint_e_retomada.sql` | Checkpoint fisico e retomada | Para processamentos longos e sujeitos a queda |
| `PROMPT_AUTOMACAO.md` | Prompt para automacoes | Para orientar uma IA a seguir estes padroes |

## Mini fluxo recomendado

```text
1. Inventariar tabelas e colunas.
2. Criar uma base candidata em staging.
3. Normalizar chaves de comparacao.
4. Medir totais da candidata.
5. Comparar candidata contra referencia.
6. Enriquecer com regras priorizadas.
7. Validar cobertura e divergencias.
8. Processar completo com lote e checkpoint.
9. So depois considerar gravacao definitiva.
```

## Padrao de seguranca

Nao coloque senha real em SQL, scripts, logs ou exemplos.

Use placeholders ou mecanismos seguros:

```sql
-- Exemplo conceitual, nao usar senha real:
-- PASSWORD = '***'
```

Em automacoes, se aparecer uma credencial em log ou conversa, nao repita o segredo. Oriente rotacao, revogacao e limpeza/restricao dos logs.

