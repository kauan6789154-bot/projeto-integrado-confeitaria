# Registro 11 - Integração e Testes Completos

## Objetivo

Validar as principais regras de negócio e a integração entre aplicação Dart e banco MySQL antes da etapa de Power BI.

## Testes automatizados

Foram adicionados testes para:

- entrada de estoque;
- saída de estoque;
- bloqueio de saída acima do saldo;
- rejeição de quantidade inválida;
- identificação de estoque crítico;
- permissões do Administrador;
- permissões do Operador.

## Teste de integração

O arquivo `bin/testar_integracao.dart` verifica:

- conexão com MySQL;
- schema ativo;
- existência das cinco tabelas principais;
- usuários ativos;
- produtos ativos;
- movimentações;
- integridade entre movimentação, produto e usuário;
- consulta de produtos abaixo do estoque mínimo.

## Comandos de validação

```bash
dart analyze
dart test
dart run bin/testar_integracao.dart
```

## Critério de aprovação

A etapa é considerada aprovada quando:

- `dart analyze` não encontra problemas;
- todos os testes automatizados passam;
- o teste de integração termina com `RESULTADO: INTEGRACAO APROVADA`.

## Próxima etapa

Parte 12 - Power BI conectado ao MySQL.
