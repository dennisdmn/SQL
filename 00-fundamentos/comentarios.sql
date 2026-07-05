/*
    Comentários em SQL
    ------------------
    Use comentários para explicar intenção, regra de negócio ou decisão técnica.
*/

SELECT
    /*
        Comentário de múltiplas linhas.
        Útil para explicar um bloco de lógica ou uma regra mais longa.
    */
    TabProd.ProductKey,

    -- A linha abaixo foi mantida como exemplo de coluna que pode ser ativada durante testes.
    -- TabProd.ProductAlternateKey AS COD,

    TabProd.EnglishProductName AS NOME

    -- Comentário de única linha.
FROM DimProduct AS TabProd WITH (NOLOCK);

/*
    Atenção sobre NOLOCK:
    - Pode ser útil em exploração e leitura rápida.
    - Pode retornar dados ainda não confirmados ou inconsistentes.
    - Evite em relatórios oficiais sem validar o impacto.
*/
