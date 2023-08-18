CREATE DATABASE IF NOT EXISTS tpproxmox;

USE tpproxmox;

CREATE TABLE Comentarios (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100),
    texto VARCHAR(1000),
    fecha DATETIME,
    parentID INT,
    PRIMARY KEY (id),
    FOREIGN KEY (parentID) REFERENCES Comentarios(id)
);

DESCRIBE Comentarios;

--INSERT INTO Comentarios (nombre, texto, fecha, parentID)
--    VALUES ('Test1', 'Lorem ipsum lorem ipsum', NOW(), NULL);

--INSERT INTO Comentarios (nombre, texto, fecha, parentID)
    --VALUES ('Test2', 'Lorem ipsum 2 lorem ipsum 2', NOW(), 1);