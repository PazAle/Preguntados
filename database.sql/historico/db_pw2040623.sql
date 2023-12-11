-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-06-2023 a las 01:08:18
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_pw2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `categoria_id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`categoria_id`, `nombre`, `color`) VALUES
(1, 'Historia', 'Amarillo'),
(2, 'Entretenimiento', 'Rosa'),
(3, 'Arte', 'Rojo'),
(4, 'Ciencia', 'Verde'),
(5, 'Geografía', 'blue');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida`
--

CREATE TABLE `partida` (
  `idPartida` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `puntosObtenidos` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `partida`
--

INSERT INTO `partida` (`idPartida`, `idUsuario`, `puntosObtenidos`, `fecha`) VALUES
(73, 21, 0, '2023-06-02'),
(75, 22, 0, '2023-06-02'),
(79, 22, 0, '2023-06-02'),
(80, 22, 0, '2023-06-02'),
(81, 22, 0, '2023-06-02'),
(82, 22, 0, '2023-06-02'),
(83, 22, 0, '2023-06-02'),
(84, 22, 0, '2023-06-02'),
(85, 22, 0, '2023-06-02'),
(86, 22, 0, '2023-06-02'),
(87, 22, 0, '2023-06-02'),
(88, 22, 0, '2023-06-02'),
(89, 22, 0, '2023-06-02'),
(90, 22, 0, '2023-06-02'),
(91, 22, 0, '2023-06-02'),
(92, 22, 0, '2023-06-02'),
(93, 22, 0, '2023-06-02'),
(94, 22, 0, '2023-06-02'),
(95, 22, 0, '2023-06-02'),
(96, 22, 0, '2023-06-02'),
(97, 22, 0, '2023-06-02'),
(98, 22, 0, '2023-06-02'),
(99, 22, 0, '2023-06-02'),
(100, 22, 0, '2023-06-02'),
(101, 22, 0, '2023-06-02'),
(102, 22, 0, '2023-06-03'),
(103, 22, 0, '2023-06-03'),
(104, 22, 0, '2023-06-03'),
(105, 22, 0, '2023-06-03'),
(106, 22, 0, '2023-06-03'),
(107, 22, 0, '2023-06-03'),
(108, 22, 0, '2023-06-03'),
(109, 22, 0, '2023-06-03'),
(110, 22, 0, '2023-06-03'),
(111, 22, 0, '2023-06-03'),
(112, 22, 0, '2023-06-03'),
(113, 22, 0, '2023-06-03'),
(114, 22, 0, '2023-06-03'),
(115, 22, 0, '2023-06-03'),
(116, 22, 0, '2023-06-03'),
(117, 22, 0, '2023-06-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `pregunta_id` int(11) NOT NULL,
  `enunciado` varchar(260) DEFAULT NULL,
  `respuestaA` varchar(100) DEFAULT NULL,
  `respuestaB` varchar(100) DEFAULT NULL,
  `respuestaC` varchar(100) DEFAULT NULL,
  `respuestaD` varchar(100) DEFAULT NULL,
  `respuesta_correcta` varchar(100) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `veces_correcta` int(11) DEFAULT 0,
  `veces_respondida` int(11) DEFAULT 0,
  `dificultad` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`pregunta_id`, `enunciado`, `respuestaA`, `respuestaB`, `respuestaC`, `respuestaD`, `respuesta_correcta`, `categoria_id`, `veces_correcta`, `veces_respondida`, `dificultad`) VALUES
(13, '¿Cuál es el río más largo del mundo?', 'Amazonas', 'Nilo', 'Mississippi', 'Yangtsé', 'Nilo', 5, 0, 0, ''),
(14, '¿Cuál es el capital de Francia?', 'Madrid', 'Londres', 'París', 'Roma', 'París', 5, 0, 0, ''),
(15, '¿Cuál es el río más largo del mundo?', 'Amazonas', 'Nilo', 'Yangtsé', 'Misisipi', 'Nilo', 5, 0, 0, ''),
(16, '¿Cuál es el elemento más abundante en la Tierra?', 'Oxígeno', 'Silicio', 'Hierro', 'Carbono', 'Oxígeno', 4, 0, 0, ''),
(17, '¿Quién pintó la Mona Lisa?', 'Pablo Picasso', 'Leonardo da Vinci', 'Vincent van Gogh', 'Salvador Dalí', 'Leonardo da Vinci', 3, 0, 0, ''),
(18, '¿Cuál es la montaña más alta del mundo?', 'K2', 'Monte Everest', 'Aconcagua', 'Mont Blanc', 'Monte Everest', 5, 0, 0, ''),
(19, '¿Cuál es la moneda oficial de Japón?', 'Dólar', 'Euro', 'Yen', 'Libra esterlina', 'Yen', 5, 0, 0, ''),
(20, '¿Quién escribió \"Don Quijote de la Mancha\"?', 'Miguel de Cervantes', 'Gabriel García Márquez', 'Jorge Luis Borges', 'William Shakespeare', 'Miguel de Cervantes', 3, 0, 0, ''),
(21, '¿Cuál es el país más grande del mundo en términos de superficie?', 'Estados Unidos', 'Rusia', 'China', 'Canadá', 'Rusia', 5, 0, 0, ''),
(22, '¿Cuál es el océano más grande del mundo?', 'Océano Pacífico', 'Océano Atlántico', 'Océano Índico', 'Océano Ártico', 'Océano Pacífico', 5, 0, 0, ''),
(23, '¿Quién descubrió América?', 'Cristóbal Colón', 'Fernando de Magallanes', 'Vasco da Gama', 'Hernán Cortés', 'Cristóbal Colón', 1, 0, 0, ''),
(24, '¿Cuál es el símbolo químico del oro?', 'Ag', 'Au', 'Pt', 'Hg', 'Au', 4, 0, 0, ''),
(25, '¿Cuál es el autor de la obra \"Romeo y Julieta\"?', 'William Shakespeare', 'Charles Dickens', 'Jane Austen', 'Fyodor Dostoyevsky', 'William Shakespeare', 3, 0, 0, ''),
(26, '¿Cuál es el planeta más grande del sistema solar?', 'Mercurio', 'Venus', 'Júpiter', 'Saturno', 'Júpiter', 5, 0, 0, ''),
(27, '¿Cuál es la fórmula química del agua?', 'H2O', 'CO2', 'NaCl', 'CH4', 'H2O', 4, 0, 0, ''),
(28, '¿Cuál es el capital de Francia?', 'Madrid', 'Londres', 'París', 'Roma', 'París', 5, 0, 0, ''),
(29, '¿Cuál es el río más largo del mundo?', 'Amazonas', 'Nilo', 'Yangtsé', 'Misisipi', 'Nilo', 5, 0, 0, ''),
(30, '¿Cuál es el elemento más abundante en la Tierra?', 'Oxígeno', 'Silicio', 'Hierro', 'Carbono', 'Oxígeno', 4, 0, 0, ''),
(31, '¿Quién pintó la Mona Lisa?', 'Pablo Picasso', 'Leonardo da Vinci', 'Vincent van Gogh', 'Salvador Dalí', 'Leonardo da Vinci', 3, 0, 0, ''),
(32, '¿Cuál es la montaña más alta del mundo?', 'K2', 'Monte Everest', 'Aconcagua', 'Mont Blanc', 'Monte Everest', 5, 0, 0, ''),
(33, '¿Cuál es la moneda oficial de Japón?', 'Dólar', 'Euro', 'Yen', 'Libra esterlina', 'Yen', 5, 0, 0, ''),
(34, '¿Quién escribió \"Don Quijote de la Mancha\"?', 'Miguel de Cervantes', 'Gabriel García Márquez', 'Jorge Luis Borges', 'William Shakespeare', 'Miguel de Cervantes', 3, 0, 0, ''),
(35, '¿Cuál es el país más grande del mundo en términos de superficie?', 'Estados Unidos', 'Rusia', 'China', 'Canadá', 'Rusia', 5, 0, 0, ''),
(36, '¿Cuál es el océano más grande del mundo?', 'Océano Pacífico', 'Océano Atlántico', 'Océano Índico', 'Océano Ártico', 'Océano Pacífico', 5, 0, 0, ''),
(37, '¿Quién descubrió América?', 'Cristóbal Colón', 'Fernando de Magallanes', 'Vasco da Gama', 'Hernán Cortés', 'Cristóbal Colón', 5, 0, 0, ''),
(38, '¿Cuál es el símbolo químico del oro?', 'Ag', 'Au', 'Pt', 'Hg', 'Au', NULL, 0, 0, ''),
(39, '¿Cuál es el autor de la obra \"Romeo y Julieta\"?', 'William Shakespeare', 'Charles Dickens', 'Jane Austen', 'Fyodor Dostoyevsky', 'William Shakespeare', NULL, 0, 0, ''),
(40, '¿Cuál es el planeta más grande del sistema solar?', 'Mercurio', 'Venus', 'Júpiter', 'Saturno', 'Júpiter', NULL, 0, 0, ''),
(41, '¿Cuál es la fórmula química del agua?', 'H2O', 'CO2', 'NaCl', 'CH4', 'H2O', NULL, 0, 0, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta_usuario`
--

CREATE TABLE `pregunta_usuario` (
  `id_pregunta_usuario` int(11) NOT NULL,
  `idPregunta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `estadoRespuesta` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idRol` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idRol`, `nombre`) VALUES
(1, 'administrador'),
(2, 'Editor'),
(3, 'Jugador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
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
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombre`, `apellido`, `nacimiento`, `genero`, `pais`, `ciudad`, `email`, `contrasenia`, `hashRegistro`, `usuario`, `estado`, `qr`, `fecha_registro`, `idRol`, `url_imagen`) VALUES
(1, 'pablo', 'Perez', '2000-10-10', 'X', 'Argentina', 'Buenos Aires', 'pabloP@gmail.com', '1234', '', 'admin', 1, '', '2023-05-23', 1, ''),
(21, 'Ivan', 'Dp', '1992-03-01', 'M', 'Argentina', 'Ramos Mejia', 'ivangdelpino4@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '2d299bf03bf64cf4c011c786e4bc53e4', 'ivandp', 1, '', '2023-05-31', 3, './uploads/ivandp.png'),
(22, 'Luis Agustin', 'Vega Dobal', '2023-06-15', 'X', 'Argentina', 'Hurlingham', 'agus_1201@hotmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '2f59aeef6c3b8e5804519db69a41daa1', 'fello', 1, '', '2023-06-02', 3, './uploads/fello.jpeg');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`categoria_id`);

--
-- Indices de la tabla `partida`
--
ALTER TABLE `partida`
  ADD PRIMARY KEY (`idPartida`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`pregunta_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `pregunta_usuario`
--
ALTER TABLE `pregunta_usuario`
  ADD PRIMARY KEY (`id_pregunta_usuario`),
  ADD KEY `idPregunta` (`idPregunta`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idRol`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `idRol` (`idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `categoria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `partida`
--
ALTER TABLE `partida`
  MODIFY `idPartida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `pregunta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `pregunta_usuario`
--
ALTER TABLE `pregunta_usuario`
  MODIFY `id_pregunta_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `partida`
--
ALTER TABLE `partida`
  ADD CONSTRAINT `partida_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`categoria_id`);

--
-- Filtros para la tabla `pregunta_usuario`
--
ALTER TABLE `pregunta_usuario`
  ADD CONSTRAINT `pregunta_usuario_ibfk_1` FOREIGN KEY (`idPregunta`) REFERENCES `preguntas` (`pregunta_id`),
  ADD CONSTRAINT `pregunta_usuario_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
