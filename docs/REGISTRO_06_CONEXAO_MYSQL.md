# Registro 06 - Conexão Dart com MySQL

## Objetivo
Integrar a aplicação Dart ao banco MySQL criado anteriormente.

## Atividades
- adição do pacote mysql_client_plus;
- configuração por arquivo .env;
- criação de DatabaseConfig;
- criação de DatabaseConnection;
- criação inicial de ProdutoRepository;
- criação de usuário MySQL próprio da aplicação;
- teste de conexão e consulta dos produtos reais do banco.

## Segurança
A senha do banco fica no arquivo local `.env`, que não deve ser versionado.

## Resultado esperado
Ao executar `dart run bin/testar_conexao.dart`, a aplicação deve conectar ao schema `confeitaria_estoque` e listar os produtos cadastrados.

## Próxima etapa
Parte 7 - Login e controle de acesso.
