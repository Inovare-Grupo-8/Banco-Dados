CREATE DATABASE IF NOT EXISTS maos_amigas;
USE maos_amigas;

CREATE TABLE IF NOT EXISTS endereco (
	id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(8) NOT NULL,
    logradouro CHAR(200) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    numero VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(128) NOT NULL,
    cpf CHAR(11) NOT NULL,
    tipo VARCHAR(15), CONSTRAINT chk_tipo CHECK(tipo IN("valor social", "gratuidade")),
	renda DECIMAL(7,2),
    data_cadastro DATETIME NOT NULL,
    data_nascimento DATE NOT NULL,
    genero CHAR(1), CONSTRAINT chk_genero CHECK(genero IN("F", "M")),
    fk_endereco INT NOT NULL, CONSTRAINT endereco_usuario FOREIGN KEY (fk_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE IF NOT EXISTS telefone (
	id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    ddd CHAR(2) NOT NULL,
    prefixo CHAR(5) NOT NULL,
    sufixo CHAR(4) NOT NULL,
    whatsapp TINYINT NOT NULL, CONSTRAINT chk_whatsapp CHECK (whatsapp IN(0, 1)),
    fk_usuario INT NOT NULL, CONSTRAINT usuario_telefone FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS voluntario (
	id_voluntario INT PRIMARY KEY AUTO_INCREMENT,
    funcao VARCHAR(50) NOT NULL,
    fk_usuario INT NOT NULL, CONSTRAINT usuario_voluntario FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS doacao (
	id_doacao INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(4,2) NOT NULL,
    fk_usuario INT NOT NULL, CONSTRAINT usuario_doacao FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS especialidade (
	id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS consulta (
	id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    horario DATETIME NOT NULL,
    status VARCHAR(15) NOT NULL, CONSTRAINT chk_status CHECK (status IN("agendada", "reagendada", "realizada")),
    modalidade VARCHAR(15) NOT NULL, CONSTRAINT chk_modalidade CHECK (modalidade IN("online", "presencial")),
    local VARCHAR(100),
    observacoes VARCHAR(200),
    fk_especialidade INT NOT NULL, CONSTRAINT especialidade_consulta FOREIGN KEY (fk_especialidade) REFERENCES especialidade(id_especialidade),
    fk_cliente INT NOT NULL, CONSTRAINT cliente_consulta FOREIGN KEY (fk_cliente) REFERENCES usuario(id_usuario),
    fk_especialista INT NOT NULL, CONSTRAINT especialista_consulta FOREIGN KEY (fk_especialista) REFERENCES usuario(id_usuario)
);

select * from usuario;
select * from voluntario;
