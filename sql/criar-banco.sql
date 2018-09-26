CREATE DATABASE IF NOT EXISTS kingshotel DEFAULT CHARACTER SET latin1;

USE kingshotel;

DROP TABLE IF EXISTS usuarios;

CREATE TABLE IF NOT EXISTS usuarios (
id INT NOT NULL auto_increment,
nome VARCHAR(255) NOT NULL DEFAULT "USUARIO",
usuario VARCHAR(32) NOT NULL,
senha VARCHAR(32) NOT NULL,
is_admin TINYINT(1) NOT NULL,

PRIMARY KEY (id),
UNIQUE(usuario, senha)
);

INSERT INTO usuarios (nome, usuario, senha, is_admin) VALUES
	("Admin", "admin", "admin", 1),
    ("Funcionario 1", "func1", "func1", 0),
    ("Funcionario 2", "func2", "func2", 0),
    ("Funcionario 3", "func3", "func3", 0),
    ("Funcionario 4", "func4", "func4", 0),
    ("Funcionario 5", "func5", "func5", 0),
    ("Victor", "adm_victor", "pass_victor", 1);


/*
DROP TABLE IF EXISTS quartos;

CREATE TABLE IF NOT EXISTS quartos (
id INT NOT NULL AUTO_INCREMENT,
tipo VARCHAR(32),
num INT,
banheiros INT,
camas INT,
ocupado TINYINT(1),
preco REAL,

PRIMARY KEY (id),
UNIQUE (num)
);


INSERT INTO quartos (tipo, num, banheiros, camas, ocupado, preco) VALUES 
	("Solteiro", 	101, 	1, 	1, 0, 0),
    ("Solteiro", 	102, 	1, 	1, 0, 0),
    ("Duplo", 		103, 	2, 	2, 0, 0),
    ("Casal", 		201, 	1, 	1, 0, 0),
    ("Casal", 		202, 	1, 	1, 0, 0),
    ("Casal", 		203, 	1, 	1, 0, 0),
    ("Master", 		204, 	2, 	1, 0, 0),
    ("Master", 		205, 	2, 	1, 0, 0),
    ("Superior", 	301, 	2, 	1, 0, 0);
*/