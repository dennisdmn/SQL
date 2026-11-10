# Linhagem de tabelas: exemplo Oracle

A linhagem ajuda a responder de onde vêm os dados de uma tabela ou relatório. O [exemplo Oracle](exemplo_oracle.sql) é fictício: filtra os lançamentos de agosto de 2026, calcula débitos menos créditos por empresa e conta e cruza o saldo com o cadastro de contas.

| Origem | Papel no resultado |
| --- | --- |
| `financeiro.lancamentos` | Fornece empresa, conta, data, débito e crédito. |
| `cadastro.contas_contabeis` | Fornece código e descrição da conta. |

O destino é `relatorios.saldo_contabil_202608`. As CTEs `lancamentos_mes` e `saldo_por_conta` são etapas do mesmo comando `CREATE TABLE ... AS`; por isso, a saída esperada tem um comando e duas tabelas de origem. Se fosse executar uma versão desse SQL em um banco, seria preciso conferir se `conta_id` é único no cadastro e se o `JOIN` mantém as linhas e os saldos esperados. Essa conferência fica fora da análise de linhagem.

## Como analisar

1. Abra o [guia do analisador no repositório Python](https://github.com/dennisdmn/Python/tree/main/scripts/linhagem_sql) e instale `sqllineage` conforme o guia.
2. Na raiz do repositório Python, rode `python scripts/linhagem_sql/analisar_linhagem.py --dialeto oracle`.
3. Na janela, selecione `exemplo_oracle.sql`. O terminal deve mostrar as duas origens e o destino acima.

O analisador lê o arquivo como texto. Não é necessário acessar o Oracle nem criar as tabelas do exemplo.
