# Registro 02 - Criação do Banco de Dados MySQL

**Etapa:** Parte 2

## Objetivo

Criar a estrutura física inicial do banco de dados do sistema de controle de estoque da confeitaria.

## Banco definido

Nome do schema:

`confeitaria_estoque`

## Entidades criadas

- Usuario
- Categoria
- Fornecedor
- Produto
- Movimentacao

## Relacionamentos implementados

- Categoria 1:N Produto
- Fornecedor 1:N Produto
- Produto 1:N Movimentacao
- Usuario 1:N Movimentacao

## Regras de integridade aplicadas

- chaves primárias em todas as tabelas;
- chaves estrangeiras para garantir relacionamentos válidos;
- e-mail de usuário único;
- CNPJ de fornecedor único;
- SKU de produto único;
- quantidades e valores não negativos;
- movimentações obrigatoriamente com quantidade maior que zero;
- bloqueio de exclusão de registros que possuam dependências.

## Arquivos da etapa

- `database/01_schema.sql`
- `database/02_dados_iniciais.sql`
- `database/03_consultas_teste.sql`

## Resultado esperado

Ao executar os arquivos no MySQL Workbench, o schema `confeitaria_estoque` deverá ser criado com cinco tabelas relacionadas e dados iniciais suficientes para os primeiros testes.

## Próxima etapa

Parte 3 - Modelagem e documentação do banco de dados.
