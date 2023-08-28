CREATE DATABASE IF NOT EXISTS tpproxmox;

USE tpproxmox;

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

INSERT INTO Categoria (id, nombre) VALUES (1, "Personal");
INSERT INTO Categoria (id, nombre) VALUES (2, "Desarrollo");

INSERT INTO Articulo (id, titulo, fecha, categoria, link, linkDisplay) VALUES (1, 'Martin Apesoa', NOW(), 1, 'Martin.ApesoaMartinez@alu.frt.utn.edu.ar', NULL);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('Estudiante de 5to de Ingenieria en Sistemas de Informacion en la UTN FRT', '', 1, 0);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('Experiencia en desarrollo de software con Java y C#.', '', 1, 1);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('Experiencia en desarrollo de videojuegos con Unity y XNA', '', 1, 2);

INSERT INTO Articulo (id, titulo, fecha, categoria, link, linkDisplay) VALUES (2, 'Situacion', NOW(), 2, NULL, NULL);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('Despliegue de un servicio de blog personal dentro de contenedores utilizando la herramienta Proxmox.', 'text-justify', 2, 0);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('Dichos contenedores constan de:', '', 2, 1);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('{list 128 Mb de memoria, 1 nucleo de procesador, 8 Gb de almacenamiento, Conexion DHCP a red}', '', 2, 2);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('', '', 2, 6);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('Se debe poder acceder al servicio de forma externa por un navegador, por medio de redireccion de puertos.', 'text-justify', 2, 7);

INSERT INTO Articulo (id, titulo, fecha, categoria, link, linkDisplay) VALUES (3, 'Arquitectura', NOW(), 2, '/archivos', 'Ver informe');
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES (
    'Para resolver esta situacion se planteo utilizar Node JS, un entorno de ejecucion para JavaScript, en ambos contenedores. El usuario externo envia peticiones HTTP desde su navegador a Proxmox, las cuales son recibidas por el contenedor A por medio de redireccion de puertos. Finalmente, estas son interpretadas por un servicio en ejecucion en Node JS dentro del contenedor A, lo cual permite ejecutar codigo javascript del lado del contenedor para comunicarse con el backend por medio de la red interna.
     
     A su vez, los datos necesarios son alojados en una base de datos Mariadb dentro del contenedor DB. Una vez que todos los datos necesarios son retornados al frontend, este se encarga de devolver el texto HTML, CSS y JS correspondiente al usuario externo para que se visualice la interfaz web.', 'text-justify', 3, 0);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('Visualizacion de la arquitectura', 'text-center', 3, 1);
INSERT INTO Contenido (cuerpo, clase, idArticulo, orden) VALUES ('{img arquitectura.png}', 'arquitectura text-center', 3, 2);
