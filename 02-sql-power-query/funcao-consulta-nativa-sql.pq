(
    NomeServidorSQLServer as text,
    NomeBancoDados as text
) =>
let
    /*
        Funcao M para executar consulta SQL nativa em um servidor e banco informados.
    */

    Fonte = Sql.Database(
        NomeServidorSQLServer,
        NomeBancoDados,
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
