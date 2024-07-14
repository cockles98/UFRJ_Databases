-- Tabela Tema
CREATE TABLE Tema (
    ID_Tema INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Tema VARCHAR(100) NOT NULL,
    Descrição TEXT,
    Coordenador_ID INT,
    FOREIGN KEY (Coordenador_ID) REFERENCES Pessoa(ID_Pessoa)
);

-- Tabela Comitê
CREATE TABLE Comitê (
    ID_Comitê INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Instituição VARCHAR(100) NOT NULL,
    ID_Tema INT,
    FOREIGN KEY (ID_Tema) REFERENCES Tema(ID_Tema)
);

-- Tabela Projeto
CREATE TABLE Projeto (
    ID_Projeto INT PRIMARY KEY AUTO_INCREMENT,
    Título VARCHAR(200) NOT NULL,
    Coordenador_ID INT,
    Orçamento DECIMAL(15, 2),
    Situação VARCHAR(50),
    Data_Início DATE,
    Data_Término DATE,
    ID_Tema INT,
    FOREIGN KEY (ID_Tema) REFERENCES Tema(ID_Tema),
    FOREIGN KEY (Coordenador_ID) REFERENCES Pessoa(ID_Pessoa)
);

-- Tabela Pessoa
CREATE TABLE Pessoa (
    ID_Pessoa INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Data_Nascimento DATE,
    RG VARCHAR(20),
    CPF VARCHAR(20) UNIQUE NOT NULL,
    Profissão VARCHAR(50),
    PIS_PASEP VARCHAR(20),
    Empresa VARCHAR(100)
);

-- Tabela Participação
CREATE TABLE Participação (
    ID_Participação INT PRIMARY KEY AUTO_INCREMENT,
    ID_Pessoa INT NOT NULL,
    Papel ENUM('Pesquisador', 'Desenvolvedor', 'Técnico', 'Estagiário', 'Consultor', 'Colaborador Externo') NOT NULL,
    Horas_Dedicadas INT,
    ID_Projeto INT,
    FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa(ID_Pessoa),
    FOREIGN KEY (ID_Projeto) REFERENCES Projeto(ID_Projeto)
);

-- Tabela Pesquisador
CREATE TABLE Pesquisador (
    ID_Participação INT PRIMARY KEY,
    Especialidade VARCHAR(100),
    Grau_Acadêmico VARCHAR(50),
    FOREIGN KEY (ID_Participação) REFERENCES Participação(ID_Participação)
);

-- Tabela Desenvolvedor
CREATE TABLE Desenvolvedor (
    ID_Participação INT PRIMARY KEY,
    Linguagem_Principal VARCHAR(50),
    Ferramentas_Usadas VARCHAR(100),
    FOREIGN KEY (ID_Participação) REFERENCES Participação(ID_Participação)
);

-- Tabela Técnico
CREATE TABLE Técnico (
    ID_Participação INT PRIMARY KEY,
    Área_Atuação VARCHAR(100),
    FOREIGN KEY (ID_Participação) REFERENCES Participação(ID_Participação)
);

-- Tabela Estagiário
CREATE TABLE Estagiário (
    ID_Participação INT PRIMARY KEY,
    Curso VARCHAR(100),
    Instituição VARCHAR(100),
    FOREIGN KEY (ID_Participação) REFERENCES Participação(ID_Participação)
);

-- Tabela Consultor
CREATE TABLE Consultor (
    ID_Participação INT PRIMARY KEY,
    Área_Consultoria VARCHAR(100),
    Empresa_Consultoria VARCHAR(100),
    FOREIGN KEY (ID_Participação) REFERENCES Participação(ID_Participação)
);

-- Tabela Colaborador Externo
CREATE TABLE Colaborador_Externo (
    ID_Participação INT PRIMARY KEY,
    Instituição VARCHAR(100),
    Função VARCHAR(100),
    FOREIGN KEY (ID_Participação) REFERENCES Participação(ID_Participação)
);

-- Tabela Espaço
CREATE TABLE Espaço (
    ID_Espaço INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereço TEXT NOT NULL,
    Contato VARCHAR(50),
    Capacidade INT,
    Horário_Funcionamento VARCHAR(100)
);

-- Tabela Documento
CREATE TABLE Documento (
    ID_Documento INT PRIMARY KEY AUTO_INCREMENT,
    Título VARCHAR(200) NOT NULL,
    Resumo TEXT,
    Data_Publicação DATE,
    Data_Revisão DATE,
    Autores TEXT,
    Corpo_Texto TEXT,
    Referências TEXT,
    Site VARCHAR(100),
    Local_Publicação VARCHAR(100),
    Prêmios TEXT,
    Índice_Citações TEXT
);