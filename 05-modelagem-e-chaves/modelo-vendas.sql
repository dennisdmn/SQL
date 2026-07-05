/*
    Modelo simples de vendas
    Exemplo didatico de dimensao, fato, chave primaria e chave estrangeira.
*/

CREATE TABLE dbo.DimCliente
(
    ClienteId INT NOT NULL,
    NomeCliente VARCHAR(100) NOT NULL,
    Cidade VARCHAR(80) NULL,
    CONSTRAINT PK_DimCliente PRIMARY KEY (ClienteId)
);

CREATE TABLE dbo.DimProduto
(
    ProdutoId INT NOT NULL,
    NomeProduto VARCHAR(100) NOT NULL,
    Categoria VARCHAR(80) NULL,
    CONSTRAINT PK_DimProduto PRIMARY KEY (ProdutoId)
);

CREATE TABLE dbo.FatoVenda
(
    VendaId INT IDENTITY(1,1) NOT NULL,
    ClienteId INT NOT NULL,
    ProdutoId INT NOT NULL,
    DataVenda DATE NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DECIMAL(18, 2) NOT NULL,
    CONSTRAINT PK_FatoVenda PRIMARY KEY (VendaId),
    CONSTRAINT FK_FatoVenda_DimCliente FOREIGN KEY (ClienteId) REFERENCES dbo.DimCliente (ClienteId),
    CONSTRAINT FK_FatoVenda_DimProduto FOREIGN KEY (ProdutoId) REFERENCES dbo.DimProduto (ProdutoId)
);

INSERT INTO dbo.DimCliente (ClienteId, NomeCliente, Cidade)
VALUES
    (1, 'Ana Souza', 'Sao Paulo'),
    (2, 'Bruno Lima', 'Rio de Janeiro'),
    (3, 'Carla Dias', 'Belo Horizonte');

INSERT INTO dbo.DimProduto (ProdutoId, NomeProduto, Categoria)
VALUES
    (10, 'Caderno', 'Papelaria'),
    (20, 'Caneta', 'Papelaria'),
    (30, 'Mochila', 'Acessorios');

INSERT INTO dbo.FatoVenda (ClienteId, ProdutoId, DataVenda, Quantidade, ValorUnitario)
VALUES
    (1, 10, '2026-01-10', 2, 15.00),
    (1, 20, '2026-01-10', 5, 3.50),
    (2, 30, '2026-01-12', 1, 120.00);

-- Consulta analitica usando as chaves do modelo.
SELECT
    Venda.VendaId,
    Cliente.NomeCliente,
    Produto.NomeProduto,
    Venda.DataVenda,
    Venda.Quantidade,
    Venda.ValorUnitario,
    Venda.Quantidade * Venda.ValorUnitario AS ValorTotal
FROM dbo.FatoVenda AS Venda
INNER JOIN dbo.DimCliente AS Cliente
    ON Cliente.ClienteId = Venda.ClienteId
INNER JOIN dbo.DimProduto AS Produto
    ON Produto.ProdutoId = Venda.ProdutoId;
