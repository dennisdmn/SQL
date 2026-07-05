/*
    SQL do zero - SQL Server
    Roteiro pequeno para criar, popular, consultar, alterar e apagar com seguranca.
*/

-- 1. Criar um banco de estudo.
-- Rode apenas se quiser criar um banco novo.
/*
CREATE DATABASE EstudosSQL;
GO

USE EstudosSQL;
GO
*/

-- 2. Criar tabelas simples.
CREATE TABLE dbo.Cliente
(
    ClienteId INT IDENTITY(1,1) NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NULL,
    Ativo BIT NOT NULL CONSTRAINT DF_Cliente_Ativo DEFAULT (1),
    DataCadastro DATETIME2 NOT NULL CONSTRAINT DF_Cliente_DataCadastro DEFAULT SYSDATETIME(),
    CONSTRAINT PK_Cliente PRIMARY KEY (ClienteId)
);
GO

CREATE TABLE dbo.Pedido
(
    PedidoId INT IDENTITY(1,1) NOT NULL,
    ClienteId INT NOT NULL,
    DataPedido DATE NOT NULL,
    ValorTotal DECIMAL(18, 2) NOT NULL,
    CONSTRAINT PK_Pedido PRIMARY KEY (PedidoId),
    CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (ClienteId) REFERENCES dbo.Cliente (ClienteId)
);
GO

-- 3. Inserir dados.
INSERT INTO dbo.Cliente (Nome, Email)
VALUES
    ('Ana Souza', 'ana@email.com'),
    ('Bruno Lima', 'bruno@email.com'),
    ('Carla Dias', NULL);

INSERT INTO dbo.Pedido (ClienteId, DataPedido, ValorTotal)
VALUES
    (1, '2026-01-10', 150.00),
    (1, '2026-01-12', 280.50),
    (2, '2026-01-15', 90.00);

-- 4. Consultar dados.
SELECT *
FROM dbo.Cliente;

SELECT *
FROM dbo.Pedido;

-- 5. Atualizar com seguranca: sempre confira antes.
SELECT *
FROM dbo.Cliente
WHERE ClienteId = 3;

BEGIN TRAN;

UPDATE dbo.Cliente
SET Ativo = 0
WHERE ClienteId = 3;

SELECT *
FROM dbo.Cliente
WHERE ClienteId = 3;

-- Se estiver correto, confirme.
COMMIT;
-- Se estiver errado, use ROLLBACK no lugar do COMMIT.

-- 6. Apagar com seguranca: sempre confira o filtro antes.
SELECT *
FROM dbo.Pedido
WHERE PedidoId = 3;

BEGIN TRAN;

DELETE FROM dbo.Pedido
WHERE PedidoId = 3;

SELECT *
FROM dbo.Pedido
WHERE PedidoId = 3;

-- Confirme ou desfaça.
COMMIT;
-- ROLLBACK;

-- 7. Diferenca rapida entre DELETE, TRUNCATE e DROP.
-- DELETE: remove linhas e permite WHERE.
-- TRUNCATE: remove todas as linhas da tabela, sem WHERE, e costuma ser mais rapido.
-- DROP: remove a tabela inteira da estrutura do banco.

-- Exemplos perigosos: deixe comentado e rode somente em ambiente de teste.
/*
TRUNCATE TABLE dbo.Pedido;
DROP TABLE dbo.Pedido;
DROP TABLE dbo.Cliente;
*/
