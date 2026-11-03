USE confeitaria_estoque;

-- Produtos e saldo atual
SELECT
    id_produto,
    sku,
    nome,
    quantidade_estoque,
    estoque_minimo,
    unidade_medida
FROM produto
ORDER BY id_produto;

-- Movimentacoes reais gravadas pela aplicacao
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
ORDER BY m.id_movimentacao DESC;
