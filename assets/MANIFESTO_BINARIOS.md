# Manifesto de Arquivos Binários e Grandes

Estes arquivos foram encontrados no Google Drive, mas não foram gravados diretamente no repositório porque são binários, compactados ou grandes demais para versionamento comum no Git.

Pasta de origem: `https://drive.google.com/drive/u/0/folders/1AfZIDEd4ftWv1d_dfTYk-qVUQtcBYoQN`

## Arquivos

| Arquivo | Tipo | Link no Drive | Recomendação |
| --- | --- | --- | --- |
| `IncorporandoSelectNoComando_PQ.xlsm` | Excel com macro | https://drive.google.com/file/d/1BWR9G4izbEKFTHjlCsaSeLQxa19x7eKR/view | Manter no Drive ou migrar futuramente para `examples/` usando Git LFS. |
| `14_Exemplo_Funcoes_GetDate (Agora) - Exemplo_PBI.pbix` | Power BI | https://drive.google.com/file/d/1CwnFZpqP81LOLE01vG4KXVT0GRxx0uxo/view | Manter no Drive; Git comum não é ideal para `.pbix`. |
| `ApresentacaoR01.pptx` | Apresentação | https://drive.google.com/file/d/1EOEE4KECFnvBl0YhCnd_QX3HLw0fBcdA/view | Manter no Drive ou converter o conteúdo para Markdown se for material didático. |
| `BASE.csv` | CSV grande, aproximadamente 159 MB | https://drive.google.com/file/d/1EdsQ3mcJ0IBROBakA7dL3TN5ElmUV17C/view | Não subir no Git comum; usar Drive, banco, armazenamento externo ou Git LFS. |
| `Apoio.zip` | Arquivo compactado | https://drive.google.com/file/d/1I1y0aSyREn8XRSHVI9y5gCL0-odEVcjp/view | Descompactar e avaliar arquivos internos antes de migrar. |

## Por que não colocar tudo no Git?

Git funciona muito bem para texto: `.sql`, `.md`, `.pq`, `.py`, `.csv` pequeno. Para arquivos grandes ou binários, cada alteração pode deixar o repositório pesado, dificultando clone, histórico e manutenção.

## Opções futuras

- Converter apresentações em documentação Markdown.
- Extrair consultas M de arquivos `.xlsm` ou `.pbix`, quando possível.
- Usar Git LFS para arquivos binários que realmente precisem morar no repositório.
- Manter bases grandes fora do Git e documentar o caminho de obtenção.
