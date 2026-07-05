let
    /*
        Consulta convencional no Power Query:
        conecta ao SQL Server, navega ate a tabela e transforma em M.
    */

    NomeServidor = "NOTEBOOK-VAIO\\SQLEXPRESS",
    NomeBD = "AdventureWorksDW2016",

    Fonte = Sql.Database(
        NomeServidor,
        NomeBD
    ),

    dbo_DimProduct = Fonte{
        [
            Schema = "dbo",
            Item = "DimProduct"
        ]
    }[Data],

    LinhasFiltradas = Table.SelectRows(
        dbo_DimProduct,
        each [ProductKey] >= 100 and [ProductKey] <= 300
    ),

    SelecaoColunas = Table.SelectColumns(
        LinhasFiltradas,
        {
            "ProductKey",
            "EnglishProductName"
        }
    ),

    ColunasRenomeadas = Table.RenameColumns(
        SelecaoColunas,
        {
            {"ProductKey", "PROD_COD"},
            {"EnglishProductName", "PROD_DES"}
        }
    ),

    Buffer = Table.Buffer(ColunasRenomeadas)
in
    Buffer
