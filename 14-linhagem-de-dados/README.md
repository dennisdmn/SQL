# Linhagem de tabelas: exemplos Oracle e SQLite

**Versão da documentação: 1.2.0**

A linhagem ajuda a responder de onde vêm os dados de uma tabela ou relatório. Os exemplos são fictícios e podem ser analisados sem acessar um banco.

## Exemplo Oracle

O [exemplo Oracle](exemplo_oracle.sql) filtra lançamentos de agosto de 2026, calcula débitos menos créditos por empresa e conta e cruza o saldo com o cadastro de contas.

| Papel | Tabela |
| --- | --- |
| Origem | `financeiro.lancamentos` |
| Origem | `cadastro.contas_contabeis` |
| Destino | `relatorios.saldo_contabil_202608` |

Analise com:

```powershell
python scripts/linhagem_sql/analisar_linhagem.py --dialeto oracle
```

## Exemplo SQLite

O [exemplo SQLite complexo](exemplo_sqlite_complexo.sql) calcula a carteira de recebíveis por cliente em 31/08/2026. Ele contém quatro CTEs, duas junções, agregações, tratamento de nulos, cálculo de atraso com `julianday`, `DENSE_RANK()` e classificação de risco.

| Papel | Tabela |
| --- | --- |
| Origem | `financeiro_lancamentos` |
| Origem | `cadastro_contas` |
| Origem | `cadastro_clientes` |
| Destino | `relatorios_carteira_clientes` |

Analise com:

```powershell
python scripts/linhagem_sql/analisar_linhagem.py --dialeto sqlite
```

O exemplo SQLite foi executado em um banco temporário com dados fictícios. A validação retornou dois clientes ativos, com totais em aberto de 1.300 e 600 e rankings de exposição 1 e 2.

## Como interpretar

As CTEs são etapas internas do comando e não aparecem como tabelas físicas de origem. `Dialeto provável` é uma estimativa baseada no texto. `Modo de análise` registra o dialeto informado ao SQLLineage.

Quando o SQL não qualifica uma tabela com schema, o SQLLineage pode mostrar `<default>.tabela`. Esse marcador significa schema não informado. Ele é preservado para evitar atribuir um schema sem evidência.

Antes de executar versões reais desses exemplos, valide unicidade das chaves de cadastro, cardinalidade das junções, quantidade de linhas e totais antes e depois.

O analisador está documentado no [repositório Python](https://github.com/dennisdmn/Python/tree/main/scripts/linhagem_sql).
