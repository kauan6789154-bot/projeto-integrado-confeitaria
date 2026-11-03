# Registro 09 - Entrada e Saída de Estoque

## Objetivo
Implementar movimentações reais de estoque persistidas no MySQL.

## Funcionalidades
- entrada de estoque;
- saída de estoque;
- atualização do saldo do produto;
- validação de quantidade maior que zero;
- bloqueio de saída acima do saldo disponível;
- registro do usuário responsável;
- registro de motivo e observação;
- histórico persistido na tabela `movimentacao`.

## Integridade transacional
A atualização do estoque e a criação do registro de movimentação são executadas dentro da mesma transação.

Se ocorrer uma exceção, a transação é revertida e nenhuma alteração parcial permanece no banco.

## Concorrência
O produto é consultado com `FOR UPDATE` durante a transação para evitar alterações concorrentes incorretas no saldo.

## Próxima etapa
Parte 10 - Alertas e histórico.
