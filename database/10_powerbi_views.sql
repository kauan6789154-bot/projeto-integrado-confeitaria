-- ============================================================
-- PROJETO INTEGRADO - CONTROLE DE ESTOQUE DA CONFEITARIA
-- PARTE 12 - VIEWS PARA POWER BI
-- ============================================================

USE confeitaria_estoque;

DROP VIEW IF EXISTS vw_bi_movimentacoes;
DROP VIEW IF EXISTS vw_bi_produtos;

CREATE VIEW vw_bi_produtos AS
SELECT
    p.id_produto,
    p.sku,
    p.nome AS produto,
    p.descricao,
    p.unidade_medida,
    p.quantidade_estoque,
    p.estoque_minimo,
    p.preco_custo,
    p.preco_venda,
    ROUND(p.quantidade_estoque * p.preco_custo, 2) AS valor_estoque_atual,
    CASE
        WHEN p.quantidade_estoque <= p.estoque_minimo THEN 'CRITICO'
        ELSE 'NORMAL'
    END AS status_estoque,
    p.id_categoria,
    c.nome AS categoria,
    p.id_fornecedor,
    COALESCE(f.nome_fantasia, f.razao_social) AS fornecedor,
    p.ativo
FROM produto p
INNER JOIN categoria c
    ON c.id_categoria = p.id_categoria
INNER JOIN fornecedor f
    ON f.id_fornecedor = p.id_fornecedor
WHERE p.ativo = TRUE;

CREATE VIEW vw_bi_movimentacoes AS
SELECT
    m.id_movimentacao,
    m.data_hora,
    DATE(m.data_hora) AS data_movimentacao,
    YEAR(m.data_hora) AS ano,
    MONTH(m.data_hora) AS mes_numero,
    DATE_FORMAT(m.data_hora, '%Y-%m') AS ano_mes,
    m.tipo,
    m.quantidade,
    CASE
        WHEN m.tipo = 'ENTRADA' THEN m.quantidade
        ELSE -m.quantidade
    END AS quantidade_assinada,
    ROUND(m.quantidade * p.preco_custo, 2) AS valor_estimado,
    m.motivo,
    m.observacao,
    m.id_produto,
    p.sku,
    p.nome AS produto,
    p.unidade_medida,
    p.id_categoria,
    c.nome AS categoria,
    p.id_fornecedor,
    COALESCE(f.nome_fantasia, f.razao_social) AS fornecedor,
    m.id_usuario,
    u.nome AS usuario,
    u.perfil
FROM movimentacao m
INNER JOIN produto p
    ON p.id_produto = m.id_produto
INNER JOIN categoria c
    ON c.id_categoria = p.id_categoria
INNER JOIN fornecedor f
    ON f.id_fornecedor = p.id_fornecedor
INNER JOIN usuario u
    ON u.id_usuario = m.id_usuario;

-- Validacao
SELECT * FROM vw_bi_produtos ORDER BY produto;
SELECT * FROM vw_bi_movimentacoes ORDER BY data_hora DESC;
