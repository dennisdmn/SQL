# Dados fake em Excel para praticar SQL

Esta pasta contem bases pequenas e ficticias para praticar as tecnicas da pasta `boas-praticas-sql-para-ia-e-estudo`.

O arquivo principal e:

```text
bases_fake_repasses_sql.xlsx
```

## Abas do workbook

| Aba | Objetivo |
| --- | --- |
| `origem_extracao_1` | Simula a primeira extracao bruta de documentos |
| `origem_extracao_2` | Simula uma segunda extracao que substitui algumas chaves |
| `pre_candidata` | Simula a base candidata apos regra de substituicao por chave |
| `pre_referencia` | Simula uma referencia oficial com pequenos ajustes posteriores |
| `sap_contas_receber` | Simula uma tabela SAP para enriquecer a candidata |
| `controle_lotes` | Exemplo de controle de processamento por lote |
| `resultados_esperados` | Totais esperados para conferencia |

## Exercicios sugeridos

1. Importar as abas para seu banco local.
2. Criar resumos de linhas, chaves, documentos, centros e valor.
3. Comparar `pre_candidata` contra `pre_referencia`.
4. Criar `documento_z12_key` a partir de `documento`.
5. Aplicar match contra `sap_contas_receber` usando regras B/C/D/E.
6. Classificar linhas como `B`, `C`, `D`, `E` ou `SEM_MATCH`.
7. Medir quantas linhas ficaram sem `conta_contrato`, `bupla` ou `vencimento_liquido`.
8. Simular controle por lote usando a aba `controle_lotes`.

## Observacoes

Os dados sao ficticios e foram criados apenas para estudo. Nao representam dados reais de clientes, alunos, empresas ou sistemas corporativos.

O workbook foi pensado para ser pequeno o suficiente para leitura humana e completo o suficiente para uma IA de codificacao usar como exemplo de boas praticas.

