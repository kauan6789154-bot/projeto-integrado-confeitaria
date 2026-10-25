-- ============================================================
-- PROJETO INTEGRADO - CONTROLE DE ESTOQUE DA CONFEITARIA
-- PARTE 2 - DADOS INICIAIS
-- Arquivo: 02_dados_iniciais.sql
-- ============================================================

USE confeitaria_estoque;

-- Usuários de teste.
-- Neste momento a senha é armazenada com SHA-256 apenas para
-- permitir testes locais. Na etapa da aplicação Dart a autenticação
-- será tratada pela lógica do sistema.
INSERT IGNORE INTO usuario
(nome, email, senha_hash, perfil)
VALUES
('Administrador', 'admin@confeitaria.local', SHA2('admin123', 256), 'ADMINISTRADOR'),
('Operador Estoque', 'operador@confeitaria.local', SHA2('operador123', 256), 'OPERADOR');

-- Categorias
INSERT IGNORE INTO categoria
(nome, descricao)
VALUES
('Ingredientes', 'Insumos utilizados na produção da confeitaria'),
('Embalagens', 'Caixas, potes, sacolas e outros materiais de embalagem'),
('Bebidas', 'Bebidas controladas no estoque'),
('Limpeza', 'Materiais de limpeza e higienização');

-- Fornecedores
INSERT IGNORE INTO fornecedor
(cnpj, razao_social, nome_fantasia, telefone, email, endereco)
VALUES
('12.345.678/0001-90', 'Distribuidora Doce Sabor Ltda.', 'Doce Sabor',
 '(19) 3333-1111', 'contato@docesabor.local', 'Rua das Flores, 120'),

('98.765.432/0001-10', 'Embalagens Primavera Ltda.', 'Primavera Embalagens',
 '(19) 3333-2222', 'vendas@primavera.local', 'Avenida Central, 450');

-- Produtos iniciais
INSERT IGNORE INTO produto
(sku, nome, descricao, unidade_medida, quantidade_estoque,
 estoque_minimo, preco_custo, preco_venda, id_categoria, id_fornecedor)
VALUES
('ING-001', 'Farinha de Trigo',
 'Farinha utilizada na produção de massas e bolos',
 'kg', 25.000, 10.000, 5.50, 0.00, 1, 1),

('ING-002', 'Leite Condensado',
 'Leite condensado utilizado em recheios e doces',
 'un', 40.000, 15.000, 6.90, 0.00, 1, 1),

('ING-003', 'Chocolate ao Leite',
 'Chocolate utilizado em coberturas e recheios',
 'kg', 18.000, 8.000, 31.00, 0.00, 1, 1),

('EMB-001', 'Caixa para Bolo M',
 'Caixa média utilizada para transporte de bolos',
 'un', 50.000, 20.000, 2.80, 5.50, 2, 2);
