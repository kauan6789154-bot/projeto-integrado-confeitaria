# Modelo Lógico

## USUARIO
- id_usuario PK
- nome
- email UNIQUE
- senha_hash
- perfil
- ativo
- criado_em
- atualizado_em

## CATEGORIA
- id_categoria PK
- nome UNIQUE
- descricao
- ativo
- criado_em

## FORNECEDOR
- id_fornecedor PK
- cnpj UNIQUE
- razao_social
- nome_fantasia
- telefone
- email
- endereco
- ativo
- criado_em

## PRODUTO
- id_produto PK
- sku UNIQUE
- nome
- descricao
- unidade_medida
- quantidade_estoque
- estoque_minimo
- preco_custo
- preco_venda
- id_categoria FK
- id_fornecedor FK
- ativo
- criado_em
- atualizado_em

## MOVIMENTACAO
- id_movimentacao PK
- tipo
- quantidade
- motivo
- observacao
- data_hora
- id_produto FK
- id_usuario FK

## Chaves estrangeiras
- produto.id_categoria -> categoria.id_categoria
- produto.id_fornecedor -> fornecedor.id_fornecedor
- movimentacao.id_produto -> produto.id_produto
- movimentacao.id_usuario -> usuario.id_usuario
