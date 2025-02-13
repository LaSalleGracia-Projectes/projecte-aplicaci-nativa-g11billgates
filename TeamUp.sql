-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: mysql
-- Tiempo de generación: 27-01-2025 a las 17:26:49
-- Versión del servidor: 9.2.0
-- Versión de PHP: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `TeamUp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Actividad`
--

DROP DATABASE IF EXISTS TeamUp;

CREATE DATABASE TeamUp DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE TeamUp;

CREATE TABLE `Actividad` (
  `IDActividad` int NOT NULL,
  `IDUsuario` int NOT NULL,
  `TipoActividad` varchar(200) DEFAULT NULL,
  `FechaRegistro` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Chat` (
  `IDChat` int NOT NULL,
  `IDMatch` int DEFAULT NULL,
  `FechaCreacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Juego` (
  `IDJuego` int NOT NULL,
  `NombreJuego` varchar(70) DEFAULT NULL,
  `Genero` varchar(50) DEFAULT NULL,
  `Descripcion` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `JuegoUsuario` (
  `IDUsuario` int NOT NULL,
  `IDJuego` int NOT NULL,
  `Estadisticas` text,
  `Preferencias` text,
  `NivelElo` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `MatchUsers` (
  `IDMatch` int NOT NULL,
  `IDUsuario1` int NOT NULL,
  `IDUsuario2` int NOT NULL,
  `FechaCreacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Mensaje` (
  `IDMensaje` int NOT NULL,
  `IDChat` int NOT NULL,
  `IDUsuario` int NOT NULL,
  `Tipo` varchar(100) DEFAULT NULL,
  `FechaEnvio` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE `Usuario` (
  `IDUsuario` int NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Correo` varchar(320) NOT NULL,
  `Contraseña` varchar(320) NOT NULL,
  `FotoPerfil` text,
  `Edad` int DEFAULT NULL,
  `Region` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `Actividad`
  ADD PRIMARY KEY (`IDActividad`,`IDUsuario`),
  ADD KEY `IDUsuario` (`IDUsuario`);

ALTER TABLE `Chat`
  ADD PRIMARY KEY (`IDChat`),
  ADD KEY `IDMatch` (`IDMatch`);

ALTER TABLE `Juego`
  ADD PRIMARY KEY (`IDJuego`);

ALTER TABLE `JuegoUsuario`
  ADD PRIMARY KEY (`IDUsuario`,`IDJuego`),
  ADD KEY `IDJuego` (`IDJuego`);

ALTER TABLE `MatchUsers`
  ADD PRIMARY KEY (`IDMatch`),
  ADD KEY `IDUsuario1` (`IDUsuario1`),
  ADD KEY `IDUsuario2` (`IDUsuario2`);

ALTER TABLE `Mensaje`
  ADD PRIMARY KEY (`IDMensaje`,`IDChat`,`IDUsuario`),
  ADD KEY `IDChat` (`IDChat`);

ALTER TABLE `Usuario`
  ADD PRIMARY KEY (`IDUsuario`);

ALTER TABLE `Actividad`
  MODIFY `IDActividad` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `Chat`
  MODIFY `IDChat` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `Juego`
  MODIFY `IDJuego` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `MatchUsers`
  MODIFY `IDMatch` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `Mensaje`
  MODIFY `IDMensaje` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `Usuario`
  MODIFY `IDUsuario` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `Actividad`
  ADD CONSTRAINT `Actividad_ibfk_1` FOREIGN KEY (`IDUsuario`) REFERENCES `Usuario` (`IDUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Chat`
  ADD CONSTRAINT `Chat_ibfk_1` FOREIGN KEY (`IDMatch`) REFERENCES `MatchUsers` (`IDMatch`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `JuegoUsuario`
  ADD CONSTRAINT `JuegoUsuario_ibfk_1` FOREIGN KEY (`IDUsuario`) REFERENCES `Usuario` (`IDUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `JuegoUsuario_ibfk_2` FOREIGN KEY (`IDJuego`) REFERENCES `Juego` (`IDJuego`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `MatchUsers`
  ADD CONSTRAINT `MatchUsers_ibfk_1` FOREIGN KEY (`IDUsuario1`) REFERENCES `Usuario` (`IDUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `MatchUsers_ibfk_2` FOREIGN KEY (`IDUsuario2`) REFERENCES `Usuario` (`IDUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Mensaje`
  ADD CONSTRAINT `Mensaje_ibfk_1` FOREIGN KEY (`IDChat`) REFERENCES `Chat` (`IDChat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Mensaje_ibfk_2` FOREIGN KEY (`IDUsuario`) REFERENCES `Usuario` (`IDUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


/*Inserts */;

--Insert en la tabla de usuario
INSERT INTO usuario (Nombre, Correo, Contraseña, FotoPerfil, Edad, Region) VALUES 
('Juan Pérez', 'juanperez@email.com', 'hashedpassword1', NULL, 25, 'Europa'),
('María López', 'marialopez@email.com', 'hashedpassword2', NULL, 22, 'América'),
('Carlos Gómez', 'carlosgomez@email.com', 'hashedpassword3', NULL, 30, 'Asia'),
('Laura Fernández', 'laurafernandez@email.com', 'hashedpassword4', NULL, 27, 'África'),
('Pedro Ramírez', 'pedroramirez@email.com', 'hashedpassword5', NULL, 29, 'Oceanía');

--Insert en l tabla de juego
INSERT INTO juego (NombreJuego, Genero, Descripcion) VALUES 
('League of Legends', 'MOBA', 'Juego de estrategia en equipo.'),
('Counter-Strike 2', 'FPS', 'Juego de disparos en primera persona.'),
('FIFA 24', 'Deportes', 'Juego de simulación de fútbol.'),
('Minecraft', 'Sandbox', 'Juego de construcción y supervivencia.'),
('Valorant', 'FPS', 'Shooter táctico en primera persona.');

--Insert en la tabla de juegousuario
INSERT INTO juegousuario (IDUsuario, IDJuego, Estadisticas, Preferencias, NivelElo) VALUES 
(1, 1, 'Kills: 500, Deaths: 200', 'Prefiere ADC', 1800),
(2, 2, 'Victorias: 120, Derrotas: 80', 'Prefiere Sniper', 1900),
(3, 3, 'Goles: 45, Asistencias: 30', 'Juega como delantero', 1750),
(4, 4, 'Bloques colocados: 5000', 'Modo Creativo', NULL),
(5, 5, 'K/D Ratio: 1.8', 'Prefiere Duelista', 1850);

--Insert en la tabla de actividad
INSERT INTO actividad (IDUsuario, TipoActividad, FechaRegistro) VALUES 
(1, 'Inicio de sesión', '2025-02-13 10:00:00'),
(2, 'Creó un nuevo match', '2025-02-13 10:15:00'),
(3, 'Se unió a un chat', '2025-02-13 10:30:00'),
(4, 'Actualizó su perfil', '2025-02-13 10:45:00'),
(5, 'Salió de un chat', '2025-02-13 11:00:00');

--Insert en la tabla de matchusers
INSERT INTO matchusers (IDUsuario1, IDUsuario2, FechaCreacion) VALUES 
(1, 2, '2025-02-13 11:10:00'),
(3, 4, '2025-02-13 11:20:00'),
(1, 5, '2025-02-13 11:30:00'),
(2, 3, '2025-02-13 11:40:00'),
(4, 5, '2025-02-13 11:50:00');

--Insert en la tabla de chat
INSERT INTO chat (IDMatch, FechaCreacion) VALUES 
(1, '2025-02-13 12:00:00'),
(2, '2025-02-13 12:10:00'),
(3, '2025-02-13 12:20:00'),
(4, '2025-02-13 12:30:00'),
(5, '2025-02-13 12:40:00');

--Insert en la tabla de mensaje
INSERT INTO mensaje (IDChat, IDUsuario, Tipo, FechaEnvio) VALUES 
(1, 1, 'Texto', '2025-02-13 12:05:00'),
(1, 2, 'Texto', '2025-02-13 12:06:00'),
(2, 3, 'Imagen', '2025-02-13 12:15:00'),
(3, 1, 'Texto', '2025-02-13 12:25:00'),
(4, 4, 'Emoji', '2025-02-13 12:35:00');
