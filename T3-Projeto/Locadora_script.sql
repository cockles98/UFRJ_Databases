-- Tabela Grupo
CREATE TABLE Grupo (
    ID_Grupo INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Grupo VARCHAR(50) NOT NULL,
    Descrição TEXT,
    Valor_Diária DECIMAL(10, 2) NOT NULL
);

-- Tabela Veículo
CREATE TABLE Veículo (
    ID_Veículo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Chassis VARCHAR(50) UNIQUE NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Cor VARCHAR(20) NOT NULL,
    Ar_Condicionado BOOLEAN,
    Mecanização ENUM('Manual', 'Automática'),
    Cadeirinha BOOLEAN,
    Dimensões VARCHAR(100),
    ID_Grupo INT,
    Lista_Acessórios TEXT,
    Fotos TEXT,
    Estado_Conservação TEXT,
    FOREIGN KEY (ID_Grupo) REFERENCES Grupo(ID_Grupo)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Tipo ENUM('Física', 'Jurídica') NOT NULL,
    CPF_CNPJ VARCHAR(20) UNIQUE NOT NULL,
    Endereço TEXT NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(50)
);

-- Tabela Motorista
CREATE TABLE Motorista (
    ID_Motorista INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CNH VARCHAR(20) UNIQUE NOT NULL,
    Data_Expiracao_CNH DATE,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Reserva
CREATE TABLE Reserva (
    ID_Reserva INT PRIMARY KEY AUTO_INCREMENT,
    Data_Reserva DATE NOT NULL,
    Data_Retirada DATE NOT NULL,
    Data_Devolucao DATE NOT NULL,
    ID_Veículo INT,
    ID_Cliente INT,
    Estado ENUM('Fila de Espera', 'Confirmada') NOT NULL,
    FOREIGN KEY (ID_Veículo) REFERENCES Veículo(ID_Veículo),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Locação
CREATE TABLE Locação (
    ID_Locação INT PRIMARY KEY AUTO_INCREMENT,
    Data_Retirada DATE NOT NULL,
    Hora_Retirada TIME NOT NULL,
    Data_Devolucao_Prevista DATE NOT NULL,
    Data_Devolucao_Realizada DATE,
    Hora_Devolucao TIME,
    Patio_Saida VARCHAR(50),
    Patio_Chegada VARCHAR(50),
    ID_Cliente INT,
    ID_Veículo INT,
    Estado_Entrega TEXT,
    Estado_Devolucao TEXT,
    Proteções_Adicionais TEXT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (ID_Veículo) REFERENCES Veículo(ID_Veículo)
);