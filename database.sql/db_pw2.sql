-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2023 a las 04:05:53
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
(1, 'Historia', 'lightgoldenrodyellow'),
(2, 'Entretenimiento', 'lightsalmon'),
(3, 'Arte', 'lightpink'),
(4, 'Ciencia', 'lightgreen'),
(5, 'Geografía', 'lightblue');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida`
--

CREATE TABLE `partida` (
  `idPartida` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `puntosObtenidos` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `idPreguntaActual` int(11) DEFAULT NULL,
  `numPartidaDelJugador` int(11) NOT NULL DEFAULT 0,
  `terminada` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `partida`
--

INSERT INTO `partida` (`idPartida`, `idUsuario`, `puntosObtenidos`, `fecha`, `idPreguntaActual`, `numPartidaDelJugador`, `terminada`) VALUES
(169, 18, 3, '2023-06-25', 72, 1, 1),
(170, 18, 3, '2023-06-25', 60, 2, 1);

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
  `reportada` tinyint(1) NOT NULL DEFAULT 0,
  `motivo_reporte` varchar(500) DEFAULT NULL,
  `preguntaSugerida` tinyint(1) NOT NULL DEFAULT 0,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`pregunta_id`, `enunciado`, `respuestaA`, `respuestaB`, `respuestaC`, `respuestaD`, `respuesta_correcta`, `categoria_id`, `veces_correcta`, `veces_respondida`, `reportada`, `motivo_reporte`, `preguntaSugerida`, `fecha`) VALUES
(50, '¿Quién pintó la Mona Lisa?', 'Pablo Picasso', 'Leonardo da Vinci', 'Vincent van Gogh', 'Frida Kahlo', 'Leonardo da Vinci', 3, 1, 4, 0, NULL, 0, '2023-06-25'),
(51, '¿En qué año ocurrió la Revolución Rusa?', '1917', '1789', '1945', '1871', '1917', 1, 2, 8, 0, NULL, 0, '2023-06-25'),
(52, '¿Quién escribió la novela \"Cien años de soledad\"?', 'Gabriel García Márquez', 'Julio Cortázar', 'Jorge Luis Borges', 'Mario Vargas Llosa', 'Gabriel García Márquez', 2, 8, 14, 0, NULL, 0, '2023-06-25'),
(53, '¿Cuál es el elemento químico más abundante en la corteza terrestre?', 'Hierro', 'Carbono', 'Silicio', 'Oxígeno', 'Oxígeno', 4, 14, 15, 0, NULL, 0, '2023-06-25'),
(54, '¿En qué ciudad se encuentra la Torre Eiffel?', 'París', 'Londres', 'Roma', 'Nueva York', 'París', 5, 3, 4, 0, NULL, 0, '2023-06-25'),
(55, '¿En qué año se firmó la Declaración de Independencia de los Estados Unidos?', '1776', '1789', '1804', '1812', '1776', 1, 12, 23, 0, NULL, 0, '2023-06-25'),
(56, '¿Quién fue el primer presidente de Estados Unidos?', 'George Washington', 'Thomas Jefferson', 'Abraham Lincoln', 'John F. Kennedy', 'George Washington', 1, 1, 5, 0, NULL, 0, '2023-06-25'),
(57, '¿Cuál es la montaña más alta del mundo?', 'Monte Kilimanjaro', 'Monte Everest', 'Monte Aconcagua', 'Monte McKinley', 'Monte Everest', 5, 20, 24, 0, NULL, 0, '2023-06-25'),
(58, '¿Cuál es el río más largo del mundo?', 'Nilo', 'Amazonas', 'Misisipi', 'Yangtsé', 'Amazonas', 5, 8, 8, 0, NULL, 0, '2023-06-25'),
(59, '¿Quién descubrió la penicilina?', 'Alexander Fleming', 'Marie Curie', 'Albert Einstein', 'Isaac Newton', 'Alexander Fleming', 4, 8, 17, 0, NULL, 0, '2023-06-25'),
(60, '¿En qué año se fundó la compañía Apple?', '1976', '1984', '1991', '2001', '1976', 4, 2, 6, 0, NULL, 0, '2023-06-25'),
(61, '¿Quién pintó el famoso cuadro \"La noche estrellada\"?', 'Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Salvador Dalí', 'Vincent van Gogh', 3, 3, 7, 0, NULL, 0, '2023-06-25'),
(62, '¿Cuál es el país más grande del mundo en términos de superficie?', 'China', 'Estados Unidos', 'Rusia', 'India', 'Rusia', 5, 5, 10, 0, NULL, 0, '2023-06-25'),
(63, '¿En qué año se llevó a cabo la Revolución Francesa?', '1789', '1815', '1848', '1905', '1789', 1, 1, 4, 0, NULL, 0, '2023-06-25'),
(64, '¿Quién escribió la obra de teatro \"Romeo y Julieta\"?', 'William Shakespeare', 'Miguel de Cervantes', 'Jane Austen', 'Charles Dickens', 'William Shakespeare', 3, 4, 8, 0, NULL, 0, '2023-06-25'),
(65, '¿Cuál es el satélite natural de la Tierra?', 'Marte', 'Luna', 'Júpiter', 'Venus', 'Luna', 5, 2, 6, 0, NULL, 0, '2023-06-25'),
(66, '¿Quién es considerado el padre de la computación?', 'Alan Turing', 'Steve Jobs', 'Bill Gates', 'Mark Zuckerberg', 'Alan Turing', 4, 3, 11, 0, NULL, 0, '2023-06-25'),
(67, '¿En qué año se llevó a cabo la caída del Muro de Berlín?', '1989', '1975', '1991', '1961', '1989', 1, 3, 7, 0, NULL, 0, '2023-06-25'),
(68, '¿Cuál es el océano más grande del mundo?', 'Atlántico', 'Índico', 'Pacífico', 'Ártico', 'Pacífico', 5, 5, 13, 0, NULL, 0, '2023-06-25'),
(69, '¿Quién fue el primer hombre en pisar la Luna?', 'Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin', 'Alan Shepard', 'Neil Armstrong', 4, 2, 3, 0, NULL, 0, '2023-06-25'),
(70, '¿Quién escribió la novela \"1984\"?', 'George Orwell', 'Aldous Huxley', 'Ray Bradbury', 'Jorge Luis Borges', 'George Orwell', 2, 5, 8, 0, NULL, 0, '2023-06-25'),
(71, '¿En qué país se encuentra la ciudad de Machu Picchu?', 'Perú', 'Colombia', 'Brasil', 'México', 'Perú', 5, 5, 9, 0, NULL, 0, '2023-06-25'),
(72, '¿Cuál es el símbolo químico del oro?', 'Ag', 'Au', 'O', 'Hg', 'Au', 4, 1, 4, 0, NULL, 0, '2023-06-25'),
(73, '¿Cuál es la capital de Australia?', 'Sídney', 'Melbourne', 'Brisbane', 'Canberra', 'Sídney', 5, 3, 7, 0, NULL, 0, '2023-06-25'),
(74, '¿Quién pintó \"La persistencia de la memoria\", también conocida como \"Los relojes blandos\"?', 'Pablo Picasso', 'Salvador Dalí', 'Frida Kahlo', 'Diego Rivera', 'Salvador Dalí', 3, 5, 10, 0, NULL, 0, '2023-06-25'),
(75, '¿Cuál es el río más largo de África?', 'Nilo', 'Zambeze', 'Congo', 'Níger', 'Nilo', 5, 6, 10, 0, NULL, 0, '2023-06-25'),
(76, '¿En qué año se produjo el hundimiento del Titanic?', '1912', '1905', '1921', '1918', '1912', 1, 3, 6, 0, NULL, 0, '2023-06-25'),
(77, '¿Quién escribió \"Don Quijote de la Mancha\"?', 'Miguel de Cervantes', 'Gabriel García Márquez', 'William Shakespeare', 'Friedrich Nietzsche', 'Miguel de Cervantes', 3, 3, 4, 0, NULL, 0, '2023-06-25'),
(78, '¿Cuál es el planeta más grande del Sistema Solar?', 'Júpiter', 'Saturno', 'Neptuno', 'Urano', 'Júpiter', 4, 3, 6, 0, NULL, 0, '2023-06-25'),
(79, '¿Cuál es el monte más alto de África?', 'Monte Everest', 'Monte Kilimanjaro', 'Monte Aconcagua', 'Monte McKinley', 'Monte Kilimanjaro', 5, 3, 7, 0, NULL, 0, '2023-06-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta_sugerida`
--

