# Aplicação Dart - Controle de Estoque da Confeitaria

Esta pasta contém a aplicação principal do Projeto Integrado.

## Execução

No terminal, dentro da pasta `app`:

```bash
dart pub get
dart run
```

## Estrutura

```text
app/
|-- bin/
|   `-- main.dart
|
|-- lib/
|   |-- config/
|   |   `-- app_config.dart
|   |
|   |-- models/
|   |-- services/
|   |-- repositories/
|   |-- exceptions/
|   `-- utils/
|       `-- console.dart
|
|-- test/
|-- pubspec.yaml
`-- analysis_options.yaml
```

## Organização planejada

- `models`: classes do domínio;
- `services`: regras de negócio;
- `repositories`: persistência e acesso ao banco;
- `exceptions`: exceções personalizadas;
- `config`: configurações;
- `utils`: funções auxiliares;
- `bin/main.dart`: ponto de entrada da aplicação.

As implementações completas serão adicionadas nas próximas etapas.
