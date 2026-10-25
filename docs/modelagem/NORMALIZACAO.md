# Normalização

## 1FN
Os atributos são atômicos e não há grupos repetitivos. Cada tabela possui chave primária.

## 2FN
Todos os atributos não-chave dependem integralmente da chave primária de sua tabela.

## 3FN
Não existem dependências transitivas inadequadas entre atributos não-chave.

Exemplos:
- o nome da categoria não é repetido em Produto; usa-se id_categoria;
- os dados do fornecedor não são repetidos em Produto; usa-se id_fornecedor;
- os dados do usuário não são repetidos em Movimentacao; usa-se id_usuario;
- os dados completos do produto não são repetidos em Movimentacao; usa-se id_produto.

## Resultado
O modelo está organizado até a Terceira Forma Normal (3FN), reduzindo redundância e facilitando manutenção, integridade e análise no Power BI.
