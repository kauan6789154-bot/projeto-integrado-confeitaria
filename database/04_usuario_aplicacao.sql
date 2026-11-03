-- PARTE 6 - USUARIO DA APLICACAO DART
-- Substitua SENHA_FORTE_AQUI por uma senha criada por voce.

CREATE USER IF NOT EXISTS 'confeitaria_app'@'localhost'
IDENTIFIED BY 'SENHA_FORTE_AQUI';

ALTER USER 'confeitaria_app'@'localhost'
IDENTIFIED BY 'SENHA_FORTE_AQUI';

CREATE USER IF NOT EXISTS 'confeitaria_app'@'127.0.0.1'
IDENTIFIED BY 'SENHA_FORTE_AQUI';

ALTER USER 'confeitaria_app'@'127.0.0.1'
IDENTIFIED BY 'SENHA_FORTE_AQUI';

GRANT SELECT, INSERT, UPDATE, DELETE
ON confeitaria_estoque.*
TO 'confeitaria_app'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON confeitaria_estoque.*
TO 'confeitaria_app'@'127.0.0.1';

FLUSH PRIVILEGES;

SELECT user, host, plugin
FROM mysql.user
WHERE user = 'confeitaria_app';
