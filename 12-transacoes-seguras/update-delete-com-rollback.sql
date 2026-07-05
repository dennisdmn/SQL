/*
    Transacoes seguras para UPDATE e DELETE
*/

-- 1. UPDATE seguro.
-- Primeiro confira as linhas.
SELECT *
FROM dbo.Cliente
WHERE ClienteId = 3;

BEGIN TRAN;

UPDATE dbo.Cliente
SET Ativo = 0
WHERE ClienteId = 3;

-- Confira o resultado dentro da transacao.
SELECT *
FROM dbo.Cliente
WHERE ClienteId = 3;

-- Se estiver certo:
COMMIT;

-- Se estiver errado, use isto no lugar do COMMIT:
-- ROLLBACK;

/* ------------------------------------------------------------ */

-- 2. DELETE seguro.
SELECT *
FROM dbo.Pedido
WHERE PedidoId = 10;

BEGIN TRAN;

DELETE FROM dbo.Pedido
WHERE PedidoId = 10;

-- Deve retornar zero linhas se apagou corretamente.
SELECT *
FROM dbo.Pedido
WHERE PedidoId = 10;

-- Confirme ou desfaça.
COMMIT;
-- ROLLBACK;

/* ------------------------------------------------------------ */

-- 3. Evite UPDATE sem WHERE.
-- Esse comando alteraria todas as linhas da tabela.
/*
UPDATE dbo.Cliente
SET Ativo = 0;
*/

-- 4. Evite DELETE sem WHERE.
-- Esse comando apagaria todas as linhas da tabela.
/*
DELETE FROM dbo.Cliente;
*/
