USE confeitaria_estoque;

SELECT *
FROM categoria
ORDER BY id_categoria;

SELECT *
FROM fornecedor
ORDER BY id_fornecedor;

SELECT
    p.id_produto,
    p.sku,
    p.nome,
    p.quantidade_estoque,
    p.estoque_minimo,
    p.unidade_medida,
    c.nome AS categoria,
    COALESCE(f.nome_fantasia, f.razao_social) AS fornecedor
FROM produto p
INNER JOIN categoria c
    ON c.id_categoria = p.id_categoria
INNER JOIN fornecedor f
    ON f.id_fornecedor = p.id_fornecedor
ORDER BY p.id_produto;
