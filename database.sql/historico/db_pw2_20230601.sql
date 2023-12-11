-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2023 at 08:04 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_pw2`
--

-- --------------------------------------------------------

--
-- Table structure for table `rol`
--

CREATE TABLE `rol` (
  `idRol` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rol`
--

INSERT INTO `rol` (`idRol`, `nombre`) VALUES
(1, 'administrador'),
(2, 'Editor'),
(3, 'Jugador');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `nacimiento` date NOT NULL,
  `genero` varchar(2) NOT NULL,
  `pais` varchar(120) NOT NULL,
  `ciudad` varchar(120) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contrasenia` varchar(250) NOT NULL,
  `hashRegistro` varchar(100) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `qr` varchar(140) NOT NULL,
  `fecha_registro` date NOT NULL,
  `idRol` int(11) NOT NULL,
  `url_imagen` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuario`
--


INSERT INTO `usuario` (`idUsuario`, `nombre`, `apellido`, `nacimiento`, `genero`, `pais`, `ciudad`, `email`, `contrasenia`, `hashRegistro`, `usuario`, `estado`, `qr`, `fecha_registro`, `idRol`, `url_imagen`) VALUES
(1, 'pablo', 'Perez', '2000-10-10', 'X', 'Argentina', 'Buenos Aires', 'pabloP@gmail.com', '1234', '', 'admin', 1, '', '2023-05-23', 1, ''),
(11, 'ale', 'paz', '1111-11-11', 'M', 'Argentina', 'asdas', 'ale@ale.com', '$2y$10$o7GynurOgfCttfpi2WZbc.8DzjC2Bdr3249mVre1jpJyNydz2WO7K', '', 'ale', 1, '', '2023-05-28', 3, ''),
(12, 'Alejandro', 'Paz', '1991-12-19', 'M', 'Argentina', 'Lomas del Mirador', 'alejandrodanielpaz92@gmail.com', '$2y$10$z3j2aUSXW40BTw3USqzjQ.KLJ7gJyxn8pgW.VBZ4n0yeQVut/2kKe', '', 'Ale1234', 1, '', '2023-05-29', 3, './uploads/asdasd.png'),
(13, 'Fabio', 'Perez', '1991-12-19', 'M', 'Argentina', 'Lomas del Mirador', 'apaz258@alumno.unlam.edu.ar', '$2y$10$sE/HKDcfSR6l7vQjuJbzzuxZDoe5WVI3ZFkdEbpmaQYsqMVhYxoJy', '', 'Fabio111', 1, '', '2023-05-29', 3, ''),
(14, 'Nico', 'Garrido', '1988-01-06', 'M', 'Argentina', 'Lomas del Mirador', 'garridonm@gmail.com', '$2y$10$jq30NL5YPV6QgQMejk0wue97LtlsQWOZCm1puieTEr3QRd9JpnsmG', '', 'Nico', 0, '', '2023-05-29', 3, ''),
(15, 'asda', 'asdas', '0000-00-00', 'X', 'Argentina', 'aad', 'ale@ale.com', '$2y$10$VsVCIQNz9MpxAk5HN15VDeOvkzM.64sqx6GkZ.XepHpB.SoGolYpu', '', 'asdasd', 0, '', '2023-05-29', 3, './uploads/asdasd.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idRol`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `idRol` (`idRol`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rol`
--
ALTER TABLE `rol`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
