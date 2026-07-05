let
    /*
        Consulta com linguagem SQL nativa.
        Boa para empurrar filtros e selecao de colunas para o SQL Server.
    */

    NomeServidor = "NOTEBOOK-VAIO\\SQLEXPRESS",
    NomeBD = "AdventureWorksDW2016",

    Fonte = Sql.Database(
        NomeServidor,
        NomeBD,
        [
            Query = "
                SELECT
                    TabProd.ProductKey AS PROD_COD,
                    TabProd.EnglishProductName AS PROD_DES
                FROM DimProduct AS TabProd WITH (NOLOCK)
                WHERE TabProd.ProductKey >= 100
                  AND TabProd.ProductKey <= 300
            "
        ]
    )
in
    Fonte
