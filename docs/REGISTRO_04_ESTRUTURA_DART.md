# Registro 04 - Estrutura da Aplicação Dart

## Objetivo

Criar a estrutura inicial da aplicação em Dart que será executada pelo terminal.

## Atividades realizadas

- criação do projeto Dart;
- criação do arquivo `pubspec.yaml`;
- definição do ponto de entrada `bin/main.dart`;
- criação das pastas de organização da aplicação;
- criação da configuração básica do sistema;
- criação de utilitário inicial para saída no console;
- preparação da arquitetura para POO, regras de negócio e persistência.

## Estrutura definida

```text
app/
|-- bin/
|-- lib/
|   |-- config/
|   |-- models/
|   |-- services/
|   |-- repositories/
|   |-- exceptions/
|   `-- utils/
|-- test/
|-- pubspec.yaml
`-- analysis_options.yaml
```

## Resultado esperado

Ao executar:

```bash
dart pub get
dart run
```

a aplicação deverá iniciar no terminal e exibir o nome do sistema e uma mensagem confirmando que a estrutura base foi carregada.

## Próxima etapa

Parte 5 - Programação Orientada a Objetos.
