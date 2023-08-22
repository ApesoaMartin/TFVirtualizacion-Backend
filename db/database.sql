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

CREATE TABLE Categoria (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE Articulo (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(100),
    fecha DATETIME,
    categoria INT NOT NULL,
    link VARCHAR(100),
    linkDisplay VARCHAR(100),
    PRIMARY KEY (id),
    FOREIGN KEY (categoria) REFERENCES Categoria(id)
);

CREATE TABLE Contenido (
    id INT NOT NULL AUTO_INCREMENT,
    cuerpo TEXT,
    clase VARCHAR(100) NOT NULL DEFAULT '',
    idArticulo INT NOT NULL,
    orden INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY (idArticulo) REFERENCES Articulo(id)
);

INSERT INTO Categoria (nombre) VALUES ('About'); -- Deberia ser ID 1
INSERT INTO Categoria (nombre) VALUES ('Principal'); -- Deberia ser ID 2

INSERT INTO Articulo (titulo, fecha, categoria, link) VALUES ("Martin Apesoa", NOW(), 1, 'Martin.ApesoaMartinez@alu.frt.utn.edu.ar');  -- ID 1
INSERT INTO Contenido (cuerpo, idArticulo) VALUES ('Estudiante de ingeniería en sistemas de información', 1);

INSERT INTO Articulo (titulo, fecha, categoria) VALUES ("Arquitectura de la solución", NOW(), 2); -- ID 2
INSERT INTO Contenido (cuerpo, orden, idArticulo) VALUES ('En la siguiente imagen se puede visualizar la arquitectura de la solución', 0, 2);
INSERT INTO Contenido (cuerpo, orden, idArticulo) VALUES ('{img arquitectura.png}', 1, 2);
INSERT INTO Contenido (cuerpo, orden, idArticulo) VALUES ('En la siguiente imagen se puede visualizar la arquitectura de la solución', 0, 2);
