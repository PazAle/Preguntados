<?php

class PartidaModel{

    private $database;
    private $resultadoCantidadpartidas;
    public function __construct($database)
    {
        $this->database = $database;
    }

    public function generarPartida($idUsuario, $fecha){

        $insert = 'INSERT INTO `partida`
                   (idUsuario, puntosObtenidos, fecha)' . "VALUES ('$idUsuario', '0', '$fecha')" . ";";

        $this->database->execute($insert);

        return $this->database->getLastInsertId();
    }

    public function actualizarPreguntaPartida($idPartida, $idPregunta, $idUsuario) {
        $sql = 'UPDATE `partida` SET idPreguntaActual = '.$idPregunta.' WHERE idPartida='.$idPartida;
        $this->database->execute($sql);

        $sql = 'INSERT INTO `pregunta_usuario` (idPartida, idPregunta, idUsuario) VALUES ('.$idPartida.','.$idPregunta.','.$idUsuario.')';
        $this->database->execute($sql);


    }

    public function updatePreguntaUsuario($idPartida, $idPregunta, $idUsuario, $strRespuesta) {

        $sql = 'UPDATE `pregunta_usuario` SET respuesta = "'.$strRespuesta.'" WHERE idPartida='.$idPartida.' AND idPregunta='.$idPregunta.' AND idUsuario='.$idUsuario.'';
        $this->database->execute($sql);

    }

    public function updateEstadoRespuesta($idPartida, $idPregunta, $idUsuario, $strRespuesta) {

        $sql = 'UPDATE `pregunta_usuario` SET estadoRespuesta = 1 WHERE idPartida='.$idPartida.' AND idPregunta='.$idPregunta.' AND idUsuario='.$idUsuario.'';
        $this->database->execute($sql);

    }


    public function obtenerPartida($idPartida){

        $query = 'SELECT * FROM `partida` WHERE idPartida = '.$idPartida;

        return $this->database->getOne($query);
    }

    public function contarPartidasQuetieneElJugador($idUsuario){

        $sql = 'SELECT count(*) numeroPartidas FROM `partida` WHERE idUsuario ='.$idUsuario.' AND terminada= 1';
        return $this->database->getOne($sql);

    }

    public function marcarComoTerminada($idPartida,$idUsuario){

        $numPartida=$this->contarPartidasQuetieneElJugador($idUsuario);

        $sql = 'UPDATE `partida` SET terminada = 1, numPartidaDelJugador='.$numPartida['numeroPartidas'].' + 1 WHERE idPartida='.$idPartida;

        $this->database->execute($sql);
    }


    public function actualizarPuntaje($idPartida){
        $sql = 'UPDATE `partida` SET puntosObtenidos = puntosObtenidos + 1 WHERE idPartida='.$idPartida;

        $this->database->execute($sql);

    }

    public function sumarPuntosTotales($idUsuario, $puntos){
        $sql = "UPDATE `usuario` SET puntosTotales = puntosTotales + $puntos WHERE idUsuario = $idUsuario";

        $this->database->execute($sql);
    }

}