USE confeitaria_estoque;

-- 1. Quantidade das tabelas principais.
SELECT COUNT(*) AS tabelas_principais
FROM information_schema.tables
WHERE table_schema = 'confeitaria_estoque'
  AND table_name IN (
    'usuario',
    'categoria',
    'fornecedor',
    'produto',
    'movimentacao'
  );

-- 2. Usuários ativos.
SELECT id_usuario, nome, email, perfil, ativo
FROM usuario
WHERE ativo = TRUE
ORDER BY id_usuario;

-- 3. Produtos ativos e seus relacionamentos.
SELECT
    p.id_produto,
    p.sku,
    p.nome,
    p.quantidade_estoque,
    p.estoque_minimo,
    c.nome AS categoria,
    COALESCE(f.nome_fantasia, f.razao_social) AS fornecedor
FROM produto p
INNER JOIN categoria c
    ON c.id_categoria = p.id_categoria
INNER JOIN fornecedor f
    ON f.id_fornecedor = p.id_fornecedor
WHERE p.ativo = TRUE
ORDER BY p.id_produto;

-- 4. Movimentações com produto e usuário.
SELECT
    m.id_movimentacao,
    m.data_hora,
    m.tipo,
    p.nome AS produto,
    m.quantidade,
    u.nome AS usuario
FROM movimentacao m
INNER JOIN produto p
    ON p.id_produto = m.id_produto
INNER JOIN usuario u
    ON u.id_usuario = m.id_usuario
ORDER BY m.data_hora DESC;

-- 5. Verificação de integridade.
SELECT COUNT(*) AS inconsistencias
FROM movimentacao m
LEFT JOIN produto p
    ON p.id_produto = m.id_produto
LEFT JOIN usuario u
    ON u.id_usuario = m.id_usuario
WHERE p.id_produto IS NULL
   OR u.id_usuario IS NULL;

-- 6. Produtos críticos.
SELECT
    id_produto,
    sku,
    nome,
    quantidade_estoque,
    estoque_minimo
FROM produto
WHERE ativo = TRUE
  AND quantidade_estoque <= estoque_minimo
ORDER BY nome;
