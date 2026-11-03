# Relatório de Testes - Parte 11

## Escopo

Validação técnica do Sistema de Controle de Estoque da Confeitaria.

## Matriz de testes

| Teste | Resultado esperado |
|---|---|
| Entrada de estoque | Saldo aumenta |
| Saída de estoque | Saldo diminui |
| Saída acima do saldo | Operação bloqueada |
| Quantidade inválida | Exceção gerada |
| Estoque mínimo | Produto crítico identificado |
| Administrador | Possui permissões administrativas |
| Operador | Possui permissões operacionais |
| Operador - administração | Acesso administrativo negado |
| Conexão MySQL | Conexão realizada |
| Tabelas principais | 5 tabelas encontradas |
| Integridade de movimentações | 0 inconsistências |

## Execução

Executar, dentro de `app`:

```bash
dart analyze
dart test
dart run bin/testar_integracao.dart
```

## Situação

Preencher após a execução:

- Análise estática: ____________________
- Testes automatizados: ____________________
- Integração MySQL: ____________________
- Resultado geral: ____________________

## Observação

O teste de integração é somente leitura e não cria, altera ou exclui registros.
