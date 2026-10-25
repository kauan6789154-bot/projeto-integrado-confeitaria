-- ============================================================
-- PROJETO INTEGRADO - CONTROLE DE ESTOQUE DA CONFEITARIA
-- PARTE 2 - BANCO DE DADOS MYSQL
-- Arquivo: 01_schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS confeitaria_estoque
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE confeitaria_estoque;

-- ============================================================
-- TABELA: usuario
-- Responsável pelo acesso ao sistema e pelas movimentações.
-- ============================================================
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    perfil ENUM('ADMINISTRADOR', 'OPERADOR') NOT NULL DEFAULT 'OPERADOR',
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuario_email UNIQUE (email)
) ENGINE=InnoDB;

-- ============================================================
-- TABELA: categoria
-- Agrupa os itens do estoque.
-- ============================================================
CREATE TABLE IF NOT EXISTS categoria (
    id_categoria INT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria),
    CONSTRAINT uq_categoria_nome UNIQUE (nome)
) ENGINE=InnoDB;

-- ============================================================
-- TABELA: fornecedor
-- Armazena os fornecedores da confeitaria.
-- ============================================================
CREATE TABLE IF NOT EXISTS fornecedor (
    id_fornecedor INT UNSIGNED AUTO_INCREMENT,
    cnpj VARCHAR(18) NOT NULL,
    razao_social VARCHAR(150) NOT NULL,
    nome_fantasia VARCHAR(150),
    telefone VARCHAR(20),
    email VARCHAR(150),
    endereco VARCHAR(255),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_fornecedor PRIMARY KEY (id_fornecedor),
    CONSTRAINT uq_fornecedor_cnpj UNIQUE (cnpj)
) ENGINE=InnoDB;

-- ============================================================
-- TABELA: produto
-- Representa cada item controlado no estoque.
-- ============================================================
CREATE TABLE IF NOT EXISTS produto (
    id_produto INT UNSIGNED AUTO_INCREMENT,
    sku VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(255),
    unidade_medida VARCHAR(20) NOT NULL,
    quantidade_estoque DECIMAL(12,3) NOT NULL DEFAULT 0,
    estoque_minimo DECIMAL(12,3) NOT NULL DEFAULT 0,
    preco_custo DECIMAL(12,2) NOT NULL DEFAULT 0,
    preco_venda DECIMAL(12,2) NOT NULL DEFAULT 0,
    id_categoria INT UNSIGNED NOT NULL,
    id_fornecedor INT UNSIGNED NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT pk_produto PRIMARY KEY (id_produto),
    CONSTRAINT uq_produto_sku UNIQUE (sku),

    CONSTRAINT ck_produto_quantidade_estoque
        CHECK (quantidade_estoque >= 0),

    CONSTRAINT ck_produto_estoque_minimo
        CHECK (estoque_minimo >= 0),

    CONSTRAINT ck_produto_preco_custo
        CHECK (preco_custo >= 0),

    CONSTRAINT ck_produto_preco_venda
        CHECK (preco_venda >= 0),

    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria (id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_produto_fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES fornecedor (id_fornecedor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
-- TABELA: movimentacao
-- Mantém o histórico auditável de entradas e saídas.
-- ============================================================
CREATE TABLE IF NOT EXISTS movimentacao (
    id_movimentacao BIGINT UNSIGNED AUTO_INCREMENT,
    tipo ENUM('ENTRADA', 'SAIDA') NOT NULL,
    quantidade DECIMAL(12,3) NOT NULL,
    motivo VARCHAR(150) NOT NULL,
    observacao VARCHAR(255),
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_produto INT UNSIGNED NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,

    CONSTRAINT pk_movimentacao PRIMARY KEY (id_movimentacao),

    CONSTRAINT ck_movimentacao_quantidade
        CHECK (quantidade > 0),

    CONSTRAINT fk_movimentacao_produto
        FOREIGN KEY (id_produto)
        REFERENCES produto (id_produto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_movimentacao_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
-- ÍNDICES AUXILIARES
-- ============================================================
CREATE INDEX idx_produto_nome
    ON produto (nome);

CREATE INDEX idx_produto_categoria
    ON produto (id_categoria);

CREATE INDEX idx_produto_fornecedor
    ON produto (id_fornecedor);

CREATE INDEX idx_movimentacao_produto
    ON movimentacao (id_produto);

CREATE INDEX idx_movimentacao_usuario
    ON movimentacao (id_usuario);

CREATE INDEX idx_movimentacao_data_hora
    ON movimentacao (data_hora);
