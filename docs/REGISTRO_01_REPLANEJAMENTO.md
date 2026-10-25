# Registro 01 - Replanejamento da Arquitetura

**Data:** 25/10/2026

## Contexto

Após orientação do professor responsável, foi definido que a aplicação do Projeto Integrado não deverá utilizar interface web.

Dessa forma, a equipe revisou o planejamento técnico do projeto e definiu que o sistema será desenvolvido integralmente em Dart, com interação pelo terminal/console.

## Arquitetura anterior

```text
Interface Web
   |
Back-end Dart
   |
MySQL
   |
Power BI
```

## Arquitetura revisada

```text
Usuário
   |
Aplicação Dart no Terminal
   |
MySQL
   |
Power BI
```

## Decisões adotadas

- remoção da interface web;
- remoção da necessidade de HTML, CSS e JavaScript;
- remoção da necessidade de API HTTP;
- manutenção do Dart como linguagem principal da aplicação;
- manutenção do MySQL para persistência;
- manutenção do Power BI para análise dos dados;
- execução local da aplicação pelo terminal;
- manutenção do Git e GitHub para versionamento e registro de progresso.

## Resultado

A arquitetura foi simplificada e alinhada à orientação do professor, mantendo a integração entre Programação Orientada a Objetos, Lógica de Programação, Modelagem de Dados e Business Intelligence.

## Próximo passo

Criação do banco de dados MySQL definitivo do sistema.
