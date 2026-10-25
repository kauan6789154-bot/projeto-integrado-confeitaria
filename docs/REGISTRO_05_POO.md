# Registro 05 - Programação Orientada a Objetos

## Objetivo

Implementar os principais conceitos de Programação Orientada a Objetos na aplicação de controle de estoque.

## Conceitos aplicados

### Classes e objetos
Foram criadas classes para representar:
- Usuario;
- Administrador;
- Operador;
- Categoria;
- Fornecedor;
- Produto;
- Movimentacao;
- Entrada;
- Saida.

### Encapsulamento
A quantidade de estoque do Produto foi definida como atributo privado `_quantidadeEstoque`.

O acesso e a alteração ocorrem por métodos controlados:
- `quantidadeEstoque`;
- `adicionarEstoque`;
- `removerEstoque`.

### Abstração
As classes `Usuario` e `Movimentacao` foram definidas como abstratas.

### Herança
- Administrador herda de Usuario.
- Operador herda de Usuario.
- Entrada herda de Movimentacao.
- Saida herda de Movimentacao.

### Polimorfismo
Objetos Administrador e Operador podem ser tratados como Usuario.

Objetos Entrada e Saida podem ser tratados como Movimentacao, cada um implementando o método `aplicar()` de maneira diferente.

### Exceções
Foram criadas exceções próprias:
- EstoqueInsuficienteException;
- QuantidadeInvalidaException.

### Separação de responsabilidades
A classe `EstoqueService` centraliza o registro das movimentações e mantém um histórico temporário em memória.

## Resultado

A aplicação passou a representar o domínio da confeitaria por meio de objetos e regras encapsuladas, preparando o projeto para a integração com MySQL na próxima etapa.

## Próxima etapa

Parte 6 - Conexão Dart com MySQL.
