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
