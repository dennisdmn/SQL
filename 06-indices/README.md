# 06 - Índices

O material original trazia um exemplo com `ROW_NUMBER() OVER (ORDER BY ...)`, útil para gerar uma numeração sequencial no resultado de uma consulta.

## Importante

`ROW_NUMBER()` não cria índice físico no banco. Ele cria uma numeração calculada no resultado. Para performance permanente, avalie índices reais com `CREATE INDEX` e plano de execução.
