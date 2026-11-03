USE confeitaria_estoque;

-- Produtos abaixo ou no estoque mínimo.
SELECT
    p.id_produto,
    p.sku,
    p.nome,
    p.quantidade_estoque,
    p.estoque_minimo,
    p.unidade_medida,
    (p.estoque_minimo - p.quantidade_estoque) AS deficit,
    c.nome AS categoria,
    COALESCE(f.nome_fantasia, f.razao_social) AS fornecedor
FROM produto p
INNER JOIN categoria c
    ON c.id_categoria = p.id_categoria
INNER JOIN fornecedor f
    ON f.id_fornecedor = p.id_fornecedor
WHERE p.ativo = TRUE
  AND p.quantidade_estoque <= p.estoque_minimo
ORDER BY deficit DESC, p.nome;

-- Histórico das últimas movimentações.
SELECT
    m.id_movimentacao,
    m.data_hora,
    m.tipo,
    p.sku,
    p.nome AS produto,
    m.quantidade,
    p.unidade_medida,
    m.motivo,
    m.observacao,
    u.nome AS usuario,
    u.perfil
FROM movimentacao m
INNER JOIN produto p
    ON p.id_produto = m.id_produto
INNER JOIN usuario u
    ON u.id_usuario = m.id_usuario
ORDER BY m.data_hora DESC, m.id_movimentacao DESC
LIMIT 30;
