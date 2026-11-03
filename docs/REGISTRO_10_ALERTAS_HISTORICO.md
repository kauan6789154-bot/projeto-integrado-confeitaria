# Registro 10 - Alertas e Histórico

## Objetivo

Adicionar consultas operacionais para acompanhamento do estoque e auditoria das movimentações.

## Funcionalidades implementadas

- identificação de produtos abaixo ou no estoque mínimo;
- exibição de aviso de reposição;
- consulta das últimas movimentações;
- exibição do tipo da movimentação;
- exibição do produto e da quantidade;
- exibição do motivo e da observação;
- identificação do usuário responsável;
- limite configurável de registros do histórico.

## Controle de acesso

As funcionalidades utilizam as permissões já definidas:

- `CONSULTAR_ESTOQUE`;
- `CONSULTAR_HISTORICO`.

Administrador e Operador possuem essas permissões na configuração atual.

## Banco de dados

Não foi necessária alteração na estrutura física do MySQL.

As funcionalidades utilizam as tabelas já existentes:

- produto;
- categoria;
- fornecedor;
- movimentacao;
- usuario.

## Resultado

A aplicação passa a permitir acompanhamento de estoque crítico e rastreabilidade das operações registradas no MySQL.

## Próxima etapa

Parte 11 - Integração e testes completos.
