# Relacionamentos e Integridade

## Categoria -> Produto
Cardinalidade 1:N.
Produto possui FK id_categoria.

## Fornecedor -> Produto
Cardinalidade 1:N.
Produto possui FK id_fornecedor.

## Produto -> Movimentacao
Cardinalidade 1:N.
Movimentacao possui FK id_produto.

## Usuario -> Movimentacao
Cardinalidade 1:N.
Movimentacao possui FK id_usuario.

## Regras de integridade
- usuario.email é único;
- categoria.nome é único;
- fornecedor.cnpj é único;
- produto.sku é único;
- quantidades e preços não podem ser negativos;
- movimentações devem ter quantidade maior que zero;
- exclusões de registros referenciados são restringidas.
