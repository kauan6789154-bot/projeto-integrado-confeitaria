-- ============================================================
-- PROJETO INTEGRADO - CONTROLE DE ESTOQUE DA CONFEITARIA
-- PARTE 2 - CONSULTAS DE TESTE
-- Arquivo: 03_consultas_teste.sql
-- ============================================================

USE confeitaria_estoque;

-- 1. Listar usuários
SELECT
    id_usuario,
    nome,
    email,
    perfil,
    ativo
FROM usuario;

-- 2. Listar categorias
SELECT *
FROM categoria
ORDER BY nome;

-- 3. Listar fornecedores
SELECT
    id_fornecedor,
    cnpj,
    razao_social,
    nome_fantasia,
    telefone,
    email
FROM fornecedor;

-- 4. Listar produtos com categoria e fornecedor
SELECT
    p.id_produto,
    p.sku,
    p.nome AS produto,
    p.unidade_medida,
    p.quantidade_estoque,
    p.estoque_minimo,
    p.preco_custo,
    p.preco_venda,
    c.nome AS categoria,
    f.nome_fantasia AS fornecedor
FROM produto p
INNER JOIN categoria c
    ON c.id_categoria = p.id_categoria
INNER JOIN fornecedor f
    ON f.id_fornecedor = p.id_fornecedor
ORDER BY p.nome;

-- 5. Produtos abaixo ou no estoque mínimo
SELECT
    id_produto,
    sku,
    nome,
    quantidade_estoque,
    estoque_minimo,
    unidade_medida
FROM produto
WHERE quantidade_estoque <= estoque_minimo
ORDER BY nome;

-- 6. Quantidade de produtos cadastrados
SELECT COUNT(*) AS total_produtos
FROM produto;

-- 7. Valor total aproximado do estoque pelo custo
SELECT
    ROUND(SUM(quantidade_estoque * preco_custo), 2)
        AS valor_total_estoque
FROM produto;

-- 8. Histórico de movimentações
-- No início poderá retornar vazio, pois ainda não registramos
-- movimentações pela aplicação Dart.
SELECT
    m.id_movimentacao,
    m.data_hora,
    m.tipo,
    p.nome AS produto,
    m.quantidade,
    p.unidade_medida,
    m.motivo,
    u.nome AS usuario
FROM movimentacao m
INNER JOIN produto p
    ON p.id_produto = m.id_produto
INNER JOIN usuario u
    ON u.id_usuario = m.id_usuario
ORDER BY m.data_hora DESC;