CREATE TABLE `pregunta_sugerida` (
  `id_sugerencia` int(11) NOT NULL,
  `enunciado_s` varchar(260) DEFAULT NULL,
  `respuestaA_s` varchar(100) DEFAULT NULL,
  `respuestaB_s` varchar(100) DEFAULT NULL,
  `respuestaC_s` varchar(100) DEFAULT NULL,
  `respuestaD_s` varchar(100) DEFAULT NULL,
  `respuesta_correcta_s` varchar(100) NOT NULL,
  `categoria_id_s` int(11) DEFAULT NULL,
  `creado_por` varchar(25) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pregunta_sugerida`
--

INSERT INTO `pregunta_sugerida` (`id_sugerencia`, `enunciado_s`, `respuestaA_s`, `respuestaB_s`, `respuestaC_s`, `respuestaD_s`, `respuesta_correcta_s`, `categoria_id_s`, `creado_por`, `estado`) VALUES
(8, 'asdasdd', 'dasdas', 'dasdsd', 'dasdasdsa', 'dasd', 'dasdasdsa', 4, 'fello', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta_usuario`
--

CREATE TABLE `pregunta_usuario` (
  `id_pregunta_usuario` int(11) NOT NULL,
  `idPartida` int(11) NOT NULL,
  `idPregunta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `respuesta` varchar(100) DEFAULT NULL,
  `estadoRespuesta` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pregunta_usuario`
--

INSERT INTO `pregunta_usuario` (`id_pregunta_usuario`, `idPartida`, `idPregunta`, `idUsuario`, `respuesta`, `estadoRespuesta`) VALUES
(204, 169, 71, 18, 'Perú', 1),
(205, 169, 52, 18, 'Gabriel García Márquez', 1),
(206, 169, 75, 18, 'Nilo', 1),
(207, 169, 72, 18, 'O', 0),
(208, 170, 68, 18, 'Pacífico', 1),
(209, 170, 67, 18, '1989', 1),
(210, 170, 70, 18, 'George Orwell', 1),
(211, 170, 60, 18, '2001', 0);

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
  `grupoEdad` varchar(20) NOT NULL,
  `genero` varchar(2) NOT NULL,
  `pais` varchar(120) NOT NULL,
  `ciudad` varchar(120) NOT NULL,
  `latitud` varchar(260) NOT NULL,
  `longitud` varchar(260) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contrasenia` varchar(250) NOT NULL,
  `hashRegistro` varchar(100) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `qr` varchar(140) NOT NULL,
  `fecha_registro` date NOT NULL,
  `idRol` int(11) NOT NULL,
  `url_imagen` varchar(250) NOT NULL,
  `puntosTotales` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--
INSERT INTO `usuario` (`idUsuario`, `nombre`, `apellido`, `nacimiento`, `grupoEdad`, `genero`, `pais`, `ciudad`, `latitud`, `longitud`, `email`, `contrasenia`, `hashRegistro`, `usuario`, `estado`, `qr`, `fecha_registro`, `idRol`, `url_imagen`, `puntosTotales`) VALUES
(21, 'Leo', 'Messi', '1992-01-03', 'mayor', 'M', 'Argentina', 'Lomas del Mirador', '-34.6656778', '-58.552274', 'ivandp6880@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'fcd2324cb4e9be6e33aabfeb9be8c424', 'lmessi', 1, '', '2023-06-13', 3, './uploads/lmessi.jpg', 12),
(22, 'Ivan', 'Del Pino', '1992-01-03', 'menor', 'M', 'Argentina', 'Ramos Mejia', '-34.6390979', '-58.5679998', 'ivangdelpino4@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '9c011f5f48c9a41931c39c2d416714ee', 'ivan6880', 1, '', '2023-06-20', 2, './uploads/ivan6880.jpg', 0),
(23, 'El admin', 'apellido Admin', '1983-02-10', 'mayor', 'X', 'Brasil', 'Fortaleza ', '-3.7325021226167485', '-38.52579858170485', 'admin@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '8222e1552ec49ba4afaeb7e7c32da819', 'EL admin', 1, '', '2023-06-23', 1, './uploads/EL admin.jpg', 0),
(28, 'Ale', 'Paz', '1992-09-05', 'menor', 'M', 'Argentina', 'San Justo', '-34.6876029887841', '-58.56415346470932', 'alepaz@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '7e0a842089712fe856ca1d0aa557b5db', 'ale_paz', 1, '', '2023-06-26', 3, './uploads/ale_paz.png', 0),
(29, 'Jacqui', 'Uran', '1997-10-04', 'medio', 'F', 'Uruguay', 'Maldonado', '-34.90278744370515', '-54.95039500343634', 'jacquiuran@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'd5f0084f5144858516d20297642d3389', 'jacqui_uran', 1, '', '2023-06-26', 3, './uploads/jacqui_uran.png', 0),
(30, 'Fabio', 'Torres', '1978-03-15', 'mayor', 'M', 'Brasil', 'Rio de Janeiro', '-22.946287902972752', '-43.20901815826178', 'fabiotorres@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'f2afc4821fc940db35a7437a5cec9e41', 'fabiotorres', 1, '', '2023-06-26', 3, './uploads/fabiotorres.jpg', 0);

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
  ADD PRIMARY KEY (`idPartida`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`pregunta_id`);

--
-- Indices de la tabla `pregunta_sugerida`
--
ALTER TABLE `pregunta_sugerida`
  ADD PRIMARY KEY (`id_sugerencia`);

--
-- Indices de la tabla `pregunta_usuario`
--
ALTER TABLE `pregunta_usuario`
  ADD PRIMARY KEY (`id_pregunta_usuario`);

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
-- AUTO_INCREMENT de la tabla `partida`
--
ALTER TABLE `partida`
  MODIFY `idPartida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `pregunta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT de la tabla `pregunta_sugerida`
--
ALTER TABLE `pregunta_sugerida`
  MODIFY `id_sugerencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pregunta_usuario`
--
ALTER TABLE `pregunta_usuario`
  MODIFY `id_pregunta_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idRol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
