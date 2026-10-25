# Projeto Integrado - Sistema de Controle de Estoque da Confeitaria

## Visão geral

Este projeto tem como objetivo desenvolver uma solução integrada para controle e gestão de estoque de uma confeitaria.

A aplicação principal será desenvolvida em Dart e executada integralmente no terminal/console, conforme orientação do professor. O sistema será integrado a um banco de dados MySQL, que também servirá como fonte de dados para análises e dashboards no Power BI.

## Problema identificado

A confeitaria necessita de maior controle sobre seus produtos e insumos, principalmente em relação a entradas e saídas de estoque, estoque mínimo, produtos com necessidade de reposição, histórico de movimentações, fornecedores, categorias e usuários responsáveis pelas operações.

## Objetivo geral

Desenvolver um sistema de controle de estoque em Dart, executado pelo terminal, integrado a um banco de dados MySQL e a um dashboard no Power BI.

## Objetivos específicos

- cadastrar categorias;
- cadastrar fornecedores;
- cadastrar produtos;
- cadastrar e autenticar usuários;
- registrar entradas de estoque;
- registrar saídas de estoque;
- impedir saídas maiores que o saldo disponível;
- identificar produtos abaixo do estoque mínimo;
- armazenar o histórico de movimentações;
- consultar informações do estoque;
- disponibilizar os dados do banco para análise no Power BI.

## Arquitetura definida

```text
USUÁRIO
   |
   v
APLICAÇÃO DART NO TERMINAL
   |
   | regras de negócio / POO
   v
MYSQL
   |
   v
POWER BI
```

## Tecnologias

- Dart
- MySQL
- MySQL Workbench
- Power BI
- Git
- GitHub
- Visual Studio Code

## Estrutura do projeto

```text
Projeto_Integrado_Confeitaria/
|
|-- app/
|-- database/
|-- powerbi/
|-- docs/
|   |-- modelagem/
|   |-- fluxogramas/
|   |-- relatorios/
|   |-- evidencias/
|   `-- REGISTRO_01_REPLANEJAMENTO.md
|
|-- README.md
|-- PLANO_DE_ETAPAS.md
`-- .gitignore
```

## Entidades principais previstas

- Usuario
- Categoria
- Fornecedor
- Produto
- Movimentacao

## Funcionamento planejado

```text
========================================
 SISTEMA DE ESTOQUE - CONFEITARIA
========================================

1 - Login
2 - Cadastrar categoria
3 - Cadastrar fornecedor
4 - Cadastrar produto
5 - Listar produtos
6 - Registrar entrada
7 - Registrar saída
8 - Consultar estoque
9 - Produtos abaixo do estoque mínimo
10 - Histórico de movimentações
0 - Sair
```

## Integração com as unidades de estudo

### Programação Orientada a Objetos
Uso de classes, objetos, encapsulamento, abstração, herança, polimorfismo e tratamento de exceções.

### Lógica de Programação
Uso de variáveis, funções, listas, mapas, estruturas condicionais e estruturas de repetição em Dart.

### Modelagem de Dados
Criação dos modelos conceitual, lógico e físico, normalização, chaves primárias, chaves estrangeiras e regras de integridade.

### Business Intelligence
Conexão do Power BI ao MySQL, tratamento no Power Query, relacionamentos, medidas DAX, KPIs e dashboard.

## ODS

O projeto está relacionado ao ODS 12 - Consumo e Produção Responsáveis, contribuindo para a redução de desperdícios e para uma gestão mais eficiente dos insumos da confeitaria.

## Status atual

Parte 1 revisada concluída:
- arquitetura alterada para aplicação em terminal;
- estrutura de pastas reorganizada;
- documentação inicial atualizada;
- plano de etapas definido;
- projeto preparado para continuar sendo versionado no GitHub.

## Próxima etapa

Parte 2 - Banco de dados MySQL definitivo.
